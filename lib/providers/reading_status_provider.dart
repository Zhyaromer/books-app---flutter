import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:books_app__flutter/model/BookDetailResponse.dart';
import 'package:books_app__flutter/model/reading_status_list.dart';

class ReadingStatusNotifier extends Notifier<ReadingStatusState> {
  @override
  ReadingStatusState build() {
    return ReadingStatusState(booksList: [], customStatuses: []);
  }

  void addCustomStatus(String label) {
    final trimmed = label.trim();
    if (trimmed.isEmpty) return;

    final allStatuses = [...defaultStatuses, ...state.customStatuses];
    final exists = allStatuses.any((s) => s.label.toLowerCase() == trimmed.toLowerCase());
    if (exists) return;

    state = state.copyWith(
      customStatuses: [
        ...state.customStatuses,
        ReadingStatusItem(label: trimmed),
      ],
    );
  }

  void removeCustomStatus(ReadingStatusItem status) {
    state = state.copyWith(
      customStatuses: state.customStatuses.where((s) => s.label != status.label).toList(),
      booksList: state.booksList.where((b) => b.status.label != status.label).toList(),
    );
  }

  int totalBookCountPerStatus(String statusLabel) {
    return state.booksList.where((book) => book.status.label == statusLabel).length;
  }

  String getLatestImageForStatus(String statusLabel) {
    for (var book in state.booksList.reversed) {
      if (book.status.label == statusLabel) {
        return book.coverImage;
      }
    }
    return 'none';
  }

  List<ReadingStatusList> allBooksForStatus(String statusLabel) {
    return state.booksList.where((book) => book.status.label == statusLabel).toList();
  }

  String getSelectedStatusLabel(int bookId) {
    bool isBookFound = state.booksList.any((book) => book.id == bookId);
    if (isBookFound) {
      return state.booksList.firstWhere((book) => book.id == bookId).status.label;
    }
    return 'Want To Read';
  }

  List<ReadingStatusItem> get allStatuses => [...defaultStatuses, ...state.customStatuses];

  void addOrUpdateBookStatus(int bookId, String status, Book book) {
    int existingIndex = state.booksList.indexWhere((b) => b.id == bookId);
    final allStatusesLocal = allStatuses;

    List<ReadingStatusList> updatedBooksList = List.from(state.booksList);

    if (existingIndex != -1) {
      final existingBook = updatedBooksList[existingIndex];
      updatedBooksList[existingIndex] = ReadingStatusList(
        id: bookId,
        title: existingBook.title,
        name: existingBook.name,
        description: existingBook.description,
        status: allStatusesLocal.firstWhere((s) => s.label == status, orElse: () => allStatusesLocal[0]),
        coverImage: existingBook.coverImage,
        genre: existingBook.genre,
        addedDate: existingBook.addedDate,
        page_count: existingBook.page_count,
      );
    } else {
      updatedBooksList.add(
        ReadingStatusList(
          id: bookId,
          title: book.title ?? '',
          name: book.name ?? '',
          description: book.description ?? '',
          status: allStatusesLocal.firstWhere((s) => s.label == status, orElse: () => allStatusesLocal[0]),
          coverImage: book.cover_image ?? '',
          genre: book.genre ?? '',
          addedDate: DateTime.now(),
          page_count: book.page_count ?? 0,
        ),
      );
    }

    state = state.copyWith(booksList: updatedBooksList);
  }
}

class ReadingStatusState {
  final List<ReadingStatusList> booksList;
  final List<ReadingStatusItem> customStatuses;

  ReadingStatusState({required this.booksList, required this.customStatuses});

  ReadingStatusState copyWith({List<ReadingStatusList>? booksList, List<ReadingStatusItem>? customStatuses}) {
    return ReadingStatusState(
      booksList: booksList ?? this.booksList,
      customStatuses: customStatuses ?? this.customStatuses,
    );
  }
}

final readingStatusProvider = NotifierProvider<ReadingStatusNotifier, ReadingStatusState>(() {
  return ReadingStatusNotifier();
});
