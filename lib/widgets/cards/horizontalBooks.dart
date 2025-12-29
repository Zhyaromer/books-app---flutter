import 'package:books_app__flutter/bookdetails.dart';
import 'package:books_app__flutter/model/books.dart';
import 'package:flutter/material.dart';

Widget horizontalBooks(
  BuildContext context,
  Future<List<Books>> booksFuture,
  String Title,
  String description,
  Color bgColor,
) {
  return Container(
    color: bgColor,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Title,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(description, style: TextStyle(color: Colors.white70, fontSize: 14)),
          ),

          SizedBox(height: 16),
          FutureBuilder(
            future: booksFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No books found'));
              } else {
                final books = snapshot.data!;
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BookDetails(book_id: book.id)),
                          );
                        },
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.only(right: 16.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(book.cover_image), fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}
