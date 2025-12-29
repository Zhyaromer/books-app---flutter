import 'dart:async';

import 'package:books_app__flutter/bookdetails.dart';
import 'package:books_app__flutter/model/books.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  final TextEditingController _searchController = TextEditingController();
  int selectedIndex = 0;
  String? selectedLanguage;
  Timer? _debounce;

  late Future<List<Books>> booksFuture;
  late Future<List<Books>> cachedBooksFuture;

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

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
    booksFuture = getSpecifiedGenreBooks(types[selectedIndex]);
    cachedBooksFuture = booksFuture;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void getSearchedBooks(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        setState(() {
          booksFuture = cachedBooksFuture;
        });
      } else {
        setState(() {
          booksFuture = cachedBooksFuture.then(
            (books) => books
                .where(
                  (book) =>
                      book.title.toLowerCase().contains(query.toLowerCase()) ||
                      book.name.toLowerCase().contains(query.toLowerCase()),
                )
                .toList(),
          );
        });
      }
    });
  }

  void openFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1F1F1F),
              title: const Text('Filter Options', style: TextStyle(color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Language',
                    style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  RadioListTile<String?>(
                    title: const Text('All Languages', style: TextStyle(color: Colors.white)),
                    value: null,
                    groupValue: selectedLanguage,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setDialogState(() {
                        selectedLanguage = value;
                      });
                    },
                  ),
                  RadioListTile<String?>(
                    title: const Text('Kurdish', style: TextStyle(color: Colors.white)),
                    value: 'Kurdish',
                    groupValue: selectedLanguage,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setDialogState(() {
                        selectedLanguage = value;
                      });
                    },
                  ),
                  RadioListTile<String?>(
                    title: const Text('English', style: TextStyle(color: Colors.white)),
                    value: 'English',
                    groupValue: selectedLanguage,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setDialogState(() {
                        selectedLanguage = value;
                      });
                    },
                  ),
                  RadioListTile<String?>(
                    title: const Text('Arabic', style: TextStyle(color: Colors.white)),
                    value: 'Arabic',
                    groupValue: selectedLanguage,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setDialogState(() {
                        selectedLanguage = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedLanguage = null;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Clear', style: TextStyle(color: Colors.white70)),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Text('Apply', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          SizedBox(height: 6),
          Container(
            height: 120,
            width: double.infinity,
            color: const Color(0xFF121212),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      getSearchedBooks(value);
                    },
                    controller: _searchController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(icon: const Icon(Icons.clear), onPressed: _searchController.clear)
                          : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 4),

                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: types.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == selectedIndex;

                        final textWidth = (TextPainter(
                          text: TextSpan(
                            text: types[index],
                            style: TextStyle(
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                        )..layout()).size.width;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              booksFuture = getSpecifiedGenreBooks(types[selectedIndex]);
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  types[index],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.white70,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 2,
                                  width: isSelected ? textWidth : 0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(1),
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
          ),

          Expanded(
            child: FutureBuilder<List<Books>>(
              future: booksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.white));
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No books found', style: TextStyle(color: Colors.white, fontSize: 18)),

                          SizedBox(height: 22),

                          if (_searchController.text.isNotEmpty)
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  booksFuture = getSpecifiedGenreBooks(types[selectedIndex]);
                                });
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                              child: const Text('Clear Search', style: TextStyle(color: Colors.white)),
                            ),
                        ],
                      ),
                    ),
                  );
                } else {
                  var book = snapshot.data!;

                  if (selectedLanguage != null) {
                    book = book.where((b) => b.language == selectedLanguage).toList();
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${book.length} Books Found',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),

                            IconButton(
                              onPressed: () {
                                openFilterDialog();
                              },
                              icon: Icon(Icons.filter_alt_rounded, color: Colors.white, size: 24),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      book.isEmpty
                          ? Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.menu_book, color: Colors.white54, size: 48),
                                    const SizedBox(height: 12),
                                    Text(
                                      'No books found for $selectedLanguage language',
                                      style: const TextStyle(color: Colors.white70),
                                      textAlign: TextAlign.center,
                                    ),

                                    const SizedBox(height: 12),

                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedLanguage = null;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                                      child: const Text('Clear Filter', style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: book.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => BookDetails(book_id: book[index].id)),
                                        );
                                      },
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: const Color(0xFF1F1F1F),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(4),
                                                child: Image.network(
                                                  book[index].cover_image,
                                                  height: 180,
                                                  width: 130,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),

                                              SizedBox(width: 12),

                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      textBaseline: TextBaseline.alphabetic,
                                                      children: [
                                                        Text(
                                                          (index + 1).toString(),
                                                          style: GoogleFonts.montserrat(
                                                            fontSize: 28,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            book[index].title,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    const SizedBox(height: 4),

                                                    Text(
                                                      book[index].name,
                                                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                                                    ),

                                                    const SizedBox(height: 12),

                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(Icons.book, color: Colors.white70, size: 16),
                                                            const SizedBox(width: 4),
                                                            Text(
                                                              '${book[index].page_count} pages',
                                                              style: const TextStyle(
                                                                color: Colors.white70,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        const SizedBox(width: 12),

                                                        Row(
                                                          children: [
                                                            Icon(Icons.language, color: Colors.white70, size: 16),
                                                            const SizedBox(width: 4),
                                                            Text(
                                                              book[index].language,
                                                              style: const TextStyle(
                                                                color: Colors.white70,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        const SizedBox(width: 12),

                                                        Row(
                                                          children: [
                                                            Icon(Icons.language, color: Colors.white70, size: 16),
                                                            const SizedBox(width: 4),
                                                            Text(
                                                              book[index].language,
                                                              style: const TextStyle(
                                                                color: Colors.white70,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
