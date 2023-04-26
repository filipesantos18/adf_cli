import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/student_dio_repository.dart';

class FindAllCommand extends Command {
  final StudentDioRepository repository;

  @override
  String get description => 'Find All Students';

  @override
  String get name => 'findAll';

  FindAllCommand(this.repository);

  @override
  Future<void> run() async {
    print('Wait, searching students...');
    final students = await repository.findAllStudents();
    print('Show courses? (Y ou N)');

    final showCourses = stdin.readLineSync();
    print('--------------------------------------');
    print('Students:');
    print('--------------------------------------');
    for (var student in students) {
      if (showCourses?.toLowerCase() == 'y') {
        print(
            '${student.id} - ${student.name} ${student.courses.where((course) => course.isStudent).map((course) => course.name).toList()}');
      } else {
        print('${student.id} - ${student.name}');
      }
    }
  }
}
