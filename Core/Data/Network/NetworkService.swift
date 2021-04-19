//
//  NetworkService.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

// MARK: - NetworkSessionManagerProtocol

public protocol NetworkCancellable {
    
    func cancel()
}

extension URLSessionTask: NetworkCancellable {}

// MARK: - NetworkSessionManagerProtocol

public protocol NetworkSessionManagerProtocol {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable
}

// MARK: - NetworkSessionManager

public class NetworkSessionManager: NSObject, NetworkSessionManagerProtocol {
    
    public func request(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
        
        let task = URLSession(configuration: configuration).dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
    
    private var configuration: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.requestCachePolicy = .reloadIgnoringCacheData
        config.urlCredentialStorage = nil
        config.urlCache = nil
        return config
    }
    
    public override init() {
        super.init()
    }
}

// MARK: - NetworkService Protocol

public protocol NetworkServiceProtocol {
    
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request(endpoint: Requestable,
                 completion: @escaping CompletionHandler) -> NetworkCancellable?
}

// MARK: - NetworkService

public final class NetworkService {
    
    private let config: NetworkConfigProtocol
    private let sessionManager: NetworkSessionManagerProtocol
    
    public init(config: NetworkConfigProtocol,
                sessionManager: NetworkSessionManagerProtocol = NetworkSessionManager()) {
        
        self.config = config
        self.sessionManager = sessionManager
    }
    
    private func request(request: URLRequest,
                         completion: @escaping CompletionHandler) -> NetworkCancellable {
        
        let dataTask = sessionManager.request(request: request) { [weak self] data, response, error in
            guard let self = self
                else { return }
            
            if let requestError = error {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }
                
                completion(.failure(error))
            } else {
                _ = response as? HTTPURLResponse
                completion(.success(data))
            }
        }
        return dataTask
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}

extension NetworkService: NetworkServiceProtocol {
    
    public func request(endpoint: Requestable,
                        completion: @escaping CompletionHandler) -> NetworkCancellable? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(.urlGeneration))
            return nil
        }
    }
}
