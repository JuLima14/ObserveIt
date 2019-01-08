//
//  BaseLabel.swift
//  Test-swift
//
//  Created by JULIAN LIMA on 11/10/18.
//  Copyright © 2018 JULIAN LIMA. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
    }
    
    func configure(withTitle titleText: String, backgroundColor: UIColor, textColor: UIColor, radius: CGFloat = 15) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        layer.cornerRadius = radius
        translatesAutoresizingMaskIntoConstraints = false
        text = titleText
        textAlignment = .center
        numberOfLines = 0
    }
    
    func drawBorderLine(){
        layer.borderColor = textColor.cgColor
        layer.borderWidth = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
