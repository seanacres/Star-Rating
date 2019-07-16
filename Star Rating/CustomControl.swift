//
//  CustomControl.swift
//  Star Rating
//
//  Created by Sean Acres on 7/16/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import Foundation
import UIKit

class CustomControl: UIControl {
    
    var value: Int = 1
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    private let componentDimension: CGFloat = 40.0
    private let componentCount = 5
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.gray
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        var labelArray: [UILabel] = []
        var paddingToAdd: CGFloat = 8.0
        
        for x in stride(from: 1, to: componentCount + 1, by: 1) {
            
            let label = UILabel()
            
            label.tag = x
            label.text = "☆"
            label.font = UIFont.boldSystemFont(ofSize: 32.0)
            label.textAlignment = .center
            
            if x == 1 {
                label.frame = CGRect(x: paddingToAdd, y: 0, width: componentDimension, height: componentDimension)
                label.textColor = componentActiveColor
            } else {
                label.frame = CGRect(x: paddingToAdd, y: 0, width: componentDimension, height: componentDimension)
                label.textColor = componentInactiveColor
            }
            
            labelArray.append(label)
            self.addSubview(label)
            paddingToAdd += 8.0 + componentDimension
        }

        print(labelArray)
        
    }
}
