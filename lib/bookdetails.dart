import 'package:books_app__flutter/model/BookDetailResponse.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key, required this.book_id});
  final int book_id;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  late Future<BookDetailResponse> bookDetailFuture;

  @override
  void initState() {
    super.initState();
    bookDetailFuture = fetchBookDetail(widget.book_id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookDetailResponse>(
      future: bookDetailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No data available'));
        }

        final bookDetail = snapshot.data!;
        final book = bookDetail.book;
        final reviews = bookDetail.reviews;
        final similiarBooks = bookDetail.similarBooks;
        final Series? series = bookDetail.series?.isNotEmpty == true
            ? bookDetail.series!.first
            : null;

        return Scaffold(
          backgroundColor: const Color(0xFF121212),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              book?.title ?? 'Book Details',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: book?.cover_image != null
                            ? Image.network(
                                book!.cover_image!,
                                height: 265,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.book, size: 100),
                      ),

                      Positioned(
                        bottom: 4,
                        left: 4,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.black.withOpacity(0.5),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${book?.rating?.toStringAsFixed(1) ?? 'N/A'} (${bookDetail.reviews?.length})',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      book?.title ?? 'Unknown Title',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Center(
                  child: Text(
                    ' by ${book?.name ?? 'Unknown Author'}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      book?.language ?? 'Unknown Language',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Text(
                      ' * ',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      // '${book?.genre ?? 'Unknown Genre'} & Mystic & Adventure',
                      'Comedy & Mystic & Adventure',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Container(
                    height: 140,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                'Book info',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(width: 6),

                              Icon(
                                Icons.info_outline,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              book!.published_date!.substring(0, 10),
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(width: 8),

                            Text(
                              ' * ',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(width: 8),

                            Text(
                              '${book.page_count ?? 'N/A'} Pages',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(width: 8),

                            Text(
                              ' * ',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(width: 8),

                            Text(
                              'Series of ${series?.series_title ?? 'N/A'}',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 18,
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.grey[800],
                                ),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.download, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Get',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 20),

                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 18,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: const [
                                  Text(
                                    'Sample',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: bookDetail.book?.imgURL != null
                              ? NetworkImage(bookDetail.book!.imgURL!)
                              : null,
                          child: bookDetail.book?.imgURL == null
                              ? const Icon(Icons.person, size: 40)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bookDetail.book?.name ?? 'Unknown Author',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                bookDetail.book?.bio ??
                                    'No biography available.',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(color: Colors.grey[900]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      const Text(
                        'Description',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        book.description ?? 'No description available.',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(color: Colors.grey[900]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Reviews (${reviews?.length ?? 0})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: reviews?.length ?? 0,
                          itemBuilder: (context, index) {
                            final review = reviews![index];
                            return Container(
                              width: 300,
                              margin: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 12.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundImage:
                                                  review?.coverImgURL != null
                                                  ? NetworkImage(
                                                      review!.coverImgURL!,
                                                    )
                                                  : null,
                                              child: review?.coverImgURL == null
                                                  ? const Icon(
                                                      Icons.person,
                                                      size: 16,
                                                    )
                                                  : null,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              review?.username ?? 'Anonymous',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow[700],
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  review?.rating != null
                                                      ? review!.rating!
                                                            .toStringAsFixed(1)
                                                      : 'N/A',
                                                  style: const TextStyle(
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 4),

                                            Text(
                                              review?.created_at != null
                                                  ? review!.created_at!
                                                        .substring(0, 10)
                                                  : 'N/A',
                                              style: const TextStyle(
                                                color: Colors.white38,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 7),
                                    Divider(color: Colors.white24),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        review?.comment ??
                                            'No comment provided.',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Similar Books',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white54,
                              size: 18,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: similiarBooks?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final similiarBook = similiarBooks![index];
                              return Container(
                                width: 160,
                                margin: const EdgeInsets.only(right: 15),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: similiarBook?.cover_image != null
                                          ? Image.network(
                                              similiarBook?.cover_image! ?? '',
                                              height: 270,
                                              fit: BoxFit.cover,
                                            )
                                          : const Icon(Icons.book, size: 80),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
