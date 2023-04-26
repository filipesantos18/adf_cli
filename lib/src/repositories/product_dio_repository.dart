import 'package:dio/dio.dart';

import '../models/course.dart';

class ProductDioRepository {
  Future<Course> findByName(String name) async {
    try {
      final response = await Dio().get(
        'http://localhost:8080/products',
        queryParameters: {
          'name': name,
        },
      );

      if (response.data.isEmpty) {
        throw Exception('Cannot find product');
      }

      return Course.fromMap(response.data.first);
    } on DioError {
      throw Exception();
    }
  }
}
