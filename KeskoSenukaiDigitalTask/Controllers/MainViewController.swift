//
//  ViewController.swift
//  KeskoSenukaiDigitalTask

import UIKit

class MainViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: ListsViewModel!
    private var tableViewDataSource : ListsTableViewDataSource<ListTableViewCell, BooksList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Books Library"
        tableView.separatorStyle = .none
        callToViewModelForUIUpdate()
        setupRefreshControl()
    }
    
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: refreshControlTitle)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        callToViewModelForUIUpdate()
    }
    
    private func callToViewModelForUIUpdate() {
        self.viewModel = ListsViewModel()
        self.viewModel.bindListsViewModelToController = {
            self.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        self.tableViewDataSource = ListsTableViewDataSource(cellIdentifier: listCell, items: self.viewModel.lists, configureCell: { (cell, data, indexPath) in
            cell.books = self.viewModel.lists[indexPath.section].books
            cell.listLabel.text = data.title
            cell.allButton.tag = data.id
            cell.allButton.addTarget(self, action: #selector(self.showSelectedList), for: .touchUpInside)
        })
        
        DispatchQueue.main.async {
            if let errorMessage = self.viewModel.errorMessage {
                Alert().showAlert(title: errorTitle, errorMessage: errorMessage, presenter: self)
            } else {
                self.tableView.dataSource = self.tableViewDataSource
                self.tableView.reloadData()
            }
            
            self.refreshControl.endRefreshing()
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController()
        alert.title = title
        alert.message = message
        present(alert, animated: true)
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ListTableViewCell()
    }
    
    @objc func showSelectedList(sender: UIButton) {
        BooksCoordinator(presenter: self.navigationController!, selectedListId: sender.tag).start()
    }
}

