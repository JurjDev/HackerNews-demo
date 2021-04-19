//
//  State.swift
//  HackerNews
//
//  Created by JurjDev on 17/04/21.
//

import Foundation

enum NewsState {
    
    case idle
    
    case loading
    
    case success
    
    case error
}

extension NewsState: Equatable {
    
    public static func ==(lhs: NewsState, rhs: NewsState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.success, .success): return true
        case (.error, .error): return true
        default: return false
        }
    }
}
