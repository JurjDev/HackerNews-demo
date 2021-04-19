//
//  Error.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public extension Error {
    
    var code: ErrorCode {
        let nativeCode = (self as NSError).code
        return ErrorCode(rawValue: nativeCode)
    }
}

// MARK: - ErrorCode

public struct ErrorCode: RawRepresentable {
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public init?(_ unsafe: Int) {
        self.rawValue = unsafe
    }
}

// MARK: Equatable

extension ErrorCode: Equatable {
    
    public static func == (lhs: ErrorCode?, rhs: ErrorCode) -> Bool {
        guard let code = lhs?.rawValue
            else { return false}
        return code == rhs.rawValue
    }
}

// MARK: Definitions

extension ErrorCode {
    
    public static let cancelled = ErrorCode(-999)
}
