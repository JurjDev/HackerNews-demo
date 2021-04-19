//
//  NewsRepositoryProtocol.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public typealias GetNewsCompletionHandler = (Result<HackNews, DataTransferError>) -> Void

public protocol NewsRepositoryProtocol {
    
    func getNews(completion: @escaping GetNewsCompletionHandler) -> NetworkCancellable?
}
