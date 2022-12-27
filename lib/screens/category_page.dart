import 'package:flutter/material.dart';
import 'package:book_app/widgets/category_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'log_in_page.dart';
import 'package:book_app/service/auth.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              await authService.signOut();
              navigator.push(
                MaterialPageRoute(
                  builder: (context) => const LogIn(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        //backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.blueGrey, Colors.amber.shade200]),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[Colors.blueGrey, Colors.amber.shade200])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 240,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                    child: Container(
                      height: 240,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/book-img.jpeg"),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "What do you want to read today?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.merienda(
                                textStyle: const TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    backgroundColor:
                                        Color.fromRGBO(150, 111, 51, 0.5))),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FavoritesCard(
                          text: "Favorites",
                          imgUrl: "images/favorite-img.webp",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CategoryCard(
                          text: "Novels",
                          imgUrl: "images/novel-img.jpeg",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CategoryCard(
                          text: "Poems",
                          imgUrl: "images/poem-img.jpeg",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CategoryCard(
                          text: "Thrillers",
                          imgUrl: "images/thriller-img.jpeg",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
