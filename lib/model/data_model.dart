import 'package:hive_flutter/adapters.dart';
// part 'data_model.g.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class studentmodel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String age;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String? image;

  studentmodel({
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.image,
  });
}
