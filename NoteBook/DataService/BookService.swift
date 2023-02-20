//
//  BookService.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-09.
//

import Foundation

final class BookService {
    let urlSession = URLSession.shared
    
    func fetchBook(isbn: String) async throws -> Book? {
        guard let url = URL(string: APIConstants.isbnURL.appending(isbn).appending(apiKey)) else {return nil}
        let (data, _ ) = try await urlSession.data(from: url)
        let decoded = try JSONDecoder().decode(BookResults.self, from: data)
        if let book = decoded.items.first {
            return book
        } else {
            return nil
        }
    }
    
    func searchBook(title: String) async throws -> [Book] {
        guard let url = URL(string: APIConstants.nameSearchURL.appending(title).appending(apiKey)) else {return []}
        let (data, _) = try await urlSession.data(from: url)
        let decoded = try JSONDecoder().decode(BookResults.self, from: data)
        if decoded.items.isEmpty {
            return []
        } else {
            return decoded.items
        }
    }
}
