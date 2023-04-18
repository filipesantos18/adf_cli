import 'package:args/command_runner.dart';

void main(List<String> arguments) {
  // final argParser = ArgParser();
  // argParser.addFlag('data', abbr: 'd');
  // argParser.addOption('name', abbr: 'n');
  // argParser.addOption('template', abbr: 't');
  // argParser.parse(arguments);

  CommandRunner('ADF CLI', 'ADF CLI')
    ..addCommand(ExemploCommand())
    ..run(arguments);
}

class ExemploCommand extends Command {
  @override
  String get description => 'Command example';

  @override
  String get name => 'example';

  ExemploCommand() {
    argParser.addOption('template',
        abbr: 't', help: 'Project creation template');
  }

  @override
  void run() {
    print('Execute anything');
  }
}
