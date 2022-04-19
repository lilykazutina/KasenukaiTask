//
//  ListTableViewCellModel.swift
//  KeskoSenukaiDigitalTask

import Foundation
import UIKit

struct BookTableViewCellModel {
    private let bookService = BookService()
    var author: String?
    
    func loadBookDetails(book: Book, completion: @escaping (BookDetails?) -> Void) {
        self.bookService.getBookDetails(bookId: book.id) { bookDetailResult in
            switch bookDetailResult {
            case .success(let bookDetails):
                completion(bookDetails)
            case .failure(let error):
                print("Failed to load book \(book.id) details: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func loadBookImage(book: Book, completion: @escaping (UIImage?) -> Void) {
        self.bookService.getImage(urlString: book.img) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Failed to load image for book \(book.id): \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
