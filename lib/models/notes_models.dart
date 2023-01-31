import 'package:hive/hive.dart';
part 'notes_models.g.dart';

@HiveType(typeId: 0)
class NotesModel  {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String imageUrl;

  NotesModel({required this.description, required this.title , required this.imageUrl});
}
