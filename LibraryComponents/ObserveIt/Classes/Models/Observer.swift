//
//  Observer.swift
//  ObserveIt
//
//  Created by Julian Lima on 4/8/18.
//  Copyright © 2018 Julian Lima. All rights reserved.
//

open class Observer: NSObject {
    
    var observer: NSObject!
    var callback: Callback!
    var asyncCallback: Bool!
    var isExecuting: Bool!
    
    init(observer: NSObject, callback: @escaping Callback) {
        self.observer = observer
        self.callback = callback
        self.asyncCallback = true
        self.isExecuting = false
    }
    init( observer: NSObject, asyncCallback: Bool, callback: @escaping Callback) {
        self.observer = observer
        self.callback = callback
        self.asyncCallback = asyncCallback
        self.isExecuting = false
    }
}
