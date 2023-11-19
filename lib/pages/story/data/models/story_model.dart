// To parse this JSON data, do
//
//     final storyModel = storyModelFromJson(jsonString);


import 'dart:convert';

import 'package:story_app/pages/story/domain/entities/story_entity.dart';

StoryModel storyModelFromJson(String str) =>
    StoryModel.fromJson(json.decode(str));

String storyModelToJson(StoryModel data) => json.encode(data.toJson());

class StoryModel extends StoryEntity {
  final bool? error;
  final String? message;
  final List<ListStory>? listStory;

  const StoryModel({
    this.error,
    this.message,
    this.listStory,
  }) : super(error: error, message: message, listStory: listStory);

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        error: json["error"],
        message: json["message"],
        listStory: json["listStory"] == null
            ? []
            : List<ListStory>.from(
                json["listStory"]!.map((x) => ListStory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": listStory == null
            ? []
            : List<dynamic>.from(listStory!.map((x) => x.toJson())),
      };
}

class ListStory extends ListStoryEntity {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final DateTime? createdAt;
  final double? lat;
  final double? lon;

  const ListStory({
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

  factory ListStory.fromJson(Map<String, dynamic> json) => ListStory(
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
