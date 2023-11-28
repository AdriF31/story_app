import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/pages/story/presentation/cubit/bottom_navigation_cubit/bottom_navigation_cubit.dart';
import 'package:story_app/pages/story/presentation/list_story/list_story_page.dart';
import 'package:story_app/pages/story/presentation/story_map/story_map_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int? selectedIndex = 0;
  BottomNavigationCubit cubit = BottomNavigationCubit();
  @override
  void initState() {
    cubit.changeIndex(index: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
              bloc: cubit,
              listener: (_, state) {
                state.when(initial: () {
                  selectedIndex = 0;
                }, changeIndex: (index) {
                  selectedIndex = index;
                  print("index: $index");
                });
              },
              builder: (_, state) {
                return NavigationBar(
                  destinations: const [
                    NavigationDestination(
                        icon: Icon(FluentIcons.home_20_filled), label: "Home"),
                    NavigationDestination(
                        icon: Icon(FluentIcons.map_24_filled),
                        label: "Story Map"),
                  ],
                  selectedIndex: selectedIndex!,
                  onDestinationSelected: (value) {
                    cubit.changeIndex(index: value);
                  },
                );
              }),
      body: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        bloc: cubit,
        builder: (_, state) {
          return state.maybeWhen(changeIndex: (index) {
            if (index == 0) {
              return const ListStoryPage();
            } else {
              return const StoryMapPage();
            }
          }, orElse: () {
            return const SizedBox.shrink();
          });
        },
      ),
    );
  }
}
