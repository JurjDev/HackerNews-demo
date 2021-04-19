//
//  DataTransferErrorResolverProtocol.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public protocol DataTransferErrorResolverProtocol {
    
    func resolve(error: NetworkError) -> Error
}

public class DataTransferErrorResolver: DataTransferErrorResolverProtocol {
    
    public init() {}
    
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}
