//
//  APIError.swift
//  KeskoSenukaiDigitalTask

import Foundation

struct APIError : LocalizedError
{
    var errorDescription: String? { return message }
    var failureReason: String? { return message }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }

    private let message : String

    init(_ message: String)
    {
        self.message = message
    }
}
