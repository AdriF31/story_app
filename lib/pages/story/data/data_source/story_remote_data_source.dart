import 'dart:io';

import 'package:dio/dio.dart';
import 'package:story_app/core/error/exception.dart';
import 'package:story_app/core/network.dart';
import 'package:story_app/di/injection.dart';
import 'package:story_app/pages/story/data/models/story_detail_model.dart';
import 'package:story_app/pages/story/data/models/story_model.dart';
import 'package:story_app/utils/secure_storage.dart';

abstract class StoryRemoteDataSource {
  Future<StoryModel> getStory({int? location, int? page, int? size});

  Future<Response> postStory(
      {File? file, String? description, double? lat, double? lon});

  Future<StoryDetailModel> getDetailStory(String? id);
}

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  Network network = sl<Network>();

  @override
  Future<StoryModel> getStory({int? location, int? page, int? size}) async {
    try {
      var res = await network.dio.get(
        "/stories",
        queryParameters: {"location": location, "page": page, "size": size},
        options: Options(
          headers: {
            "Authorization": "bearer ${await SecureStorage.getToken()}"
          },
        ),
      );
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
      FormData data = lat != null && lat != 0 && lon != null && lon != 0
          ? FormData.fromMap(
              {
                'photo': await MultipartFile.fromFile(file?.path ?? "",
                    filename: fileName),
                'description': description,
                'lat': lat,
                'lon': lon
              },
            )
          : FormData.fromMap(
              {
                'photo': await MultipartFile.fromFile(file?.path ?? "",
                    filename: fileName),
                'description': description,
              },
            );
      var res = await network.dio.post(
        "/stories",
        data: data,
        options: Options(
          headers: {
            "Authorization": "bearer ${await SecureStorage.getToken()}"
          },
        ),
      );
      if (res.statusCode == 201) {
        return res;
      } else {
        throw ServerException(message: res.data['message']);
      }
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data?['message']);
    }
  }

  @override
  Future<StoryDetailModel> getDetailStory(String? id) async {
    try {
      var res = await network.dio.get(
        "/stories/$id",
        options: Options(
          headers: {
            "Authorization": "bearer ${await SecureStorage.getToken()}"
          },
        ),
      );
      if (res.statusCode == 200) {
        return StoryDetailModel.fromJson(res.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
