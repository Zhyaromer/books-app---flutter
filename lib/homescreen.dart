import 'package:books_app__flutter/bookdetails.dart';
import 'package:books_app__flutter/model/books.dart';
import 'package:flutter/material.dart';

class BookLibraryApp extends StatefulWidget {
  const BookLibraryApp({super.key});

  @override
  State<BookLibraryApp> createState() => _BookLibraryAppState();
}

class _BookLibraryAppState extends State<BookLibraryApp> {
  List<String> types = [
    'ڕۆمان',
    'شیعر',
    'چیرۆک',
    'فانتاسی',
    'خەیاڵی',
    'ڕۆمانس',
    'ترسناک',
    'نادیار',
    'زمانەوانی',
    'چیرۆکی',
    'خەیاڵی ئەدەبی',
    'مێژووی',
    'زانستی خەیاڵی',
  ];

  int selectedTypeIndex = 0;
  int _currentIndex = 0;

  late Future<List<Books>> booksFuture;
  late Future<List<Books>> randomBooks;

  @override
  void initState() {
    super.initState();
    booksFuture = fetchBooks();
    randomBooks = fetchRandomBooks(types[selectedTypeIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        bottom: false,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.deepPurple.shade200,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_online),
              label: 'my Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Discover',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'More',
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            floating: true,
            expandedHeight: 70,
            backgroundColor: Colors.deepPurple,
            bottom: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.deepPurple,
              elevation: 15,
              shadowColor: Colors.black.withOpacity(0.5),
              title: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search books...',
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            onPressed: () {
                              // Implement filter functionality
                            },
                            icon: const Icon(Icons.filter_list),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(
                      Icons.store,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      // Implement filter functionality
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    itemCount: types.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 0,
                        ),
                        child: ActionChip(
                          onPressed: () {
                            setState(() {
                              selectedTypeIndex = index;
                              randomBooks = fetchRandomBooks(
                                types[selectedTypeIndex],
                              );
                            });
                          },
                          label: IntrinsicWidth(
                            stepWidth: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  types[index],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 2),

                                if (selectedTypeIndex == index)
                                  Container(
                                    width: double.infinity,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          side: BorderSide.none,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'most popular books',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 310,
                  child: FutureBuilder<List<Books>>(
                    future: booksFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No books found.');
                      } else {
                        final books = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: books.length,
                          itemBuilder: (context, index) {
                            final book = books[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 145,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        book.cover_image,
                                        height: 200,
                                        width: 140,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        book.title,
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        book.name,
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 7),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        '\$' + 12.toString() + '.00',
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
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
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'view latest books',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 360,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: FutureBuilder<List<Books>>(
                      future: randomBooks,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No books found.');
                        } else {
                          final books = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              final book = books[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BookDetails(book_id: book.id),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 160,
                                        child: Card(
                                          color: Colors.grey[200],
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Hero(
                                                  tag: 'book_cover_${book.id}',
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                    child: Image.network(
                                                      book.cover_image,
                                                      width: 100,
                                                      height: 160,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        book.title,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                        height: 10,
                                                      ),

                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 15,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                  book.imgURL,
                                                                ),
                                                          ),

                                                          const SizedBox(
                                                            width: 5,
                                                          ),

                                                          Text(
                                                            book.name,
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                          ),
                                                        ],
                                                      ),

                                                      const SizedBox(
                                                        height: 10,
                                                      ),

                                                      Text(
                                                        '${book.page_count} pages - ${book.language} - ${book.genre}',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                        height: 10,
                                                      ),

                                                      Text(
                                                        '\$12.00',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
