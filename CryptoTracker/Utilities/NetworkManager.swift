//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by NJ Development on 31/05/24.
//

import Combine
import Foundation

final class NetworkManager {
    enum NetworkError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown

        var errorDescription: String? {
            switch self {
            case let .badURLResponse(url: url):
                return "🔥 Bad response from URL: \(url)"
            case .unknown:
                return "⚠️ Unknown error occured"
            }
        }
    }

    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200, response.statusCode < 300 else {
            throw NetworkError.badURLResponse(url: url)
        }
        return output.data
    }

    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished: break

        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
