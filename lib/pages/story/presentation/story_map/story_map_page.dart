import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/pages/story/presentation/cubit/position_cubit/position_cubit.dart';
import 'package:story_app/pages/story/presentation/cubit/story_cubit/story_cubit.dart';
import 'package:story_app/pages/story/presentation/story_map/story_map_view.dart';

class StoryMapPage extends StatelessWidget {
  const StoryMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StoryCubit()..getStories(location: 1, size: 100),
        ),
        BlocProvider(
          create: (context) => PositionCubit()..checkPermission(),
        ),
      ],
      child: const StoryMapView(),
    );
  }
}
