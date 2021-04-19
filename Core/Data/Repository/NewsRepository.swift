//
//  NewsRepository.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

final public class NewsRepository: NewsRepositoryProtocol {
    
    // MARK: - Properties
    
    private let transferServices: DataTransferServiceProtocol
    
    // MARK: - Init
    
    public init(transferServices: DataTransferServiceProtocol) {
        
        self.transferServices = transferServices
    }
    
    @discardableResult
    public func getNews(completion: @escaping GetNewsCompletionHandler) -> NetworkCancellable? {
        let endPoint = API.News.getNews()
        return transferServices.request(with: endPoint, completion: completion)
    }
}
