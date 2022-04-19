//
//  ListTableViewCell.swift
//  KeskoSenukaiDigitalTask

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var booksCollectionView: UICollectionView!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var listLabel: UILabel!
    
    var books = Books()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        booksCollectionView.dataSource = self
        booksCollectionView.delegate = self
        self.selectionStyle = .none
        setupButton()
        addBorder()
    }
    
    func setupButton(){
        allButton.layer.borderWidth = 1
        allButton.layer.cornerRadius = 3
        allButton.layer.borderColor = UIColor.systemBlue.cgColor
        allButton.setTitle(allButtonTitle, for: .normal)
    }
    
    private func addBorder() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
    }
}
extension ListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width:120, height: 160)
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(books.count, 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookCollectionCell, for: indexPath) as! BookCollectionViewCell
        cell.load(book: books[indexPath.row])
        
        return cell
    }
}
