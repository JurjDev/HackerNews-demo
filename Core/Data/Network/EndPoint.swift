//
//  EndPoint.swift
//  Core
//
//  Created by JurjDev on 18/04/21.
//

import Foundation

public class Endpoint<Response>: ResponseRequestable {
    
    public var responseDecoder: ResponseDecoder
    
    init(responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        
        self.responseDecoder = responseDecoder
    }
}
