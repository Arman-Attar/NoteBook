//
//  CoreDataViewModel.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-12.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    static let shared = CoreDataViewModel()
    
    private init() {
        container = NSPersistentContainer(name: "BooksContainer")
        container.loadPersistentStores { description, err in
            if let err = err {
                print("Error Loading Core Data \(err)")
            } else {
                print("Core Data Loaded")
            }
        }
    }
    
    func fetchBooks() -> [BookEntity] {
        var books: [BookEntity] = []
        let request = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        do {
            books = try container.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
        return books
    }
    
    func fetchBook(isbn: String) -> BookEntity? {
        let request = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        let filter = NSPredicate(format:"isbn == %@", isbn)
        request.predicate = filter
        do {
            let books = try container.viewContext.fetch(request)
            return books.first
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func addBook(book: Book) {
        let newBook = BookEntity(context: container.viewContext)
        newBook.authors = book.volumeInfo?.authors
        newBook.title = book.volumeInfo?.title
        newBook.coverURL = book.coverURL
        newBook.id = book.id
        newBook.isbn = book.volumeInfo?.industryIdentifiers?.first?.identifier
        newBook.categories = book.volumeInfo?.categories
        newBook.pageCount = Int16(book.volumeInfo?.pageCount ?? 0)
        newBook.textSnippet = book.searchInfo?.textSnippet
        saveData()
    }
    
    func saveData(){
        do {
            try container.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func deleteBook(book: BookEntity) {
        container.viewContext.delete(book)
        saveData()
    }
    
    func addNote(book: BookEntity, title: String, type: String, page: String, chapter: String, note: String) {
        let newNote = NoteEntity(context: container.viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.chapter = chapter
        newNote.pageNumber = page
        newNote.type = type
        newNote.note = note
        newNote.book = book
        saveData()
    }
    
    func deleteNote(note: NoteEntity) {
        container.viewContext.delete(note)
        saveData()
    }
}
