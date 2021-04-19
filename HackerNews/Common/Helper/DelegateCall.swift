//
//  DelegateCall.swift
//  HackerNews
//
//  Created by JurjDev on 17/04/21.
//

import Foundation

public typealias Callback = (() -> Void)

// MARK: - Delegate Call

public struct DelegateCall<Input> {
    
    public private(set) var callback: ((Input) -> Void)?
    
    public mutating func delegate<Delegate: AnyObject>(to delegate: Delegate, with callback: @escaping (Delegate, Input) -> Void) {
        self.callback = { [weak delegate] input in
            guard let delegate = delegate
                else { return }
            callback(delegate, input)
        }
    }
    
    public init() {}
}

// MARK: - Delegate Return Call

public struct DelegateReturnCall<Input, Output> {
    
    private(set) var callback: ((Input) -> Output?)?
    
    public mutating func delegate<Delegate: AnyObject>(to delegate: Delegate, with callback: @escaping (Delegate, Input) -> Output?) {
        self.callback = { [weak delegate] input in
            guard let delegate = delegate
                else { return nil }
            return callback(delegate, input)
        }
    }
}
