
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseManager {

  final CollectionReference profileList =  FirebaseFirestore.instance.collection('NotesTable');

  Future getUsersList() async {
    List itemsList = [];

    try {

      QuerySnapshot querySnapshot = await profileList.get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      allData.forEach((element) {
        itemsList.add(element);
      });


      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}

