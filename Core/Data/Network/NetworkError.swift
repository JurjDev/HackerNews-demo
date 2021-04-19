//
//  NetworkError.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public enum NetworkError: Error {
    
    case error(statusCode: Int, data: Data?)
    
    case notConnected
    
    case cancelled
    
    case generic(Error)
    
    case urlGeneration
}

// MARK: - Equatable

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case let (.error(lhsStatus, lhsData), .error(rhsStatus, rhsData)): return lhsStatus == rhsStatus && lhsData == rhsData
        case (.notConnected, .notConnected): return true
        case (.cancelled, .cancelled): return true
        case (.urlGeneration, .urlGeneration): return true
        case let (.generic(lhsError), .generic(rhsError)): return lhsError.code == rhsError.code
        default: return false
        }
    }
}
