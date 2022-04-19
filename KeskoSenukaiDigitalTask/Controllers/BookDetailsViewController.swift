//
//  BookViewController.swift
//  KeskoSenukaiDigitalTask

import UIKit

class BookDetailsViewController: UIViewController {
    
    var bookData: Book!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var publicationDateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    private var viewModel : BookDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = bookData.title
        callToViewModelForUIUpdate()
        setupRefreshButton()
    }
    
    func setupRefreshButton() {
        let refreshButton = UIBarButtonItem(title: refreshButtonTitle, style: .plain, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc func refresh() {
        callToViewModelForUIUpdate()
    }
    
    private func callToViewModelForUIUpdate() {
        self.viewModel = BookDetailsViewModel(bookID: bookData.id)
        self.viewModel.bindBookDetailsViewModelToController = {
            self.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        if let errorMessage = self.viewModel.errorMessage {
            DispatchQueue.main.async {
                Alert().showAlert(title: errorTitle, errorMessage: errorMessage, presenter: self)
            }
        } else {
            viewModel.loadImage(bookDetails: viewModel.details) { image in
                DispatchQueue.main.async {
                    self.coverImageView.image = image
                }
            }
            
            DispatchQueue.main.async {
                self.bookTitleLabel.text = self.viewModel.details.title
                self.authorLabel.text = self.viewModel.details.author
                self.isbnLabel.text = self.viewModel.details.isbn
                self.publicationDateLabel.text = self.viewModel.details.publicationDate?.stringToDate()?.dateToString()
                self.descriptionTextView.text = self.viewModel.details.bookDetailsDescription
            }
        }
    }
}
