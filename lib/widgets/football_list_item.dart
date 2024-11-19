import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '.../screens/Football/football_model.dart';
import '.../screens/Favorite/database_helper.dart';
import '.../screens/Favorite/favorite_model.dart';

class FootballListItem extends StatelessWidget {
  final FootballModel football;
  final bool showBookmark;

  const FootballListItem({
    Key? key, 
    required this.football,
    this.showBookmark = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: FootballImage(imageUrl: football.images.jpg.imageUrl),
            title: FootballTitle(title: football.title),
            subtitle: FootballDetails(football: football),
          ),
          if (showBookmark)
            Positioned(
              top: 8,
              right: 8,
              child: FavoriteButton(football: football),
            ),
        ],
      ),
    );
  }
}

class FootballImage extends StatelessWidget {
  final String imageUrl;

  const FootballImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}

class FootballTitle extends StatelessWidget {
  final String title;

  const FootballTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}

class FootballDetails extends StatelessWidget {
  final FootballModel football;

  const FootballDetails({Key? key, required this.football}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        DetailText(label: 'Nama', value: football.type),
        DetailText(label: 'Badge', value: football.aired),
        DetailText(label: 'Stadium', value: football.genres.join(', ')),
        DetailText(label: 'Location', value: football.popularity.toString()),
      ],
    );
  }
}

class DetailText extends StatelessWidget {
  final String label;
  final String value;

  const DetailText({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label: $value',
      style: TextStyle(fontSize: 14),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  final FootballModel football;

  const FavoriteButton({Key? key, required this.football}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final status = await DatabaseHelper.instance.isFavorite(widget.football.malId);
    setState(() {
      isFavorite = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () async {
        if (isFavorite) {
          await DatabaseHelper.instance.removeFavorite(widget.football.malId);
          Get.snackbar('Sukses', 'Dihapus dari favorit');
        } else {
          final favoriteAnime = FavoriteAnime(
            name: widget.football.malId,
            badge: widget.football.title,
            stadium: widget.football.type,
            location: widget.football.aired,
          );
          await DatabaseHelper.instance.addFavorite(favoriteFootball);
          Get.snackbar('Sukses', 'Ditambahkan ke favorit');
        }
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}



