//
//  Requestable.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public protocol Requestable {
    
    func urlRequest(with networkConfig: NetworkConfigProtocol) throws -> URLRequest
}

extension Requestable {
    
    public func urlRequest(with config: NetworkConfigProtocol) throws -> URLRequest {
        
        return URLRequest(url: config.baseURL)
    }
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response
    
    var responseDecoder: ResponseDecoder { get }
}
