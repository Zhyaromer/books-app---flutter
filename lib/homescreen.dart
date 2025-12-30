import 'package:books_app__flutter/discover.dart';
import 'package:books_app__flutter/model/SeriesResponse.dart';
import 'package:books_app__flutter/model/books.dart';
import 'package:books_app__flutter/myBooks.dart';
import 'package:books_app__flutter/seriesdetails.dart';
import 'package:books_app__flutter/widgets/cards/horizontalBooks.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  final Future<List<Books>> booksFuture;
  final Future<List<Books>> randomBooks;
  final List<Map<String, String>> types;
  final Function(int) onTypeSelected;
  final int selectedTypeIndex;
  final Future<List<SeriesResponse>> series;

  const HomeScreen({
    super.key,
    required this.booksFuture,
    required this.randomBooks,
    required this.types,
    required this.onTypeSelected,
    required this.selectedTypeIndex,
    required this.series,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Books>> Books1;
  late Future<List<Books>> Books2;
  late Future<List<Books>> Books3;
  late Future<List<Books>> Books4;

  @override
  void initState() {
    super.initState();
    Books1 = fetchBooksByPage(1);
    Books2 = fetchBooksByPage(2);
    Books3 = fetchBooksByPage(5);
    Books4 = fetchBooksByPage(4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          'Book Library',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white, size: 30),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            horizontalBooks(
              context,
              Books1,
              'Trending Books',
              'Check out the most popular books right now',
              const Color(0xFF121212),
            ),

            SizedBox(height: 16),

            horizontalBooks(
              context,
              Books2,
              'New Releases',
              'Discover the latest additions to our library',
              const Color(0xFF1F1F1F),
            ),

            SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Book Series',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Explore popular book series',
                  style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 16),

            FutureBuilder<List<SeriesResponse>>(
              future: widget.series,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(height: 230.0, child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return SizedBox(height: 230.0, child: Center(child: Text('Error: ${snapshot.error}')));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return SizedBox(height: 230.0, child: Center(child: Text('No series found')));
                } else {
                  final items = snapshot.data!;
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: 230.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                    ),
                    items: items.map((e) {
                      final imageUrl = e.cover_img ?? '';
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return seriesdetails(series_id: e.id);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10.0),
                                image: imageUrl.isNotEmpty
                                    ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.fill)
                                    : null,
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      color: Colors.black54,
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      child: Text(
                                        e.series_title ?? '',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                }
              },
            ),

            SizedBox(height: 16),

            horizontalBooks(
              context,
              Books3,
              'Recommended for You',
              'Books picked just for your taste',
              const Color(0xFF121212),
            ),

            SizedBox(height: 16),

            Container(
              color: const Color(0xFF1F1F1F),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Explore by Genre',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 240,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: widget.types.length,
                        itemBuilder: (context, index) {
                          final type = widget.types[index];
                          final isSelected = index == widget.selectedTypeIndex;
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: isSelected ? Colors.white : Colors.grey, width: 2.0),
                              color: isSelected ? const Color(0xFF121212) : Colors.grey[800],
                              image: DecorationImage(
                                image: NetworkImage(widget.types[index]['image']!),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                              ),
                            ),

                            child: InkWell(
                              onTap: () {
                                widget.onTypeSelected(index);
                              },

                              child: Center(
                                child: Text(
                                  type['name']!,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

            horizontalBooks(context, Books4, 'selling Books', 'Top picks based on sales', const Color(0xFF1F1F1F)),
          ],
        ),
      ),
    );
  }
}

class BookLibraryApp extends StatefulWidget {
  const BookLibraryApp({super.key});

  @override
  State<BookLibraryApp> createState() => _BookLibraryAppState();
}

class _BookLibraryAppState extends State<BookLibraryApp> {
  final List<Map<String, String>> types = [
    {
      'name': 'ڕۆمان',
      'image': 'https://t4.ftcdn.net/jpg/07/08/65/71/360_F_708657199_3Ovqz4ZJzEzNkWkQVBZHjseww5zwXMGB.jpg',
    },
    {'name': 'شیعر', 'image': 'https://img.goodfon.com/wallpaper/big/1/67/kniga-stihi-lavanda-stol.webp'},
    {
      'name': 'چیرۆک',
      'image':
          'https://media.istockphoto.com/id/1146007104/photo/open-book-with-hand-drawn-landscape.jpg?s=612x612&w=0&k=20&c=XZGJWGqjX41Tow4y86cnbJjVfh9I5kKSNGB4rPX4aHk=',
    },
    {
      'name': 'فانتاسی',
      'image': 'https://wallpapers.com/images/hd/fantasy-adventure-emerging-from-book-ipc9z1iy1q2b4mb6.jpg',
    },
    {
      'name': 'خەیاڵی',
      'image':
          'https://thumbs.dreamstime.com/b/storybook-fantasy-reading-collection-fiction-books-opening-up-to-page-filled-castle-dragons-storybook-fantasy-332255436.jpg',
    },
    {
      'name': 'ڕۆمانس',
      'image':
          'https://png.pngtree.com/thumb_back/fh260/background/20250605/pngtree-open-book-with-glowing-hearts-and-wisps-of-smoke-evoking-romance-image_17392124.jpg',
    },
    {
      'name': 'ترسناک',
      'image': 'https://t3.ftcdn.net/jpg/06/04/33/76/360_F_604337685_kCcwRTMmbFKD8ObmYhZRn3tI5a50QbMS.jpg',
    },
    {
      'name': 'نادیار',
      'image': 'https://t4.ftcdn.net/jpg/06/53/51/05/360_F_653510556_oS0CRp63dp9KBuoWNaqqi412M0CvA1GT.jpg',
    },
    {
      'name': 'زمانەوانی',
      'image':
          'https://media.istockphoto.com/id/1041902082/photo/languages-learning-and-translate-communication-and-travel-concept.jpg?s=612x612&w=0&k=20&c=VmbasiLu71HClxUeahWiIQGvJs8M1cSJ75HXsP0c_XY=',
    },
    {
      'name': 'چیرۆکی',
      'image': 'https://w0.peakpx.com/wallpaper/547/144/HD-wallpaper-story-book-twilight-tree-house-girl-art.jpg',
    },
    {'name': 'خەیاڵی ئەدەبی', 'image': 'literary_fiction.jpg'},
    {'name': 'مێژووی', 'image': 'history.jpg'},
    {'name': 'زانستی خەیاڵی', 'image': 'science_fiction.jpg'},
  ];

  int selectedTypeIndex = 0;
  int _currentIndex = 0;

  late Future<List<Books>> booksFuture;
  late Future<List<Books>> randomBooks;
  late Future<List<SeriesResponse>> series;

  final GlobalKey<State<MyBooks>> _myBooksKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    booksFuture = fetchBooks();
    randomBooks = fetchRandomBooks(types[selectedTypeIndex]['name']!);
    series = fetchAllSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      bottomNavigationBar: SafeArea(
        bottom: false,
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF1F1F1F),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade600,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              if (index == 1) {
                _myBooksKey.currentState?.setState(() {});
              }
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.book_online), label: 'my Books'),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
        ),
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            booksFuture: booksFuture,
            randomBooks: randomBooks,
            series: series,
            types: types,
            onTypeSelected: (index) {
              setState(() {
                selectedTypeIndex = index;
                randomBooks = fetchRandomBooks(types[selectedTypeIndex]['name']!);
              });
            },
            selectedTypeIndex: selectedTypeIndex,
          ),
          const MyBooks(),
          Discover(),
          const Center(child: Text('Search Screen')),
        ],
      ),
    );
  }
}
