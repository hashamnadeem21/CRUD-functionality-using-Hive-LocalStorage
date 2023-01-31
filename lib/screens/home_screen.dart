import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiveimplementation/models/notes_models.dart';
import 'package:hiveimplementation/screens/add_notes_screen.dart';
import 'package:hiveimplementation/screens/view_notes_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("H I V E   N O T I F Y "),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<NotesModel>('Notes').listenable(),
          builder: (context, Box<NotesModel> box, _) {
            return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final data = box.getAt(index);
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10),
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        onTap: () {
                          Get.to(() => ViewNoteScreen(
                                title: data!.title,
                                description: data.description,
                                imageUrl: data.imageUrl,
                              ));
                        },
                        leading: const Text("image"),
                        title: Text(
                          data!.title.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            box.deleteAt(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddNotes());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
