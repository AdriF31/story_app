import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/pages/story/presentation/cubit/story_cubit/story_cubit.dart';
import 'package:story_app/pages/story/presentation/list_story/list_story_view.dart';

class ListStoryPage extends StatelessWidget {
  const ListStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StoryCubit()..getStories(),
        ),
      ],
      child: const ListStoryView(),
    );
  }
}
