import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/pages/story/presentation/cubit/position_cubit/position_cubit.dart';
import 'package:story_app/pages/story/presentation/cubit/story_cubit/story_cubit.dart';
import 'package:story_app/routes/routes.dart';
import 'package:story_app/utils/google_maps_widget.dart';
import 'package:story_app/utils/theme/color.dart';
import 'package:story_app/utils/theme/text_style.dart';

class StoryMapView extends StatelessWidget {
  const StoryMapView({super.key});

  @override
  Widget build(BuildContext context) {
    Set<Marker>? markers = {};
    Completer<GoogleMapController> googleMapController = Completer();
    return Scaffold(
      appBar: AppBar(
        title: Text('Story Map'),
      ),
      body: BlocBuilder<PositionCubit, PositionState>(
        builder: (context, state) {
          return state.maybeWhen(success: (pos) {
            return BlocConsumer<StoryCubit, StoryState>(
              listener: (_, state) {
                state.maybeWhen(
                    successGetStory: (data, placemark) {
                      data?.listStory?.forEach((element) {
                        markers.add(Marker(
                            markerId: MarkerId(element.id ?? ""),
                            position:
                                LatLng(element.lat ?? 0, element.lon ?? 0),
                            infoWindow: InfoWindow(title: element.name)));
                      });
                    },
                    orElse: () {});
              },
              builder: (_, state) {
                return state.maybeWhen(successGetStory: (data, placemark) {
                  return Stack(
                    children: [
                      GoogleMapWidget(
                          gMapsController: googleMapController,
                          lat: context
                              .read<PositionCubit>()
                              .coordinate
                              ?.latitude,
                          lon: context
                              .read<PositionCubit>()
                              .coordinate
                              ?.longitude,
                          markers: markers),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: List.generate(
                                    data?.listStory?.length ?? 0,
                                    (index) => GestureDetector(
                                          onTap: () {
                                            onCameraMove(
                                                lat: data?.listStory?[index]
                                                        .lat ??
                                                    0,
                                                long: data?.listStory?[index]
                                                        .lon ??
                                                    0,
                                                googleMapController:
                                                    googleMapController);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.4))
                                                ]),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            margin: EdgeInsets.all(8),
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: data
                                                          ?.listStory?[index]
                                                          .photoUrl ??
                                                      "https://",
                                                  width: 100,
                                                  height: double.infinity,
                                                ),
                                                const SizedBox(
                                                  width: 24,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data?.listStory?[index]
                                                                .name ??
                                                            "",
                                                        style: text16BlackBold,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          data
                                                                  ?.listStory?[
                                                                      index]
                                                                  .description ??
                                                              "",
                                                          style:
                                                              text14BlackBold,
                                                          maxLines: 5,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            context.push(
                                                                detailStoryRoute,
                                                                extra: context
                                                                    .read<
                                                                        StoryCubit>()
                                                                    .listStory?[
                                                                        index]
                                                                    .id);
                                                          },
                                                          child: const Text(
                                                            "Lihat detail",
                                                            style:
                                                                text16BlackRegular,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ))),
                          )),
                    ],
                  );
                }, orElse: () {
                  return const SizedBox.shrink();
                });
              },
            );
          }, orElse: () {
            return const Center(
              child: SpinKitThreeBounce(
                color: primaryColor,
              ),
            );
          });
        },
      ),
    );
  }

  onCameraMove(
      {required double lat,
      required double long,
      required Completer<GoogleMapController> googleMapController}) async {
    final GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, long),
          zoom: 16.0,
        ),
      ),
    );
  }
}
