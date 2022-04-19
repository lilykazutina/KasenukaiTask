//
//  API.swift
//  KeskoSenukaiDigitalTask

import UIKit

class API: NSObject {
    
    func get <T: Decodable>(urlString: String, type: T.Type, _ completionHandler: @escaping (Result<T, Error>) -> Void) {
        getData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                let decodedResult = Result { try JSONDecoder().decode(T.self, from: data) }
                completionHandler(decodedResult)
            case.failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getData(urlString: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(APIError("Unable to create URL: \(urlString)")))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(APIError("API has not returned data")))
                return
            }
            
            completionHandler(.success(data))
        }
        
        task.resume()
    }
}

