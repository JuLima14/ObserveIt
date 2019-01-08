//
//  Views.swift
//  Test-swift
//
//  Created by JULIAN LIMA on 10/10/18.
//  Copyright © 2018 JULIAN LIMA. All rights reserved.
//

import UIKit

class BaseButton: UIView {
    var backgroundView: UIView = UIView()
    var title: UILabel = UILabel()
    var action: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }
    
    func configure(withTitle titleText: String, backgroundColor: UIColor, textColor: UIColor) {
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = backgroundColor
        
        let marginsView = layoutMarginsGuide
        
        backgroundView.leadingAnchor.constraint(equalTo: marginsView.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: marginsView.trailingAnchor).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: marginsView.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: marginsView.centerYAnchor).isActive = true
        
        backgroundView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = textColor
        title.text = titleText
        title.textAlignment = .center
        title.numberOfLines = 0
        
        drawShadow(offset: CGSize.init(width: 3, height: 3))
        
        let marginsBackgroundView = (title.superview?.layoutMarginsGuide)!
        title.leadingAnchor.constraint(equalTo: marginsBackgroundView.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: marginsBackgroundView.trailingAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: marginsBackgroundView.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: marginsBackgroundView.centerYAnchor).isActive = true
    }
    
    func drawShadow(shadowColor: UIColor = UIColor.black, opacity: Float =
        0.3, offset: CGSize, radius: CGFloat = 5, shouldRasterize : Bool = false) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shouldRasterize = shouldRasterize
    }
    func drawBorderLine(){
        layer.borderColor = title.textColor.cgColor
        layer.borderWidth = 2
    }
    @objc func executeAction() {
        action?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




