import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/student.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class UpdateCommand extends Command {
  StudentRepository studentRepository;
  final productRepository = ProductRepository();

  @override
  String get description => 'Update Student';

  @override
  String get name => 'update';

  UpdateCommand(this.studentRepository) {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
    argParser.addOption('id', help: 'Student ID', abbr: 'i');
  }

  @override
  Future<void> run() async {
    print('Wait...');
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (id == null) {
      print('Please provide student id using command --id=0 or -i 0');
      return;
    }

    final students = File(filePath).readAsLinesSync();
    print('Wait, updating student data...');
    print('--------------------------------------');

    if (students.length > 1) {
      print('Please select a specific student from the file $filePath');
      return;
    } else if (students.isEmpty) {
      print('Please provide a valid student in the file $filePath');
      return;
    }

    var student = students.first;

    final studentData = student.split(';');
    final coursesCsv = studentData[2].split(',').map((e) => e.trim()).toList();

    final coursesFutures = coursesCsv.map((c) async {
      final course = await productRepository.findByName(c);
      course.isStudent = true;
      return course;
    }).toList();

    final courses = await Future.wait(coursesFutures);

    final studentModel = Student(
      id: int.parse(id),
      name: studentData[0],
      age: int.parse(studentData[1]),
      nameCourses: coursesCsv,
      courses: courses,
      address: Address(
        street: studentData[3],
        number: int.parse(studentData[4]),
        zipCode: studentData[5],
        city: City(
          id: 1,
          name: studentData[6],
        ),
        phone: Phone(
          ddd: int.parse(studentData[7]),
          phone: studentData[8],
        ),
      ),
    );

    await studentRepository.updateStudent(studentModel);
    print('--------------------------------------');
    print('Student successfuly updated!');
  }
}
