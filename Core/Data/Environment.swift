//
//  Environment.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public enum Environment: String {
    
    case dev
}

public extension Environment {
    
    var baseURL: URL {
        switch self {
        case .dev: return URL(string: "https://hn.algolia.com/api/v1/search_by_date?query=mobile")!
        }
    }
}
