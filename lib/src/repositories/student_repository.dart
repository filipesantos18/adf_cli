import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/student.dart';

class StudentRepository {
  Future<List<Student>> findAllStudents() async {
    final studentsResult =
        await http.get(Uri.parse('http://localhost:8080/students'));

    if (studentsResult.statusCode != 200) {
      throw Exception();
    }

    final studentsData = jsonDecode(studentsResult.body);

    return studentsData
        .map<Student>((student) => Student.fromMap(student))
        .toList();
  }

  Future<Student> findStudentById(int id) async {
    final studentResult =
        await http.get(Uri.parse('http://localhost:8080/students/$id'));

    if (studentResult.statusCode != 200) {
      throw Exception();
    }

    if (studentResult.body == '{}') {
      throw Exception();
    }

    return Student.fromJson(studentResult.body);
  }

  Future<void> insertStudent(Student student) async {
    final response = await http.post(
        Uri.parse('http://localhost:8080/students'),
        body: student.toJson(),
        headers: {'content-type': 'application/json'});

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> updateStudent(Student student) async {
    final response = await http.put(
        Uri.parse('http://localhost:8080/students/${student.id}'),
        body: student.toJson(),
        headers: {'content-type': 'application/json'});

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> deleteStudentById(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
