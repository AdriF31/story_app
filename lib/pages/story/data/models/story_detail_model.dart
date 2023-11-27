// To parse this JSON data, do
//
//     final storyDetailModel = storyDetailModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:story_app/pages/story/domain/entities/story_detail_entity.dart';

part 'story_detail_model.g.dart';

@JsonSerializable()
class StoryDetailModel extends StoryDetailEntity {
  final bool? error;
  final String? message;
  final Story? story;

  const StoryDetailModel({
    this.error,
    this.message,
    this.story,
  }) : super(error: error, message: message, story: story);

  factory StoryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryDetailModelToJson(this);
}

@JsonSerializable()
class Story extends StoryDetEntity {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final DateTime? createdAt;
  final double? lat;
  final double? lon;

  const Story({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  }) : super(
            id: id,
            name: name,
            description: description,
            photoUrl: photoUrl,
            createdAt: createdAt,
            lat: lat,
            lon: lon);

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
