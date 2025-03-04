//
//  Book.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-09.
//

import Foundation

struct BookResults: Codable {
    var items: [Book]
}

struct VolumeInfo: Codable {
    var title: String
    var authors: [String]?
    var pageCount: Int?
    var categories: [String]?
    var industryIdentifiers: [IndustryIdentifiers]?
}

struct IndustryIdentifiers: Codable {
    var identifier: String?
}

struct SearchInfo: Codable {
    var textSnippet: String?
}

struct Book: Codable {
    var id: String
    var volumeInfo: VolumeInfo?
    var searchInfo: SearchInfo?
    var coverURL: String? {
        return "https://books.google.com/books/publisher/content/images/frontcover/\(id)?fife=w400-h600&source=gbs_api"
    }
}


