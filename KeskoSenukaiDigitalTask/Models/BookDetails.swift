//
//  BookDetails.swift
//  KeskoSenukaiDigitalTask

import Foundation

struct BookDetails: Codable {
    let id, listID: Int
    let publicationDate: String?
    let author: String?
    let title: String
    let img: String
    let isbn: String?
    let bookDetailsDescription: String?

    enum CodingKeys: String, CodingKey {
        case id
        case listID = "list_id"
        case author, title, img, isbn
        case bookDetailsDescription = "description"
        case publicationDate = "publication_date"
    }
}
