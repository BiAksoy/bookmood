import 'package:flutter/widgets.dart';

class BookModel extends ChangeNotifier {
  final String bookData;
  final String bookId;
  bool isFavorited;
  Map<String, dynamic> book;
  int numFavorites;

  BookModel(this.bookData, this.bookId, this.isFavorited, this.book,
      this.numFavorites);

  void toggleFavorite() {
    isFavorited = !isFavorited;
    if (isFavorited) {
      numFavorites++;
    } else {
      numFavorites--;
    }
    notifyListeners();
  }
}
