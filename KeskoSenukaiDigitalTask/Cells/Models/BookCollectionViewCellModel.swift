//
//  BookCollectionViewCellModel.swift
//  KeskoSenukaiDigitalTask

import Foundation
import UIKit

class BookCollectionViewCellModel {
    private let bookService = BookService()
    var image: UIImage?
    
    func loadImage(book: Book, completion: @escaping (UIImage?) -> Void) {
        self.bookService.getImage(urlString: book.img) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Failed to load image for book \(book.id) details: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
