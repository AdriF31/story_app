import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/pages/story/presentation/cubit/position_cubit/position_cubit.dart';
import 'package:story_app/pages/story/presentation/cubit/story_cubit/story_cubit.dart';
import 'package:story_app/pages/story/presentation/post_story/post_story_view.dart';

class PostStoryPage extends StatelessWidget {
  const PostStoryPage({super.key, this.callback});

  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoryCubit>(
          create: (context) => StoryCubit(),
        ),
        BlocProvider(
          create: (context) => PositionCubit()..checkPermission(),
        ),
      ],
      child: PostStoryView(
        callback: callback,
      ),
    );
  }
}
