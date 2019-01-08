//
//  CounterButton.swift
//  Test-swift
//
//  Created by JULIAN LIMA on 11/10/18.
//  Copyright © 2018 JULIAN LIMA. All rights reserved.
//

import UIKit

class CounterButton: BaseButton{
    
    public init(frame: CGRect,radius: CGFloat = 15, action: @escaping(() -> ())) {
        super.init(frame: frame)
        self.layer.cornerRadius = radius
        super.action = action
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(super.executeAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
