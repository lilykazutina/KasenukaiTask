//
//  BookService.swift
//  KeskoSenukaiDigitalTask

import Foundation
import UIKit

class BookService {
    private let endpoint: String
    private let api: API
    
    init(endpoint: String = bookServiceEndpoint) {
        self.endpoint = endpoint
        self.api = API()
    }
    
    func getImage(urlString: String, _ completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        api.getData(urlString: urlString) { result in
            switch (result) {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completionHandler(.failure(APIError("Unable to decode image")))
                    return
                }
                
                completionHandler(.success(image))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBooksLists(_ completionHandler: @escaping (Result<BooksLists, Error>) -> Void) {
        api.get(urlString: "\(bookServiceEndpoint)/assignment/lists", type: ListsDTO.self) { listsResult in
            
            switch listsResult {
            case .success(let lists):
                self.getAllBooks() { booksResult in
                    switch booksResult {
                    case .success(let books):
                        let groupedBooks = Dictionary(grouping: books, by: { $0.listID })
                        let booksLists = lists.map { booksList in
                            BooksList(id: booksList.id, title: booksList.title, books: groupedBooks[booksList.id] ?? Books())
                        }
                        completionHandler(.success(booksLists))
                        
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBooksList(booksListId: Int, _ completionHandler: @escaping (Result<BooksList, Error>) -> Void) {
        
        getBooksLists() { booksListsResult in
            switch booksListsResult {
            case .success(let booksLists):
                let booksList = booksLists.first(where: { $0.id == booksListId })
                guard let booksList = booksList else {
                    completionHandler(.failure(APIError("Books list was not found")))
                    return
                }
                
                completionHandler(.success(booksList))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBookDetails(bookId: Int, _ completionHandler: @escaping (Result<BookDetails, Error>) -> Void) {
        api.get(urlString: "\(bookServiceEndpoint)/assignment/book/\(bookId)", type: BookDetails.self, completionHandler)
    }
    
    private func getAllBooks(_ completionHandler: @escaping (Result<Books, Error>) -> Void) {
        api.get(urlString: "\(bookServiceEndpoint)/assignment/books", type: Books.self, completionHandler)
    }
}
