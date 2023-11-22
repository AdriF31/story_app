// To parse this JSON data, do
//
//     final storyDetailModel = storyDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:story_app/pages/story/domain/entities/story_detail_entity.dart';

StoryDetailModel storyDetailModelFromJson(String str) =>
    StoryDetailModel.fromJson(json.decode(str));

String storyDetailModelToJson(StoryDetailModel data) =>
    json.encode(data.toJson());

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
      StoryDetailModel(
        error: json["error"],
        message: json["message"],
        story: json["story"] == null ? null : Story.fromJson(json["story"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "story": story?.toJson(),
      };
}

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

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "lat": lat,
        "lon": lon,
      };
}
