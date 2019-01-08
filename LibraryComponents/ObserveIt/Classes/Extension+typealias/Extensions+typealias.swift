//
//  Extensions+typealias.swift
//  ObserveIt
//
//  Created by Julian Lima on 4/8/18.
//  Copyright © 2018 Julian Lima. All rights reserved.
//

import UIKit

public typealias KVOContext = UInt8
public typealias Binding = [String : [Observer]]
public typealias Next = () -> ()
public typealias Callback = (CallbackObject) -> ()

open class CallbackObject{
    open var value: Any
    open var unblock: Next
    
    public init(value: Any, unblock:@escaping Next = {}) {
        self.value = value
        self.unblock = unblock
    }
}

extension NSObject {
    open func exist(key: String) -> Bool{
        return keys().contains(key)
    }
    open func keys() -> [String] {
        var array = [String]()
        var count: CUnsignedInt = 0
        let properties: UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(object_getClass(self), &count)!
        
        for i in 0 ..< Int(count) {
            if let key = NSString(cString: property_getName(properties[i]), encoding: String.Encoding.utf8.rawValue) as String? {
                array.append(key)
            }
        }
        return array
    }
}
