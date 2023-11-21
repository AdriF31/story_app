import 'dart:io';

import 'package:dio/dio.dart';
import 'package:story_app/core/error/exception.dart';
import 'package:story_app/core/network.dart';
import 'package:story_app/di/injection.dart';
import 'package:story_app/pages/story/data/models/story_model.dart';
import 'package:story_app/utils/secure_storage.dart';

abstract class StoryRemoteDataSource {
  Future<StoryModel> getStory();

  Future<Response> postStory(
      {File? file, String? description, double? lat, double? lon});
}

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  Network network = sl<Network>();

  @override
  Future<StoryModel> getStory() async {
    try {
      var res = await network.dio.get("/stories",
          options: Options(headers: {
            "Authorization": "bearer ${await SecureStorage.getToken()}"
          }));
      if (res.statusCode == 200) {
        return StoryModel.fromJson(res.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Response> postStory(
      {File? file, String? description, double? lat, double? lon}) async {
    try {
      String? fileName = file?.path.split('/').last;
      FormData data = FormData.fromMap({
        'photo':
            await MultipartFile.fromFile(file?.path ?? "", filename: fileName),
        'description': description,
        'lat': lat,
        'lon': lon
      });
      var res = await network.dio.post("/stories",
          data: data,
          options: Options(headers: {
            "Authorization": "bearer ${await SecureStorage.getToken()}"
          }));
      if (res.statusCode == 200) {
        return res;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
