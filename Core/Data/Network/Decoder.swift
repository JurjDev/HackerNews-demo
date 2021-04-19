//
//  Decoder.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public protocol ResponseDecoder {
    
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public class JSONResponseDecoder: ResponseDecoder {
    
    private let jsonDecoder = JSONDecoder()
    
    public init() {}
    
    public func decode<T>(_ data: Data) throws -> T where T : Decodable {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
