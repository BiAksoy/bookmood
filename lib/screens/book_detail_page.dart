import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/provider/book_provider.dart';

class BookDetail extends StatefulWidget {
  final String bookData;
  final String bookId;

  const BookDetail({Key? key, required this.bookData, required this.bookId})
      : super(key: key);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final BookProvider bookProvider = BookProvider();
  late final Future<BookModel> future;

  @override
  void initState() {
    future = bookProvider.loadBook(widget.bookData, widget.bookId);
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
        backgroundColor: Colors.blueGrey.shade100,
      ),
      backgroundColor: Colors.blueGrey.shade100,
      body: FutureBuilder<BookModel>(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<BookModel> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              elevation: 18,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                snapshot.data!.book['Picture'],
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!.book['Title'],
                                    style: GoogleFonts.farsan(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 36,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "by ${snapshot.data!.book['Author']}",
                                    style: GoogleFonts.dancingScript(
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Flexible(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 85,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final Uri url = Uri.parse(
                                                  snapshot.data!.book['Url']);
                                              await launchUrl(url);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.blueGrey.shade600,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                            child: Text(
                                              "Buy",
                                              style: GoogleFonts.farsan(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: snapshot.data!.isFavorited
                                              ? const Icon(
                                                  Icons.favorite,
                                                  color: Colors.redAccent,
                                                  size: 30,
                                                )
                                              : const Icon(
                                                  Icons.favorite_border,
                                                  size: 30,
                                                ),
                                          onPressed: () {
                                            setState(() {
                                              snapshot.data!.toggleFavorite();
                                            });
                                            if (snapshot.data!.isFavorited) {
                                              bookProvider.addBookToFavorites(
                                                  snapshot.data!);
                                            } else {
                                              bookProvider
                                                  .removeBookFromFavorites(
                                                      snapshot.data!);
                                            }
                                          },
                                        ),
                                        Text(
                                          "${snapshot.data!.numFavorites}",
                                          style: GoogleFonts.ptSans(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey.shade600,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          snapshot.data!.book['Summary'],
                          style: GoogleFonts.alegreya(
                            textStyle: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
