
import 'package:equatable/equatable.dart';


class StoryEntity extends Equatable {
  final bool? error;
  final String? message;
  final List<ListStoryEntity>? listStory;

  const StoryEntity({
    this.error,
    this.message,
    this.listStory,
  });
  @override
  List<Object?> get props => [error,message,listStory];
}


class ListStoryEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final DateTime? createdAt;
  final double? lat;
  final double? lon;

 const ListStoryEntity({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  });

  @override
  List<Object?> get props => [id,name,description,photoUrl,createdAt,lat,lon];

}
