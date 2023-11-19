import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:story_app/const/api_path.dart';

class Network{
  Dio dio = Dio();
  Network({bool? addLogging=true}){
    dio.options=BaseOptions(
        baseUrl:baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json',
        }
    );
      dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        error: true,
        request: true
      ));


  }
}