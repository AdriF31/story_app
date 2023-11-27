import 'package:json_annotation/json_annotation.dart';
import 'package:story_app/pages/story/domain/entities/story_entity.dart';

part 'story_model.g.dart';

@JsonSerializable()
class StoryModel extends StoryEntity {
  final bool? error;
  final String? message;
  final List<ListStory>? listStory;

  const StoryModel({
    this.error,
    this.message,
    this.listStory,
  }) : super(error: error, message: message, listStory: listStory);

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryModelToJson(this);
}

@JsonSerializable()
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

  factory ListStory.fromJson(Map<String, dynamic> json) =>
      _$ListStoryFromJson(json);
  Map<String, dynamic> toJson() => _$ListStoryToJson(this);
}
