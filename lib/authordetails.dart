import 'package:books_app__flutter/bookdetails.dart';
import 'package:books_app__flutter/model/AuthorDetailsResponse.dart';
import 'package:flutter/material.dart';

class AuthorDetails extends StatefulWidget {
  const AuthorDetails({super.key, required this.id});

  final int id;

  @override
  State<AuthorDetails> createState() => _AuthorDetailsState();
}

class _AuthorDetailsState extends State<AuthorDetails> {
  late Future<AuthorDetailsResponse> authorDetailFuture;

  @override
  void initState() {
    super.initState();
    authorDetailFuture = fetchAuthorDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuthorDetailsResponse>(
      future: authorDetailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final author = snapshot.data!.author?.first;
          final books = snapshot.data!.books;

          return Scaffold(
            backgroundColor: const Color(0xFF121212),
            appBar: AppBar(
              title: Text(
                author?.name ?? 'Author Details',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _openImagePreview(
                                  context,
                                  author?.imgURL ?? '',
                                );
                              },
                              child: Hero(
                                tag: author?.imgURL ?? '',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    author?.imgURL ?? '',
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 300,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 26),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    author?.language == 'Arabic' ||
                                        author?.language == 'Kurdish'
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    author?.name ?? '',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign:
                                        author?.language == 'Arabic' ||
                                            author?.language == 'Kurdish'
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    author?.bio ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                    textAlign:
                                        author?.language == 'Arabic' ||
                                            author?.language == 'Kurdish'
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Author info',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.person, color: Colors.white),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    author?.language ?? '',
                                    style: TextStyle(color: Colors.white),
                                    textAlign:
                                        author?.language == 'Arabic' ||
                                            author?.language == 'Kurdish'
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    ' * ',
                                    style: TextStyle(color: Colors.white),
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    author?.country ?? '',
                                    style: TextStyle(color: Colors.white),
                                    textAlign:
                                        author?.language == 'Arabic' ||
                                            author?.language == 'Kurdish'
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    ' * ',
                                    style: TextStyle(color: Colors.white),
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    author?.dateOfBirth?.substring(0, 10) ?? '',
                                    style: TextStyle(color: Colors.white),
                                    textAlign:
                                        author?.language == 'Arabic' ||
                                            author?.language == 'Kurdish'
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'More Books by ${author?.name ?? ''}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: books?.length ?? 0,
                        itemBuilder: (context, index) {
                          final book = books![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookDetails(book_id: book!.id!),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  book?.coverImage ?? '',
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 180,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data available.'));
        }
      },
    );
  }
}

void _openImagePreview(BuildContext context, String imageUrl) {
  showGeneralDialog(
    transitionDuration: Duration(milliseconds: 300),
    barrierColor: Colors.black45.withOpacity(0.8),
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (_, _, _) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: InteractiveViewer(
              minScale: 1.0,
              maxScale: 4.0,
              child: Image.network(imageUrl),
            ),
          ),
        ),
      );
    },
  );
}
