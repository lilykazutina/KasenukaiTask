//
//  BooksViewModel.swift
//  KeskoSenukaiDigitalTask

import Foundation
import UIKit

class BooksViewModel {
    private let bookService: BookService
    
    var errorMessage: String?
    
    private(set) var booksList : BooksList! {
        didSet {
            self.bindBooksViewModelToController()
        }
    }
    
    var bindBooksViewModelToController : (() -> ()) = {}
    
    init(bookService: BookService = BookService(), booksListId: Int) {
        self.bookService = bookService
        bookService.getBooksList(booksListId: booksListId) { result in
            switch result {
            case .success(let booksList):
                self.booksList = booksList
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
