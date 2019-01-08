//
//  ViewController.swift
//  ObserveIt
//
//  Created by JULIAN LIMA on 27/12/18.
//  Copyright © 2018 Julian Lima. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ex = Example()
        
        let counterView = CounterView(example: ex)
        view.addSubview(counterView)
        counterView.center = view.center
      
        let listenerLabel = BaseLabel(frame: .zero)
        view.addSubview(listenerLabel)
        listenerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        listenerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        listenerLabel.bottomAnchor.constraint(equalTo: counterView.topAnchor, constant: 20).isActive = true
        
        ex.observe(with: self, key: ExampleEnum.property.rawValue, callback: { newValue in
            guard let value = newValue.value as? String else { return }
            
            listenerLabel.configure(withTitle: value, backgroundColor: UIColor.clear, textColor: UIColor.white)
            print(value)
        })
    }

}
