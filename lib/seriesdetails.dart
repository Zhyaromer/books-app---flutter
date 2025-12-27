import 'package:books_app__flutter/model/SeriesDetailsResponse.dart';
import 'package:flutter/material.dart';

class seriesdetails extends StatefulWidget {
  const seriesdetails({super.key, this.series_id});

  final int? series_id;

  @override
  State<seriesdetails> createState() => _seriesdetailsState();
}

class _seriesdetailsState extends State<seriesdetails> {
  late Future<SeriesDetailsResponse> seriesDetailsFuture;

  @override
  void initState() {
    super.initState();
    seriesDetailsFuture = fetchSeriesBookDetails(widget.series_id!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SeriesDetailsResponse>(
      future: seriesDetailsFuture,
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

        final series = snapshot.data!;

        return Scaffold(
          backgroundColor: const Color(0xFF121212),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text(
              series.series_title ?? 'Series Details',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: const Color(0xFF1F1F1F),
          ),

          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (series.cover_img != null)
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          series.cover_img!,
                          height: 300,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        series.series_title ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          series.state ?? 'Unknown',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    textAlign: TextAlign.end,
                    series.description ?? 'No Description',
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Books in this Series - ${series.books?.length ?? 0}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: series.books?.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3.2,
                    ),
                    itemBuilder: (context, index) {
                      final book = series.books![index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(3, 3),
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              if (book.cover_image != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    book.cover_image!,
                                    height: double.infinity,
                                    width: 140,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          book.title ?? 'No Title',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            (index + 1).toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 12),

                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today,
                                              color: Colors.white70,
                                              size: 14,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              book.published_date?.substring(
                                                    0,
                                                    10,
                                                  ) ??
                                                  'Unknown',
                                              style: const TextStyle(
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width: 12),

                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.category,
                                              color: Colors.white70,
                                              size: 14,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              book.genre ?? 'Unknown',
                                              style: const TextStyle(
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width: 12),

                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.menu_book,
                                              color: Colors.white70,
                                              size: 14,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              book.page_count.toString(),
                                              style: const TextStyle(
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 16),

                                    Expanded(
                                      child: Text(
                                        book.description ?? 'No Description',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
