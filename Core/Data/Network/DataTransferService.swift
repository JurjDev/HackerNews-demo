//
//  DataTransferService.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public protocol DataTransferServiceProtocol {
    
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void
    
    func request<T: Decodable,
                 E: ResponseRequestable>(with endpoint: E,
                                         completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where E.Response == T
}

public final class DataTransferService {
    
    private let networkService: NetworkServiceProtocol
    private let errorResolver: DataTransferErrorResolverProtocol
    
    public init(networkService: NetworkServiceProtocol,
                errorResolver: DataTransferErrorResolverProtocol = DataTransferErrorResolver()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
    }
}

extension DataTransferService: DataTransferServiceProtocol {
    
    public func request<T, E>(with endpoint: E, completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where T : Decodable, T == E.Response, E : ResponseRequestable {
        
        return self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case let .success(response):
                let result: Result<T, DataTransferError> = self.decode(data: response, decoder: endpoint.responseDecoder)
                DispatchQueue.main.async {
                    return completion(result)
                }
            case let .failure(error):
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async {
                    return completion(.failure(error))
                }
            }
        }
    }
    
    private func decode<T: Decodable>(data: Data?,
                                      decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        
        do {
            guard let data = data
                else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }
    
    private func resolve(networkError error: NetworkError) -> DataTransferError {
        
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}
