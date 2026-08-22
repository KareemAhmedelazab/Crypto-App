//
//  NetworkingManger.swift
//  Crypto
//
//  Created by Kareem on 22/08/2026.
//

import Foundation
import Combine

class NetworkingManger {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "bad response from URL. \(url)"
            case .unknown: return "unknown error occured."
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try HandleURLResponse(output: $0,url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }
    
    static func HandleURLResponse(output: URLSession.DataTaskPublisher.Output,url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
