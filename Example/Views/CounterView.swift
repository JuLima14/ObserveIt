//
//  CounterView.swift
//  Test-swift
//
//  Created by JULIAN LIMA on 10/10/18.
//  Copyright © 2018 JULIAN LIMA. All rights reserved.
//

import UIKit

class CounterView: UIView {

    private let proportionButton: CGFloat = 0.285714
    private let proportionLabel: CGFloat = 0.375
    
    private var centerLabel: BaseLabel!
    private var buttonLeft: CounterButton!
    private var buttonRight: CounterButton!
    
    private var example: Example!
    
    public init(frame: CGRect = CGRect.init(x: 0, y: 0, width: 175, height: 50), distanceBetweenViews: CGFloat = 5, initialNumber: Int = 0, radius: CGFloat = 15, backgroundColor: UIColor = .clear, textColor: UIColor = .white, example: Example) {
        super.init(frame: frame)
        self.example = example
        
        loadView(initialNumber: initialNumber, radius: radius, backgroundColor: backgroundColor, textColor: textColor)
        loadConstraints(distanceBetweenViews: distanceBetweenViews)
    }
    
    private func loadView(initialNumber: Int, radius: CGFloat, backgroundColor: UIColor, textColor: UIColor){
        layer.cornerRadius = radius
        
        centerLabel = BaseLabel(frame: CGRect.zero)
        centerLabel.configure(withTitle: String(initialNumber), backgroundColor: backgroundColor, textColor: textColor)
        centerLabel.drawBorderLine()
        
        buttonLeft = CounterButton(frame: CGRect.zero){ [weak self] in
            if let strongSelf = self{
                if let value = strongSelf.centerLabel.text as NSString?{
                    if value.intValue - 1 >= 0{
                        strongSelf.centerLabel.text = String(value.intValue - 1)
                        strongSelf.example.property = String(value.intValue - 1)
                    }
                }
            }
        }
        buttonLeft.configure(withTitle: "-", backgroundColor: backgroundColor, textColor: textColor)
        buttonLeft.drawBorderLine()
        
        buttonRight = CounterButton(frame: CGRect.zero){ [weak self] in
            if let strongSelf = self{
                if let value = strongSelf.centerLabel.text as NSString?{
                    strongSelf.centerLabel.text = String(value.intValue + 1)
                    strongSelf.example.property = String(value.intValue + 1)
                }
            }
        }
        buttonRight.configure(withTitle: "+", backgroundColor: backgroundColor, textColor: textColor)
        buttonRight.drawBorderLine()
        
        addSubview(centerLabel)
        addSubview(buttonLeft)
        addSubview(buttonRight)
    }
    
    private func loadConstraints(distanceBetweenViews: CGFloat){
        buttonLeft.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        buttonLeft.topAnchor.constraint(equalTo: topAnchor).isActive = true
        buttonLeft.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        centerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        centerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        buttonRight.topAnchor.constraint(equalTo: topAnchor).isActive = true
        buttonRight.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        buttonRight.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        buttonLeft.trailingAnchor.constraint(equalTo: centerLabel.leadingAnchor).isActive = true
        centerLabel.trailingAnchor.constraint(equalTo: buttonRight.leadingAnchor).isActive = true

        buttonLeft.widthAnchor.constraint(equalTo: centerLabel.widthAnchor).isActive = true
        centerLabel.widthAnchor.constraint(equalTo: buttonRight.widthAnchor).isActive = true
    }

    
    public func getTotal() -> Int?{
        if let total = self.centerLabel.text{
            return Int(total)
        }
        return nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
