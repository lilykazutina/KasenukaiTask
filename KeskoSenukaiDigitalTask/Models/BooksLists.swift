//
//  Lists.swift
//  KeskoSenukaiDigitalTask

import Foundation

struct BooksList {
    let id: Int
    let title: String
    let books: Books
    
    init(id: Int, title: String, books: Books) {
        self.id = id
        self.title = title
        self.books = books
    }
}

typealias BooksLists = [BooksList]
