import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'book_detail_page.dart';
import 'package:book_app/provider/book_provider.dart';
import 'package:book_app/widgets/book_card.dart';

class Books extends StatefulWidget {
  final String bookData;

  const Books({Key? key, required this.bookData}) : super(key: key);

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  DocumentSnapshot? book;
  late final Stream<QuerySnapshot> stream;

  @override
  void initState() {
    getRandomBook();
    stream = FirebaseFirestore.instance.collection(widget.bookData).snapshots();
    super.initState();
  }

  void getRandomBook() async {
    final date = DateTime.now()
        .difference(DateTime.fromMicrosecondsSinceEpoch(0))
        .inDays;
    final random = Random(date);

    final booksSnapshot =
        await FirebaseFirestore.instance.collection(widget.bookData).get();
    final books = booksSnapshot.docs;
    final randomIndex = random.nextInt(books.length);
    setState(() {
      book = books[randomIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    final book = this.book;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
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
        child: book == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${widget.bookData.substring(0, widget.bookData.length - 1)} of The Day",
                              style: GoogleFonts.courgette(
                                textStyle: const TextStyle(
                                  fontSize: 34,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                              child: SizedBox(
                                width: 130,
                                height: 180,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: BookCard(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => BookDetail(
                                              bookData: widget.bookData,
                                              bookId: book.id),
                                        ),
                                      );
                                    },
                                    bookCover: book['Picture'],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(right: 30),
                                width: 200,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 16.0),
                                  child: Text(
                                    book['Summary'],
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.courgette(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                    child: SizedBox(
                      width: 200,
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "See Also",
                          style: GoogleFonts.courgette(
                              textStyle: const TextStyle(
                            fontSize: 34,
                          )),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox(
                        width: 120,
                        height: 190,
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs.map((document) {
                            return BookCard(
                                onTap: () {
                                  return Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                          create: (BuildContext context) {
                                            BookProvider();
                                          },
                                          child: BookDetail(
                                              bookData: widget.bookData,
                                              bookId: document.id),
                                        ),
                                      ));
                                },
                                bookCover: document['Picture']);
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
