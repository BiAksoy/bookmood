import 'package:flutter/widgets.dart';

class BookModel extends ChangeNotifier {
  final String bookData;
  final String bookId;
  bool isFavorited;
  Map<String, dynamic> book;

  BookModel(this.bookData, this.bookId, this.isFavorited, this.book);

  void toggleFavorite() {
    isFavorited = !isFavorited;
    notifyListeners();
  }
}
