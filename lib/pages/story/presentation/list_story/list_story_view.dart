import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/language/language_cubit.dart';
import 'package:story_app/pages/story/presentation/cubit/story_cubit/story_cubit.dart';
import 'package:story_app/routes/routes.dart';
import 'package:story_app/utils/secure_storage.dart';
import 'package:story_app/utils/theme/color.dart';
import 'package:story_app/utils/theme/text_style.dart';

class ListStoryView extends StatelessWidget {
  const ListStoryView({super.key});

  @override
  Widget build(BuildContext context) {
    RefreshController refreshController =
        RefreshController(initialRefresh: false);
    int? selectedIndex = 0;
    void onRefresh() {
      context.read<StoryCubit>().page = 0;
      context.read<StoryCubit>().listStory?.clear();
      context.read<StoryCubit>().getStories();
      refreshController.refreshCompleted();
    }

    void onLoad() {
      context.read<StoryCubit>().getStories();
      refreshController.loadComplete();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Story App"),
      ),
      endDrawer: Drawer(
        child: SafeArea(child: BlocBuilder<LanguageCubit, LocaleState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.change_language,
                    style: text18WhiteMedium,
                  ),
                  trailing: Transform.scale(
                    scale: 0.7,
                    child: AnimatedToggleSwitch.size(
                      fittingMode: FittingMode.preventHorizontalOverlapping,
                      current:
                          context.read<LanguageCubit>().switchValue ?? true,
                      values: const [true, false],
                      onChanged: (value) {
                        print(value);
                        if (value) {
                          context
                              .read<LanguageCubit>()
                              .getLanguage(value: value, code: 'en');
                        } else {
                          context
                              .read<LanguageCubit>()
                              .getLanguage(value: value, code: 'id');
                        }
                      },
                      styleBuilder: (b) => ToggleStyle(
                          indicatorColor: b ? Colors.blueAccent : Colors.red),
                      iconBuilder: (value) => value
                          ? const Text(
                              "EN",
                              style: text14WhiteBold,
                            )
                          : const Text(
                              "ID",
                              style: text14WhiteBold,
                            ),
                    ),
                  ),
                ),
                ListTile(
                    onTap: () async {
                      await SecureStorage.deleteAllSecureStorage();
                      Fluttertoast.showToast(msg: "logged out");
                      context.go(loginRoute);
                    },
                    title: Text(
                      AppLocalizations.of(context)!.sign_out,
                      style: text18WhiteMedium,
                    ),
                    trailing: const Icon(
                      FluentIcons.sign_out_24_filled,
                      size: 28,
                    )),
              ],
            );
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(postStoryRoute, extra: () {
            onRefresh();
          });
        },
        child: const Icon(FluentIcons.pen_24_regular),
      ),
      body: BlocConsumer<StoryCubit, StoryState>(
        listener: (_, state) {
          state.maybeWhen(
              errorGetStory: (message) {
                Fluttertoast.showToast(msg: message ?? "");
              },
              orElse: () {});
        },
        builder: (_, state) {
          return state.maybeWhen(loadingGetStory: (isFirstFetch) {
            return const Center(
                child: SpinKitThreeBounce(
              color: primaryColor,
              size: 40,
            ));
          }, successGetStory: (data) {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: onRefresh,
              onLoading: onLoad,
              enablePullDown: true,
              enablePullUp: true,
              header: const MaterialClassicHeader(),
              footer: const ClassicFooter(
                loadStyle: LoadStyle.ShowWhenLoading,
                completeDuration: Duration(milliseconds: 1000),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    context.read<StoryCubit>().listStory?.length ?? 0,
                    (index) => GestureDetector(
                      onTap: () {
                        context.push(detailStoryRoute,
                            extra: context
                                .read<StoryCubit>()
                                .listStory?[index]
                                .id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: divider)),
                                    child: const Icon(
                                        FluentIcons.person_24_filled),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    context
                                            .read<StoryCubit>()
                                            .listStory?[index]
                                            .name ??
                                        "",
                                    style: text18WhiteBold,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CachedNetworkImage(
                              imageUrl: context
                                      .read<StoryCubit>()
                                      .listStory?[index]
                                      .photoUrl ??
                                  "https://",
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fitWidth,
                              placeholder: (context, _) {
                                return Container(
                                  color: divider,
                                  width: double.infinity,
                                  height: 200,
                                );
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    context
                                            .read<StoryCubit>()
                                            .listStory?[index]
                                            .name ??
                                        "",
                                    style: text16WhiteBold,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    context
                                            .read<StoryCubit>()
                                            .listStory?[index]
                                            .description ??
                                        "",
                                    style: text16WhiteBold,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }, orElse: () {
            return const SizedBox.shrink();
          });
        },
      ),
    );
  }
}
