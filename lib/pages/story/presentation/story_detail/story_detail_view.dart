import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:story_app/pages/story/presentation/cubit/story_cubit.dart';
import 'package:story_app/utils/theme/color.dart';
import 'package:story_app/utils/theme/text_style.dart';

class StoryDetailView extends StatelessWidget {
  const StoryDetailView({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Story Detail"),
      ),
      body: BlocBuilder<StoryCubit, StoryState>(
        builder: (context, state) {
          if (state is OnSuccessGetDetailStory) {
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
                            state.data?.story?.name ?? "",
                            style: text18WhiteMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CachedNetworkImage(
                      imageUrl: state.data?.story?.photoUrl ?? "https://",
                      height: MediaQuery.of(context).size.height * 0.6,
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
                      child: Text(state.data?.story?.description ?? ""),
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: SpinKitThreeBounce(
              size: 40,
              color: primaryColor,
            ),
          );
        },
      ),
    );
  }
}
