import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/common.dart';
import 'package:story_app/pages/story/presentation/cubit/position_cubit/position_cubit.dart';
import 'package:story_app/pages/story/presentation/cubit/story_cubit/story_cubit.dart';
import 'package:story_app/utils/app_decoration.dart';
import 'package:story_app/utils/elevated_button_widget.dart';
import 'package:story_app/utils/google_maps_widget.dart';
import 'package:story_app/utils/theme/color.dart';
import 'package:story_app/utils/theme/text_style.dart';

import '../../../../l10n/app_localizations.dart';

class PostStoryView extends StatelessWidget {
  const PostStoryView({super.key, this.callback});

  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController latController = TextEditingController();
    TextEditingController lonController = TextEditingController();
    GlobalKey<FormState> form = GlobalKey<FormState>();
    bool? isLoading = false;
    Completer<GoogleMapController> googleMapController = Completer();

    openMaps(LatLng? pos) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return PopScope(
              canPop: false,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: Stack(
                          children: [
                            GoogleMapWidget(
                                gMapsController: googleMapController,
                                myLocationButtonEnabled: true,
                                lat: pos?.latitude,
                                lon: pos?.longitude,
                                markers: {
                                  Marker(
                                      draggable: true,
                                      markerId: MarkerId("id"),
                                      position: LatLng(pos?.latitude ?? 0,
                                          pos?.longitude ?? 0),
                                      onDragEnd: ((newPosition) {
                                        context
                                            .read<PositionCubit>()
                                            .changePosition(
                                                coordinates: newPosition);
                                      }))
                                }),
                            const Positioned(
                              top: 10,
                              left: 10,
                              child: Tooltip(
                                message:
                                    "Tahan dan geser marker untuk memilih lokasi",
                                triggerMode: TooltipTriggerMode.tap,
                                child: Icon(
                                  FluentIcons.info_24_regular,
                                  color: primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButtonWidget(
                        margin: EdgeInsets.all(16),
                        buttonText: "Pilih",
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Post Story"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<StoryCubit, StoryState>(
          builder: (_, state) {
            return ElevatedButtonWidget(
              onPressed: () {
                if (form.currentState!.validate() &&
                    context.read<StoryCubit>().photo != null) {
                  context.read<StoryCubit>().postStory(
                      description: controller.text,
                      lat: context.read<PositionCubit>().coordinate?.latitude,
                      lon: context.read<PositionCubit>().coordinate?.longitude);
                } else {
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!.field_warning_message);
                }
              },
              buttonText: AppLocalizations.of(context)!.post,
              isLoading: isLoading,
            );
          },
        ),
      ),
      body: BlocConsumer<StoryCubit, StoryState>(
        listener: (_, state) {
          isLoading = state.maybeWhen(
              loadingPostStory: () => true, orElse: () => false);
          state.maybeWhen(
              successPostStory: (message) {
                Fluttertoast.showToast(msg: message ?? "");
                if (callback != null) {
                  callback!();
                }
                context.pop();
              },
              errorPostStory: (message) {
                Fluttertoast.showToast(msg: message ?? "");
              },
              orElse: () {});
        },
        builder: (_, state) {
          return Form(
            key: form,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        openDialog(context);
                        // context.read<StoryCubit>().getImage();
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: divider),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: context.read<StoryCubit>().photo != null
                            ? Image.file(
                                context.read<StoryCubit>().photo!,
                                height: 200,
                                fit: BoxFit.fitWidth,
                              )
                            : Center(
                                child: Icon(FluentIcons.add_24_filled),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.description,
                          semanticsLabel: "Deskripsi",
                          style: text18WhiteRegular,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: controller,
                          minLines: 1,
                          maxLines: 5,
                          decoration: customInputDecoration(
                            hintText: AppLocalizations.of(context)!.description,
                            prefixIcon: const Icon(
                              FluentIcons.pen_24_regular,
                              size: 28,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .email_empty_error;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    if (FlavorConfig.instance?.variables?['premium']!) ...[
                      SizedBox(
                        height: 24,
                      ),
                      BlocBuilder<PositionCubit, PositionState>(
                        builder: (context, state) {
                          return state.maybeWhen(success: (pos) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      openMaps(pos);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(FluentIcons.location_24_regular),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text("pick location"),
                                      ],
                                    )),
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Latitude",
                                            semanticsLabel: "Latitude",
                                            style: text18WhiteRegular,
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          TextField(
                                            controller: latController
                                              ..text = (pos?.latitude ?? "")
                                                  .toString(),
                                            readOnly: true,
                                            decoration: customInputDecoration(
                                                filled: true,
                                                hintText: "Latitude"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Longitude",
                                            semanticsLabel: "Longitude",
                                            style: text18WhiteRegular,
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          TextField(
                                            readOnly: true,
                                            controller: lonController
                                              ..text = (pos?.longitude ?? "")
                                                  .toString(),
                                            decoration: customInputDecoration(
                                                filled: true,
                                                hintText: "Longitude"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }, orElse: () {
                            return SizedBox.shrink();
                          });
                        },
                      ),
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Pilih SOurce"),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<StoryCubit>()
                              .getImage(source: ImageSource.camera);
                          context.pop();
                        },
                        child: Column(
                          children: [
                            Icon(
                              FluentIcons.camera_24_filled,
                              size: 50,
                            ),
                            Text(
                              "Kamera",
                              style: text18WhiteMedium,
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<StoryCubit>()
                              .getImage(source: ImageSource.gallery);
                          context.pop();
                        },
                        child: Column(
                          children: [
                            Icon(
                              FluentIcons.image_24_filled,
                              size: 50,
                            ),
                            Text(
                              "Galeri",
                              style: text18WhiteMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
