import 'package:awdotcom/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  String test="test String";

  //instance creation from Firebase
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  late CollectionReference productCollection;

  TextEditingController productNameCtrl=TextEditingController();
  TextEditingController productDescriptionCtrl=TextEditingController();
  TextEditingController productImgCtrl=TextEditingController();
  TextEditingController productPriceCtrl=TextEditingController();

  String category='Category';
  String brand='Brand';

 List<Product>products=[];



  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    productCollection=firestore.collection('Products');
   await fetchProducts();
  }


  addProduct(){
    try{
      //created document reference
      DocumentReference doc=productCollection.doc();
      //created a dummy product
      Product product=Product(
        id: doc.id,
        name: productNameCtrl.text,
        category: category,
        description: productDescriptionCtrl.text,
        price: double.tryParse(productPriceCtrl.text),
        brand: brand,
        image:productImgCtrl.text,
      );
      //converts to product json, because to firestore collection we can only send json values table

      final productjson=product.toJson();

      //add converted json to a document
      doc.set(productjson);
      Get.snackbar('Success','Product added successfully',colorText: Colors.green);
    setValuesDefault();

    }catch(e){
      print(e);
      Get.snackbar('Success',e.toString(),colorText: Colors.green);
    }

  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot= await productCollection.get();
      final List<Product>retrievedProducts=productSnapshot.docs.map((doc)=>Product.fromJson(doc.data() as Map<String,dynamic>)).toList();
      //products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Success','Product Fetched Successfully',colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error',e.toString(),colorText: Colors.green);
      print(e);
    }finally{
      update();
    }
  }

  setValuesDefault(){
    productNameCtrl.clear();
    productDescriptionCtrl.clear();
    productImgCtrl.clear();
    productPriceCtrl.clear();

   category='Category';
   brand='Brand';
  }

  deleteProducts(String id) async {
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error',e.toString(),colorText: Colors.red);
      print(e);
    }

  }

 /* testMethod(){
    print(test);
  }*/

}