import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/Football/football_controller.dart';
import 'package:widgets/football_list_item.dart';

class FootballView extends StatelessWidget {
  final FootballController footballController = Get.put(FootballController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Football'),
      ),
      body: Obx(() {
        if (footballController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: footballController.footballList.length,
          itemBuilder: (context, index) {
            return FootballListItem(football: footballController.footballList[index]);
          },
        );
      }),
    );
  }
}
