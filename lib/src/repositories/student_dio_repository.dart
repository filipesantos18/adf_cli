import 'package:dio/dio.dart';

import '../models/student.dart';

class StudentDioRepository {
  Future<List<Student>> findAllStudents() async {
    try {
      final studentsResult = await Dio().get('http://localhost:8080/students');

      return studentsResult.data
          .map<Student>((student) => Student.fromMap(student))
          .toList();
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Student> findStudentById(int id) async {
    try {
      final studentResult =
          await Dio().get('http://localhost:8080/students/$id');

      if (studentResult.data == null) {
        throw Exception();
      }

      return Student.fromMap(studentResult.data);
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> insertStudent(Student student) async {
    try {
      await Dio().post(
        'http://localhost:8080/students',
        data: student.toMap(),
      );
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> updateStudent(Student student) async {
    try {
      await Dio().put(
        'http://localhost:8080/students/${student.id}',
        data: student.toMap(),
      );
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> deleteStudentById(int id) async {
    try {
      await Dio().delete('http://localhost:8080/students/$id');
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }
}
