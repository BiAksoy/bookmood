import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Function() onTap;
  final String bookCover;

  const BookCard({super.key, required this.onTap, required this.bookCover});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      shadowColor: Colors.black,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: onTap,
        child: SizedBox(
          width: 120,
          height: 200,
          child: Center(
            child: Image.network(
              bookCover,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
