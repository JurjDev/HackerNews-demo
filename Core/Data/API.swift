//
//  API.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

struct API {}

extension API {
    
    struct News {
        
        static func getNews() -> Endpoint<HackNews> {
            return Endpoint()
        }
    }
}
