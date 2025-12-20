import 'package:books_app__flutter/model/books.dart';
import 'package:flutter/material.dart';

class bookdetails extends StatefulWidget {
  const bookdetails({super.key, required this.book});
  final Books book;

  @override
  State<bookdetails> createState() => _bookdetailsState();
}

class _bookdetailsState extends State<bookdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.title)),
      body: Center(
        child: Column(
          children: [
            Image.network(widget.book.cover_image),
            const SizedBox(height: 20),
            Text(
              widget.book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'by ${widget.book.name}',
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
