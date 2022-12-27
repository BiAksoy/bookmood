import 'package:flutter/material.dart';
import 'package:book_app/screens/book_list_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:book_app/screens/favorites_page.dart';

class CategoryCard extends StatelessWidget {
  final String text;
  final String imgUrl;

  const CategoryCard({super.key, required this.text, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      shadowColor: Colors.black,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Books(bookData: text),
              ));
        },
        child: SizedBox(
          width: 350,
          height: 120,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(imgUrl),
              fit: BoxFit.cover,
            )),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.merienda(
                  textStyle: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FavoritesCard extends StatelessWidget {
  final String text;
  final String imgUrl;

  const FavoritesCard({super.key, required this.text, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      shadowColor: Colors.black,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FavoritesPage(),
            ),
          );
        },
        child: SizedBox(
          width: 350,
          height: 120,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imgUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.merienda(
                  textStyle: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
