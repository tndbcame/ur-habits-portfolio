import 'package:isar/isar.dart';

part 'init.g.dart';

@Collection()
class Init {
  Id id = Isar.autoIncrement;
  bool? initFlg;
}
