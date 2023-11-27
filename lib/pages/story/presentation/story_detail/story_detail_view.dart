import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/pages/story/presentation/cubit/story_cubit/story_cubit.dart';
import 'package:story_app/utils/google_maps_widget.dart';
import 'package:story_app/utils/theme/color.dart';
import 'package:story_app/utils/theme/text_style.dart';

class StoryDetailView extends StatelessWidget {
  const StoryDetailView({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> googleMapController = Completer();
    void openMaps(
        {required double? lat,
        required double? lon,
        required String? id,
        required String? title}) {
      showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: GoogleMapWidget(
                      gMapsController: googleMapController,
                      lat: lat,
                      lon: lon,
                      markers: {
                        Marker(
                            markerId: MarkerId(id ?? ""),
                            position: LatLng(lat ?? 0, lon ?? 0),
                            infoWindow: InfoWindow(title: title ?? ""))
                      },
                    ),
                  ),
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Story Detail"),
      ),
      body: BlocBuilder<StoryCubit, StoryState>(
        builder: (context, state) {
          return state.maybeWhen(successGetDetailStory: (data, placemark) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: divider)),
                            child: const Icon(FluentIcons.person_24_filled),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            data?.story?.name ?? "",
                            style: text18WhiteMedium,
                          ),
                          if (data?.story?.lat != null &&
                              data?.story?.lon != null) ...[
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  openMaps(
                                      lat: data?.story?.lat,
                                      lon: data?.story?.lon,
                                      id: data?.story?.id,
                                      title: placemark?.locality);
                                },
                                icon: Icon(FluentIcons.location_24_regular)),
                          ]
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CachedNetworkImage(
                      imageUrl: data?.story?.photoUrl ?? "https://",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) {
                        return Container(
                          height: 300,
                          color: divider,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(data?.story?.description ?? ""),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            );
          }, orElse: () {
            return const Center(
              child: SpinKitThreeBounce(
                size: 40,
                color: primaryColor,
              ),
            );
          });
        },
      ),
    );
  }
}
