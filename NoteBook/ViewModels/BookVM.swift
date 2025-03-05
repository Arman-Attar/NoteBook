//
//  BookVM.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-09.
//

import Foundation

class BookViewModel: ObservableObject {
    @Published var searchedBook: Book?
    @Published var book: BookEntity?
    @Published var books: [BookEntity] = []
    @Published var searchedBooks: [Book] = []
    @Published var added = false
    @Published var loaded = false
    let bookService = BookService()
    
    init() {
        self.books = CoreDataViewModel.shared.fetchBooks()
        self.loaded = true
    }
    
    func addNote(title: String, type: String, page: String, chapter: String, note: String) {
        guard let book = book, let isbn = book.isbn else {return}
        let formattedNote = type == "Quote" ? "\"\(note)\"" : note
        guard let bookEntity = self.book else {return}
        CoreDataViewModel.shared.addNote(book: bookEntity, title: title, type: type, page: page, chapter: chapter, note: formattedNote)
        self.book = CoreDataViewModel.shared.fetchBook(isbn: isbn)
    }
    
    func deleteNote(offSet: IndexSet?, noteID: UUID?) {
        guard let book = book, let isbn = book.isbn else {return}
        guard let notes = book.notes?.allObjects as? [NoteEntity] else {return}
        if let index = offSet?.first {
            CoreDataViewModel.shared.deleteNote(note: notes[index])
        } else if let noteID = noteID {
            if let note = notes.first(where: {$0.id == noteID}) {
                CoreDataViewModel.shared.deleteNote(note: note)
            }
        }
        self.book = CoreDataViewModel.shared.fetchBook(isbn: isbn)
    }
    
    
    func setBook(book: BookEntity) {
        let newBook = Book(
            id: book.id ?? "",
            volumeInfo: VolumeInfo(
                title: book.title ?? "Title N/a",
                authors: book.authors ?? [],
                pageCount: Int(book.pageCount),
                categories: book.categories ?? [],
                industryIdentifiers:[
                    IndustryIdentifiers(identifier: book.isbn ?? "")
                ]),
            searchInfo: SearchInfo(
                textSnippet: book.textSnippet ?? "Text Snippet not available")
        )
        self.searchedBook = newBook
        self.book = book
        self.added = true
    }
    
    func getBook(isbn: String) async {
        await MainActor.run {
            self.searchedBook = nil
        }
        do {
            if let book = try await bookService.fetchBook(isbn: isbn) {
                await MainActor.run(body: {
                    self.searchedBook = book
                    if books.contains(where: {$0.isbn == isbn}) {
                        self.added = true
                    } else {
                        self.added = false
                    }
                })
            } else {
                self.searchedBook = nil
            }
        } catch {
            print(error)
        }
    }
    
    func searchBook(title: String) async {
        let formattedQuery = title.replacingOccurrences(of: " ", with: "+")
        await MainActor.run(body: {
            self.searchedBooks = []
        })
        do {
            let books = try await bookService.searchBook(title: formattedQuery)
            await MainActor.run(body: {
                if !books.isEmpty {
                    self.searchedBooks = books
                } else {
                    self.searchedBooks = []
                }
            })
        } catch let error {
            print(error)
            await MainActor.run(body: {
                self.searchedBooks = []
            })
        }
    }
    
    func resetSearedBooks() {
        self.searchedBooks = []
    }
    
    func addBook(book: Book) {
        CoreDataViewModel.shared.addBook(book: book)
        self.books = (CoreDataViewModel.shared.fetchBooks())
        self.added = true
    }
    
    func deleteBook(isbn: String) {
        if let index = books.firstIndex(where: {$0.isbn == isbn}) {
            CoreDataViewModel.shared.deleteBook(book: books[index])
            self.books = CoreDataViewModel.shared.fetchBooks()
            self.added = false
        }
    }
    
}
