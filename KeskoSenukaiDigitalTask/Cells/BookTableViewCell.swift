//
//  BookTableViewCell.swift
//  KeskoSenukaiDigitalTask

import UIKit

class BookTableViewCell: UITableViewCell {
    private let viewModel = BookTableViewCellModel()
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        addBorder()
    }
    
    private func addBorder() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
    }
    
    func load(book: Book) {
        bookTitle.text = book.title
        
        viewModel.loadBookImage(book: book) { image in
            DispatchQueue.main.async() {
                self.coverImageView.image = image
            }
        }
        
        viewModel.loadBookDetails(book: book) { bookDetails in
            DispatchQueue.main.async() {
                self.author.text = bookDetails?.author
            }
        }
    }
}
