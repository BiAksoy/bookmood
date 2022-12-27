import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:book_app/model/book_model.dart';

class BookProvider with ChangeNotifier {
  final CollectionReference favoritesCollection = FirebaseFirestore.instance
      .collection('Favorites')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Favorites');

  Future<BookModel> loadBook(String bookData, String bookId) async {
    final doc =
        await FirebaseFirestore.instance.collection(bookData).doc(bookId).get();
    final Map<String, dynamic> book = doc.data() as Map<String, dynamic>;
    final bool isFavorited =
        (await favoritesCollection.where('bookId', isEqualTo: bookId).get())
            .docs
            .isNotEmpty;
    return BookModel(bookData, bookId, isFavorited, book);
  }

  void addBookToFavorites(BookModel book) {
    favoritesCollection.add({
      'bookId': book.bookId,
      'bookData': book.bookData,
      'Title': book.book['Title'],
      'Author': book.book['Author'],
      'Picture': book.book['Picture'],
    });
  }

  Future<void> removeBookFromFavorites(BookModel book) async {
    favoritesCollection
        .where('bookId', isEqualTo: book.bookId)
        .get()
        .then((QuerySnapshot snapshot) async => {
              for (var document in snapshot.docs)
                {await favoritesCollection.doc(document.reference.id).delete()}
            });
  }
}
