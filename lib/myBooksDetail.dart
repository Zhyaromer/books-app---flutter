import 'package:books_app__flutter/bookdetails.dart';
import 'package:books_app__flutter/model/reading_status_list.dart';
import 'package:flutter/material.dart';

class MyBooksDetail extends StatefulWidget {
  const MyBooksDetail({super.key, required this.status});

  final ReadingStatusItem status;

  @override
  State<MyBooksDetail> createState() => _MyBooksDetailState();
}

class _MyBooksDetailState extends State<MyBooksDetail> {
  late List<ReadingStatusList> books;
  late List<ReadingStatusList> cacheBooks;
  String sort = 'Newest date added';
  final TextEditingController _searchController = TextEditingController();

  void changeSort(String? newSort) {
    if (newSort != null) {
      setState(() {
        sort = newSort;
        if (sort == 'Newest date added') {
          books.sort((a, b) => a.addedDate!.compareTo(b.addedDate!));
        } else if (sort == 'Oldest date added') {
          books.sort((a, b) => b.addedDate!.compareTo(a.addedDate!));
        } else if (sort == 'Title A-Z') {
          books.sort((a, b) => a.title.compareTo(b.title));
        } else if (sort == 'Title Z-A') {
          books.sort((a, b) => b.title.compareTo(a.title));
        } else if (sort == 'highest page count') {
          books.sort((a, b) => b.page_count.compareTo(a.page_count));
        } else if (sort == 'lowest page count') {
          books.sort((a, b) => a.page_count.compareTo(b.page_count));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    books = allBooksForStatus(widget.status.label);
    books.sort((a, b) => a.addedDate!.compareTo(b.addedDate!));
    cacheBooks = List.from(books);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      appBar: AppBar(
        title: Text(widget.status.label, style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF1F1F1F),
        centerTitle: true,
        shadowColor: Colors.grey,
        elevation: 0.5,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),

            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _searchController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search books...',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Color(0xFF2C2C2C),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                  onChanged: (value) {
                    setState(() {
                      books = cacheBooks
                          .where(
                            (book) =>
                                book.title.toLowerCase().contains(value.toLowerCase()) ||
                                book.name.toLowerCase().contains(value.toLowerCase()),
                          )
                          .toList();
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${books.length} Books', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton<String>(
                    value: sort,
                    dropdownColor: Color(0xFF2C2C2C),
                    underline: Container(),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    iconEnabledColor: Colors.white,
                    items:
                        <String>[
                          'Newest date added',
                          'Oldest date added',
                          'Title A-Z',
                          'Title Z-A',
                          'highest page count',
                          'lowest page count',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                    onChanged: changeSort,
                  ),
                ),
              ],
            ),

            Expanded(
              child: books.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No books found.', style: TextStyle(color: Colors.grey, fontSize: 16)),

                          SizedBox(height: 24),

                          Text(
                            'Try adjusting your search or filter to find what you\'re looking for.',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),

                          SizedBox(height: 34),

                          Container(
                            width: 175,
                            child: ElevatedButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  books = List.from(cacheBooks);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurpleAccent,
                                padding: EdgeInsets.symmetric(vertical: 8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.clear, color: Colors.white, size: 16),
                                    SizedBox(width: 8),
                                    Text('Clear Search', style: TextStyle(color: Colors.white, fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookDetails(book_id: book.id)),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              height: 200,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2C2C2C),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                    child: Image.network(book.coverImage, width: 125, height: 200, fit: BoxFit.cover),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                book.title,
                                                style: const TextStyle(color: Colors.white, fontSize: 22),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                book.name,
                                                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
                                              ),

                                              SizedBox(height: 8),

                                              Text(
                                                book.description,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(color: Colors.grey, fontSize: 14),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 20),

                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              book.genre,
                                              style: TextStyle(color: Colors.white, fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
    );
  }
}
