//
//  BookDetailsViewModel.swift
//  KeskoSenukaiDigitalTask

import Foundation
import UIKit

class BookDetailsViewModel {
    private let bookService: BookService
    
    var errorMessage: String?
    
    private(set) var details : BookDetails! {
        didSet {
            self.bindBookDetailsViewModelToController()
        }
    }
    
    var bindBookDetailsViewModelToController : (() -> ()) = {}
    
    init(bookID: Int, bookService: BookService = BookService()) {
        self.bookService = bookService
        self.bookService.getBookDetails(bookId: bookID) { result in
            switch result {
            case .success(let bookDetails):
                self.details = bookDetails
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func loadImage(bookDetails: BookDetails, completion: @escaping (UIImage?) -> Void) {
        self.bookService.getImage(urlString: bookDetails.img) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Failed to load image for book \(bookDetails.id) details: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
