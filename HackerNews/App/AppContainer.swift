//
//  AppContainer.swift
//  HackerNews
//
//  Created by JurjDev on 17/04/21.
//

import Foundation
import UIKit
import Core

final class AppContainer {
    
    static let shared = AppContainer()
    
    var dataTransferService: DataTransferService {
        let config = NetworkConfig(baseURL: Environment.dev.baseURL)
        let apiDataNetwork = NetworkService(config: config)
        return DataTransferService(networkService: apiDataNetwork)
    }
}
