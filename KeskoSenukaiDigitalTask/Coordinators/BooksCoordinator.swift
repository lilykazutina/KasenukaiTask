//
//  BooksCoordinator.swift
//  KeskoSenukaiDigitalTask


import Foundation
import UIKit

class BooksCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var booksViewController: BooksViewController?
    private var selectedListId: Int
    
    init(presenter: UINavigationController, selectedListId: Int) {
        self.presenter = presenter
        self.selectedListId = selectedListId
    }
    
    func start() {
        let storyboard = UIStoryboard(name: mainStoryboard, bundle: nil)
        guard let booksViewController = storyboard.instantiateViewController(identifier: booksViewControllerIdentifier) as? BooksViewController else {
            print("BooksViewController not found")
            return
        }
        
        booksViewController.selectedListId = selectedListId
        presenter.pushViewController(booksViewController, animated: true)
        self.booksViewController = booksViewController
    }
}
