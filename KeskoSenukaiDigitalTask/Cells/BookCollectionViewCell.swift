//
//  BookCollectionViewCell.swift
//  KeskoSenukaiDigitalTask

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    private let viewModel = BookCollectionViewCellModel()
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func load(book: Book) {
        titleLabel.text = book.title
        
        viewModel.loadImage(book:book) { image in
            DispatchQueue.main.async() {
                self.bookImageView.image = image
            }
        }
    }
}
