import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/pages/story/presentation/cubit/story_cubit.dart';
import 'package:story_app/pages/story/presentation/story_detail/story_detail_view.dart';

class StoryDetailPage extends StatelessWidget {
  const StoryDetailPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoryCubit()..getDetailStories(id: id),
      child: StoryDetailView(
        id: id,
      ),
    );
  }
}
