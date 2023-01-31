import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hiveimplementation/models/notes_models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A D D   N O T E S"),
        actions: [
          IconButton(
            onPressed:
              submitData,

            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                TextFormField(
                  style:const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  onChanged: (val) {
                    setState(() {
                      title = val;
                      // print(title);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _image == null
                    ? Container()
                    : Image.file(
                        File(_image!.path),
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        child: const Icon(Icons.camera),
      ),
    );
  }

  getImage() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  submitData() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      Hive.box<NotesModel>("Notes").add(NotesModel(
          title: title,
          description: description,
          imageUrl: _image!.path
      ));
      Navigator.of(context).pop();
    }
  }
}
