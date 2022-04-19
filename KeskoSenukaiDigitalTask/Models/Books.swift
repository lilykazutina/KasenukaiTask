//
//  Books.swift
//  KeskoSenukaiDigitalTask

import Foundation

struct Book: Codable {
    let id, listID: Int
    let title: String
    let img: String

    enum CodingKeys: String, CodingKey {
        case id
        case listID = "list_id"
        case title, img
    }
}

typealias Books = [Book]
