import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class FindByIdCommand extends Command {
  final StudentRepository studentRepository;

  @override
  String get description => 'Find Student By Id';
  @override
  String get name => 'byId';

  FindByIdCommand(this.studentRepository) {
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    if (argResults?['id'] == null) {
      print('Please send the student\'s id using the command --id=0 or -i 0 ');
      return;
    }

    final id = int.parse(argResults?['id']);

    print('Wait, searching data...');
    final student = await studentRepository.findStudentById(id);
    print('--------------------------------------');
    print('Student: ${student.name}');
    print('--------------------------------------');
    print('Name: ${student.name}');
    print('Age: ${student.age}');
    print('Courses: ');
    student.nameCourses.forEach(print);
    print('Endereço:');
    print('${student.address.street} (${student.address.zipCode})');
  }
}
