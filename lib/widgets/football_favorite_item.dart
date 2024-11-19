import 'package:get/get.dart';
import '../screens/Favorite/favorite_model.dart';
import '../screens/Favorite/database_helper.dart';
import 'package:flutter/material.dart';

class FootballFavoriteItem extends StatelessWidget {
  final Favorite football;
  final VoidCallback? onDelete;

  const FootballFavoriteItem({
    Key? key,
    required this.football,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            football.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
                child: Icon(Icons.error),
              );
            },
          ),
        ),
        title: Text(
          football.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text('${football.type} • ${football.aired}'),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            await DatabaseHelper.instance.removeFavorite(football.name);
            Get.snackbar('Sukses', 'Dihapus dari favorit');
            onDelete?.call();
          },
        ),
      ),
    );
  }
} 