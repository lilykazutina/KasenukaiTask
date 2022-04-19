//
//  ListDTO.swift
//  KeskoSenukaiDigitalTask

import Foundation

class ListDTO : Codable {
    let id: Int
    let title: String
}

typealias ListsDTO = [ListDTO]
