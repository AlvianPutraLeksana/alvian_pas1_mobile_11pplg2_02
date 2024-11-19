import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/football_favorite_item.dart';
import 'favorite_model.dart';
import 'database_helper.dart';

class FavoriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorit Saya'),

      ),
      body: FutureBuilder<List<FavoriteAnime>>(
        future: DatabaseHelper.instance.getAllFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Belum ada anime favorit'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final anime = snapshot.data![index];
              return FootballFavoriteItem(
                football: football,
                onDelete: () {
                  Get.forceAppUpdate();
                },
              );
            },
          );
        },
      ),
    );
  }
} 