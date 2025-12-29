import 'package:books_app__flutter/model/BookDetailResponse.dart';

enum ReadingStatus { wantToRead, currentlyReading, finished, didNotFinish }

class ReadingStatusItem {
  final ReadingStatus? enumValue;
  final String label;

  const ReadingStatusItem({this.enumValue, required this.label});

  bool get isCustom => enumValue == null;
}

final List<ReadingStatusItem> defaultStatuses = [
  const ReadingStatusItem(enumValue: ReadingStatus.wantToRead, label: 'Want To Read'),
  const ReadingStatusItem(enumValue: ReadingStatus.currentlyReading, label: 'Currently Reading'),
  const ReadingStatusItem(enumValue: ReadingStatus.finished, label: 'Finished'),
  const ReadingStatusItem(enumValue: ReadingStatus.didNotFinish, label: 'Did Not Finish'),
];

final List<ReadingStatusItem> customStatuses = [];

void addCustomStatus(String label) {
  final trimmed = label.trim();
  if (trimmed.isEmpty) return;

  final exists = [...defaultStatuses, ...customStatuses].any((s) => s.label.toLowerCase() == trimmed.toLowerCase());

  if (exists) return;

  customStatuses.add(ReadingStatusItem(label: trimmed));
}

List<ReadingStatusItem> get allStatuses => [...defaultStatuses, ...customStatuses];

class ReadingStatusList {
  final int id;
  final String title;
  final String name;
  final String description;
  final ReadingStatusItem status;
  final String coverImage;
  final String genre;
  final DateTime? addedDate;
  final int page_count;

  ReadingStatusList({
    required this.id,
    required this.title,
    required this.name,
    required this.description,
    required this.status,
    required this.coverImage,
    required this.genre,
    this.addedDate,
    this.page_count = 0,
  });
}

void removeCustomStatus(ReadingStatusItem status) {
  customStatuses.removeWhere((s) => s.label == status.label);
  booksList.removeWhere((b) => b.status.label == status.label);
}

int totalBookCountPerStatus(String statusLabel) {
  int count = 0;

  for (var book in booksList) {
    if (book.status.label == statusLabel) {
      count++;
    }
  }

  return count;
}

String getLatestImageForStatus(String statusLabel) {
  for (var book in booksList.reversed) {
    if (book.status.label == statusLabel) {
      return book.coverImage;
    }
  }
  return 'none';
}

List<ReadingStatusList> allBooksForStatus(String statusLabel) {
  return booksList.where((book) => book.status.label == statusLabel).toList();
}

List<ReadingStatusItem> allStatusesList() {
  return allStatuses;
}

String getSelectedStatusLabel(int bookdId) {
  bool isBookFound = booksList.any((book) => book.id == bookdId);
  if (isBookFound) {
    String selectedLabel = booksList.firstWhere((book) => book.id == bookdId).status.label;
    return selectedLabel;
  } else {
    return 'Want To Read';
  }
}

bool addOrUpdateBookStatus(int bookId, String status, Book book) {
  int existingIndex = booksList.indexWhere((b) => b.id == bookId);
  if (existingIndex != -1) {
    final book = booksList[existingIndex];
    booksList[existingIndex] = ReadingStatusList(
      id: bookId,
      title: book.title,
      name: book.name,
      description: book.description,
      status: allStatuses.firstWhere((s) => s.label == status, orElse: () => allStatuses[0]),
      coverImage: book.coverImage,
      genre: book.genre,
      addedDate: book.addedDate,
      page_count: book.page_count,
    );
    return true;
  } else {
    booksList.add(
      ReadingStatusList(
        id: bookId,
        title: book.title ?? '',
        name: book.name ?? '',
        description: book.description ?? '',
        status: allStatuses.firstWhere((s) => s.label == status, orElse: () => allStatuses[0]),
        coverImage: book.cover_image ?? '',
        genre: book.genre ?? '',
        addedDate: DateTime.now(),
        page_count: book.page_count ?? 0,
      ),
    );
    return false;
  }
}

final List<ReadingStatusList> booksList = [
  ReadingStatusList(
    id: 1,
    title: 'The Great Gatsby 1 ',
    name: 'F. Scott Fitzgerald',
    description:
        'The Great Gatsby is a 1925 tragedy novel by American writer F. Scott Fitzgerald. Set in the Jazz Age on Long Island, near New York City',
    status: allStatuses[0],
    coverImage: 'https://res.cloudinary.com/bloomsbury-atlas/image/upload/w_568,c_scale/jackets/9781408855652.jpg',
    genre: 'Classic',
    addedDate: DateTime(2023, 10, 5),
    page_count: 222,
  ),
  ReadingStatusList(
    id: 2,
    title: 'Zhe Great Gatsby 2 ',
    name: 'F. Scott Fitzgerald',
    description:
        'The Great Gatsby is a 1925 tragedy novel by American writer F. Scott Fitzgerald. Set in the Jazz Age on Long Island, near New York City',
    status: allStatuses[0],
    coverImage: 'https://res.cloudinary.com/bloomsbury-atlas/image/upload/w_568,c_scale/jackets/9781408855652.jpg',
    genre: 'Classic',
    addedDate: DateTime(2023, 10, 6),
    page_count: 213,
  ),
  ReadingStatusList(
    id: 3,
    title: 'Ahe Great Gatsby 3 ',
    name: 'F. Scott Fitzgerald',
    description:
        'The Great Gatsby is a 1925 tragedy novel by American writer F. Scott Fitzgerald. Set in the Jazz Age on Long Island, near New York City',
    status: allStatuses[0],
    coverImage: 'https://res.cloudinary.com/bloomsbury-atlas/image/upload/w_568,c_scale/jackets/9781408855652.jpg',
    genre: 'Classic',
    addedDate: DateTime(2023, 10, 7),
    page_count: 250,
  ),
  ReadingStatusList(
    id: 4,
    title: '1984',
    name: 'George Orwell',
    description: 'A dystopian novel about totalitarianism.',
    status: allStatuses[1],
    coverImage: 'https://mir-s3-cdn-cf.behance.net/project_modules/1400/b468d093312907.5e6139cf2ab03.png',
    genre: 'Dystopian',
    addedDate: DateTime(2023, 11, 12),
    page_count: 328,
  ),
  ReadingStatusList(
    id: 5,
    title: 'To Kill a Mockingbird',
    name: 'Harper Lee',
    description: 'A novel about racial injustice in the Deep South.',
    status: allStatuses[2],
    coverImage:
        'https://i5.walmartimages.com/asr/ac2f5508-245a-4c14-9821-a06a324fe0a2_1.a9c312d32902c17f7786af968ce71867.jpeg',
    genre: 'Classic',
    addedDate: DateTime(2024, 1, 20),
    page_count: 281,
  ),
];
