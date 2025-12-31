import 'package:books_app__flutter/Dio.dart';
import 'package:books_app__flutter/authordetails.dart';
import 'package:books_app__flutter/bookdetails.dart';
import 'package:books_app__flutter/seriesdetails.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _isSearching = false;

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int selectedTypeIndex = 0;

    void indexSelected(index) {
      setState(() {
        selectedTypeIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      body: Center(
        child: _isSearching
            ? SearchedScreen()
            : Column(
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: const Color(0xFF121212),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                      child: Column(
                        children: [
                          TextField(
                            onTap: () {
                              setState(() {
                                _isSearching = true;
                              });
                            },
                            onChanged: (value) {
                              //
                            },
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                              hintText: 'Search for books, authors, series...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                      child: Text('Explore popular genres', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),

                  SizedBox(height: 20),

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
                      itemCount: types.length,
                      itemBuilder: (context, index) {
                        final type = types[index];
                        final isSelected = index == selectedTypeIndex;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: isSelected ? Colors.white : Colors.grey, width: 2.0),
                            color: isSelected ? const Color(0xFF121212) : Colors.grey[800],
                            image: DecorationImage(
                              image: NetworkImage(types[index]['image']!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                            ),
                          ),

                          child: InkWell(
                            onTap: () {
                              indexSelected(index);
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
    );
  }
}

class SearchedScreen extends StatefulWidget {
  const SearchedScreen({super.key});

  @override
  State<SearchedScreen> createState() => _SearchedScreenState();
}

class _SearchedScreenState extends State<SearchedScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> Books = [];
  List<dynamic> authors = [];
  List<dynamic> series = [];
  String _errorMessage = '';
  bool _isLoading = false;

  Future<dynamic> fetchSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        Books = [];
        authors = [];
        series = [];
      });
      return;
    } else {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });
      try {
        final res = await dio.get('/user/search/$query');

        if (res.statusCode == 200) {
          setState(() {
            Books = res.data['books'];
            authors = res.data['authors'];
            series = res.data['series'];
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5, offset: const Offset(0, 3))],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextField(
            controller: _searchController,
            onChanged: fetchSearch,
            decoration: InputDecoration(
              hintText: 'Search for books, authors, series...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
            ),
          ),
        ),

        const SizedBox(height: 16),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Search Results', style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),

        const SizedBox(height: 12),

        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  ),
                  child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(text: 'Books'),
                      Tab(text: 'Authors'),
                      Tab(text: 'Series'),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                _errorMessage.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(_errorMessage, style: const TextStyle(color: Colors.red)),
                      )
                    : _isLoading
                    ? const Expanded(
                        child: Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(color: Colors.purple, strokeWidth: 5),
                          ),
                        ),
                      )
                    : Expanded(
                        child: TabBarView(
                          children: [
                            Books.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _isLoading
                                            ? ''
                                            : _searchController.text.isEmpty
                                            ? 'Try searching for books'
                                            : 'No results for "${_searchController.text}"',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                : booksCard(Books),
                            authors.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _isLoading
                                            ? ''
                                            : _searchController.text.isEmpty
                                            ? 'Try searching for authors'
                                            : 'No results for "${_searchController.text}"',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                : authorsCard(authors),
                            series.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _isLoading
                                            ? ''
                                            : _searchController.text.isEmpty
                                            ? 'Try searching for series'
                                            : 'No results for "${_searchController.text}"',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                : seriesCard(series),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget booksCard(List<dynamic> books) {
  return ListView.builder(
    itemCount: books.length,
    itemBuilder: (context, index) {
      final book = books[index];
      return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetails(book_id: book['id'])));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: 200,
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF2C2C2C), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                  child: Image.network(book['cover_image'], width: 125, height: 200, fit: BoxFit.cover),
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
                            Text(book['title'], style: const TextStyle(color: Colors.white, fontSize: 22)),
                            SizedBox(height: 8),

                            Text(
                              book['description'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(12)),
                          child: Text(book['genre'], style: TextStyle(color: Colors.white, fontSize: 12)),
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
  );
}

Widget authorsCard(List<dynamic> authors) {
  return ListView.builder(
    itemCount: authors.length,
    itemBuilder: (context, index) {
      final author = authors[index];
      return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorDetails(id: author['id'])));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: 200,
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF2C2C2C), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                  child: Image.network(author['imgURL'], width: 125, height: 200, fit: BoxFit.cover),
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
                            Text(author['name'], style: const TextStyle(color: Colors.white, fontSize: 22)),
                            SizedBox(height: 8),

                            Text(
                              author['bio'],
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
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
  );
}

Widget seriesCard(List<dynamic> series) {
  return ListView.builder(
    itemCount: series.length,
    itemBuilder: (context, index) {
      final book = series[index];
      return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => seriesdetails(series_id: book['id'])));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: 200,
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF2C2C2C), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                  child: Image.network(book['cover_img'], width: 125, height: 200, fit: BoxFit.cover),
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
                            Text(book['series_title'], style: const TextStyle(color: Colors.white, fontSize: 22)),
                            SizedBox(height: 8),

                            Text(
                              book['description'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(12)),
                          child: Text(book['state'], style: TextStyle(color: Colors.white, fontSize: 12)),
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
  );
}
