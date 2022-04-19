import UIKit

class BooksViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel : BooksViewModel!
    private var dataSource : BooksTableViewDataSource<BookTableViewCell, [Book]>!
    
    var selectedListId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.viewModel = BooksViewModel(booksListId: selectedListId)
        self.viewModel.bindBooksViewModelToController = {
            self.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        self.dataSource = BooksTableViewDataSource(cellIdentifier: bookTableViewCell, items: self.viewModel.booksList.books, configureCell: { (cell, data) in cell.load(book: data) })
        
        DispatchQueue.main.async {
            if let errorMessage = self.viewModel.errorMessage {
                Alert().showAlert(title: errorTitle, errorMessage: errorMessage, presenter: self)
            } else {
                self.title = self.viewModel.booksList.title
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            }
            
            self.refreshControl.endRefreshing()
        }
    }
}
extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = viewModel.booksList.books[indexPath.section]
        tableView.deselectRow(at: indexPath, animated: true)
        showSelectedBook(book)
    }
    
    func showSelectedBook(_ book: Book) {
        BookDetailsCoordinator(presenter: self.navigationController!, bookData: book).start()
    }
}
