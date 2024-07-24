import 'package:awdotcom/Pages/add_product_page.dart';
import 'package:awdotcom/controller/home_controller.dart';
import 'package:flutter/material.dart';

//import 'package:footware_admin/controller/home_controller.dart';
//import 'package:footware_admin/pages/add_product_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context) {
    //return GetBuilder<HomeController>(builder: (ctrl) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Footware Admin'),
        ),
        body: ListView.builder(
            itemCount: ctrl.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ctrl.products[index].name ?? ''),
                subtitle: Text((ctrl.products[index].price ?? 0).toString()),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                   // ctrl.testMethod();
                    ctrl.deleteProducts(ctrl.products[index].id??'');
                    print('delete');
                    //  ctrl.deleteProduct(ctrl.products[index].id ?? '');
                  },
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const AddProductPage());
          },
          child: Icon(Icons.add),
        ),
      );
    });
  }
}
