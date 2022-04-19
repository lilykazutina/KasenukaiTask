//
//  ListsViewModel.swift
//  KeskoSenukaiDigitalTask

import UIKit

class ListsViewModel {
    private let bookService: BookService
    
    var errorMessage: String?
    
    private(set) var lists : BooksLists! {
        didSet {
            self.bindListsViewModelToController()
        }
    }
    
    var bindListsViewModelToController : (() -> ()) = {}
    
    init(bookService: BookService = BookService()) {
        self.bookService = bookService
        self.bookService.getBooksLists() { result in
            switch result {
            case .success(let bookLists):
                self.lists = bookLists
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
