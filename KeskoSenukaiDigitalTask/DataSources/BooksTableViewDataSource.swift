//
//  BooksTableViewDataSource.swift
//  KeskoSenukaiDigitalTask


import Foundation
import UIKit

class BooksTableViewDataSource<CELL : BookTableViewCell, T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : Books
    var configureCell : (CELL, Book) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, items : Books, configureCell : @escaping (CELL, Book) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items[indexPath.section]
        self.configureCell(cell, item)
        return cell
    }
}
