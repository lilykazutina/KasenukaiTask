//
//  BookDetailsCoordinator.swift
//  KeskoSenukaiDigitalTask

import Foundation
import UIKit

class BookDetailsCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var bookDetailsController: BookDetailsViewController?
    private var bookData: Book
    
    init(presenter: UINavigationController, bookData: Book) {
        self.presenter = presenter
        self.bookData = bookData
    }
    
    func start() {
        let storyboard = UIStoryboard(name: mainStoryboard, bundle: nil)
        guard let bookDetailsController = storyboard.instantiateViewController(identifier: bookDetailsViewControllerIdentifier) as? BookDetailsViewController else {
            print("BookDetailsViewController not found")
            return
    }
        bookDetailsController.title = bookData.title
        bookDetailsController.bookData = bookData
        presenter.pushViewController(bookDetailsController, animated: true)
        self.bookDetailsController = bookDetailsController
    }
}
