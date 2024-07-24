import 'package:awdotcom/Views/DashboardScreen.dart';
import 'package:awdotcom/Views/profilepage.dart';
import 'package:awdotcom/Views/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:awdotcom/JsonModels/note_model.dart';
//import 'package:awdotcom/SQLite/sqlite.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();




}

class _CreateNoteState extends State<CreateNote> {
  final title = TextEditingController();
  final content = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void initState(){
    getUsersList();
    super.initState();
  }

  //final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create note"),
        actions: [
          IconButton(
              onPressed: () {

                //Insert into firebase database
                CollectionReference collRef=FirebaseFirestore.instance.collection('NotesTable');
                collRef.add({
                'title':title.text,
                'contect':content.text



                });

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyApp()));
 
                //Add Note button
                //We should not allow empty data to the database
                /*if (formKey.currentState!.validate()) {
                  db
                      .createNote(NoteModel(
                      noteTitle: title.text,
                      noteContent: content.text,
                      createdAt: DateTime.now().toIso8601String()))
                      .whenComplete(() {
                    //When this value is true
                    Navigator.of(context).pop(true);
                  });
                }*/
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Form(
        //I forgot to specify key
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Title"),
                  ),
                ),
                TextFormField(
                  controller: content,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Content is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Content"),
                  ),
                ),
              ],
            ),
          )),
    );
  }


  getUsersList() async {
    List itemsList = [];
    final CollectionReference profileList =  FirebaseFirestore.instance.collection('NotesTable');
    try {

      QuerySnapshot querySnapshot = await profileList.get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      allData.forEach((element) {
        itemsList.add(element);
      });

      print(itemsList);
     return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }




}