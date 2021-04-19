//
//  DataTransferError.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation


public enum DataTransferError: Error {
    
    case noResponse
    
    case parsing(Error)
    
    case networkFailure(NetworkError)
    
    case resolvedNetworkFailure(Error)
}

extension DataTransferError: Equatable {
    public static func == (lhs: DataTransferError, rhs: DataTransferError) -> Bool {
        switch (lhs, rhs) {
        case (.noResponse, .noResponse): return true
        case (.parsing, .parsing ): return true
        case let (.networkFailure(lhsError), .networkFailure(rhsError)): return lhsError == rhsError
        case let (.resolvedNetworkFailure(lhsError), .resolvedNetworkFailure(rhsError)): return lhsError.code == rhsError.code
        default: return false
        }
    }
}
