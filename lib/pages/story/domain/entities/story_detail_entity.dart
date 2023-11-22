import 'package:equatable/equatable.dart';

class StoryDetailEntity extends Equatable {
  final bool? error;
  final String? message;
  final StoryDetEntity? story;

  const StoryDetailEntity({
    this.error,
    this.message,
    this.story,
  });

  @override
  List<Object?> get props => [error, message, story];
}

class StoryDetEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final DateTime? createdAt;
  final double? lat;
  final double? lon;

  const StoryDetEntity({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  });

  @override
  List<Object?> get props =>
      [id, name, description, photoUrl, createdAt, lat, lon];
}
