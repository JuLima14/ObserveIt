//
//  Observer.swift
//  ObserveIt
//
//  Created by Julian Lima on 4/8/18.
//  Copyright © 2018 Julian Lima. All rights reserved.
//

import UIKit

open class Observable: NSObject {
    
    var observersBinding: Binding = Binding()
    var ObservationContext: KVOContext = KVOContext()
    
    deinit {
        // Remove all observers to avoid crashes.
        for binding in observersBinding {
            removeObserver(self, forKeyPath: binding.0)
        }
    }
    open func observe(with object: NSObject, key: String, asyncCallback: Bool = true, callback: @escaping Callback) {

        if observersBinding[key] != nil {
            // Check if the binding already exists.
            var observerList = observersBinding[key]!
            for observer in observerList {
                if observer.observer == object {
                    return
                }
            }
            // Add binding to stack.
            let observer = Observer(observer: object, asyncCallback: asyncCallback, callback: callback)
            observerList.append(observer)
            observersBinding[key] = observerList
        }
        else {
            
            // First time, create a stack and add the binding.
            var observerList = [Observer]()
            let observer = Observer(observer: object, asyncCallback: asyncCallback, callback: callback)
            observerList.append(observer)
            observersBinding[key] = observerList
            addObserver(self, forKeyPath: key, options: NSKeyValueObservingOptions.new, context: &ObservationContext)
        }
        
    }
    open func ignore(with object: NSObject, key: String) {
        
        if observersBinding[key] != nil {

            // Find the binding.
            for (thisKey, var list) in observersBinding {
                var index = 0
                var found = false
                
                for binding in list {
                    if binding.observer == object {
                        found = true
                        break
                    }
                    index += 1
                }
                if found && key == thisKey {
                    list.remove(at: index)
                    observersBinding[key] = list
                    if list.count == 0 {
                        observersBinding[key] = nil
                        removeObserver(self, forKeyPath: key)
                    }
                }
            }
        }
    }
    
    //will execute the callback fot the keyPath and for the requested object
    open func publish(with keyPath: String, object: NSObject) {
        if let observerList = observersBinding[keyPath]{
            for observer in observerList{
                if observer.asyncCallback{
                    observer.callback(CallbackObject(value: object.value(forKeyPath: keyPath) as Any))
                }else{
                    if !observer.isExecuting{
                        observer.isExecuting = true
                        observer.callback(CallbackObject(value: object.value(forKeyPath: keyPath) as Any, unblock: {
                            observer.isExecuting = false
                        }))
                    }
                }
            }
        }
    }
    
    //will execute all callbacks for the requested object
    open func publish(to object: NSObject) {
        for keyPath in self.observersBinding.keys{
            if let observerList = self.observersBinding[keyPath]{
                for observer in observerList{
                    if observer.asyncCallback{
                        observer.callback(CallbackObject(value: object.value(forKeyPath: keyPath) as Any))
                    }else{
                        if !observer.isExecuting{
                            observer.isExecuting = true
                            observer.callback(CallbackObject(value: object.value(forKeyPath: keyPath) as Any, unblock: {
                                observer.isExecuting = false
                            }))
                        }
                    }
                }
            }
        }
    }
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let observerList = observersBinding[keyPath!], let nsobject = object as? NSObject {
            for observer in observerList {
                if observer.asyncCallback{
                    observer.callback(CallbackObject(value: nsobject.value(forKeyPath: keyPath!) as Any))
                }else{
                    //if observe value is called again when
                    if !observer.isExecuting{
                        observer.isExecuting = true
                        observer.callback(CallbackObject(value: nsobject.value(forKeyPath: keyPath!) as Any, unblock: {
                            observer.isExecuting = false
                        }))
                    }
                }
            }
        }
    }
}
