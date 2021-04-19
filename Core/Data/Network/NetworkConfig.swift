//
//  NetworkConfig.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public protocol NetworkConfigProtocol {
    
    var baseURL: URL { get }
}

public struct NetworkConfig: NetworkConfigProtocol {
    
    public let baseURL: URL
    
    public init(baseURL: URL) {
        
        self.baseURL = baseURL
    }
}
