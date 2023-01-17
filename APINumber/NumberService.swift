//
//  NumberService.swift
//  APINumber
//
//  Created by Marc-Antoine BAR on 2022-12-26.
//

import Foundation


enum NetworkError: Error {
    case errorNil
    case statusCode
    case decoderJSON
}

final class NumberService {
    
    //MARK: - Properties
    
    private let urlSession = URLSession(configuration: .default)
    
    //MARK: - API call
    
    func fetchDataNumbers(number:Int, callback: @escaping (Result<Number, NetworkError>) -> Void) {
        let url = "http://numbersapi.com/\(number)?json"
        print(url)
        guard let url = URL(string: url) else {
            print("errorURL")
            return
        }

        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(.failure(.errorNil))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(.statusCode))
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Number.self, from: data) else {
                    callback(.failure(.decoderJSON))
                    return
                }
                callback(.success(responseJSON))
            }
        }
        task.resume()
    }
}

