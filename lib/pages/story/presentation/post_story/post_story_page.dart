import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/pages/story/presentation/cubit/story_cubit.dart';
import 'package:story_app/pages/story/presentation/post_story/post_story_view.dart';

class PostStoryPage extends StatelessWidget {
  const PostStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoryCubit()..checkPermission(),
      child: const PostStoryView(),
    );
  }
}
