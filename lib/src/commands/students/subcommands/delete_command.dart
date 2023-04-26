import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class DeleteCommand extends Command {
  StudentRepository studentRepository;

  @override
  String get description => 'Delete Student by Id';

  @override
  String get name => 'delete';

  DeleteCommand(this.studentRepository) {
    argParser.addOption('id', help: 'Student ID', abbr: 'i');
  }

  @override
  Future<void> run() async {
    final id = int.tryParse(argResults?['id']);

    if (id == null) {
      print('Please provide student id using command --id=0 or -i 0');
      return;
    }
    print('Wait...');
    final student = await studentRepository.findStudentById(id);

    if (student.id == null) {
      print('Please provide a valid student ID');
    }

    print('Delete this student ${student.name}? (Y or N)');

    final deleteConfirm = stdin.readLineSync();

    if (deleteConfirm?.toUpperCase() == 'Y') {
      await studentRepository.deleteStudentById(id);
      print('--------------------------------------');
      print('Student successfuly deleted!');
      print('--------------------------------------');
    } else {
      print('--------------------------------------');
      print('Cancelling Operation');
      print('--------------------------------------');
      return;
    }
  }
}
