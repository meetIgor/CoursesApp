//
//  Box.swift
//  CoursesApp
//
//  Created by igor s on 01.11.2022.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    
    var value : T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}
