import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'book_detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final Stream<QuerySnapshot> stream;

  @override
  void initState() {
    stream = FirebaseFirestore.instance
        .collection('Favorites')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Favorites')
        .snapshots();
    FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.blueGrey, Colors.amber.shade100],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[Colors.amber.shade100, Colors.blueGrey],
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final books = snapshot.data!.docs;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                book['Picture'],
                                width: 48,
                                height: 72,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book['Title'],
                                    style: GoogleFonts.farsan(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                  Text(
                                    book['Author'],
                                    style: GoogleFonts.farsan(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.favorite),
                              color: Colors.redAccent,
                              onPressed: () async {
                                final docRef = FirebaseFirestore.instance
                                    .collection(book['bookData'])
                                    .doc(book['bookId']);
                                final docSnapshot = await docRef.get();
                                final int numFavorites =
                                    docSnapshot.data()!['numFavorites'] as int;
                                await docRef.update({
                                  'numFavorites': numFavorites - 1,
                                });

                                FirebaseFirestore.instance
                                    .collection('Favorites')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('Favorites')
                                    .doc(book.id)
                                    .delete();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookDetail(
                          bookData: book['bookData'], bookId: book['bookId']),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
