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
    var labelArray: [UILabel] = []
    var isFlipped: Bool = true
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    private let componentDimension: CGFloat = 40.0
    private let componentCount = 6
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.gray
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        var paddingToAdd: CGFloat = 8.0
        var tagCount = componentCount
        
        for x in stride(from: 1, to: componentCount + 1, by: 1) {
            
            let label = UILabel()
            
            if isFlipped {
                label.tag = tagCount
            } else {
                label.tag = x
            }
            
            label.text = "☆"
            label.font = UIFont.boldSystemFont(ofSize: 32.0)
            label.textAlignment = .center
            label.frame = CGRect(x: paddingToAdd, y: 0, width: componentDimension, height: componentDimension)
            
            if label.tag == 1 {
                label.textColor = componentActiveColor
            } else {
                label.textColor = componentInactiveColor
            }
            
            labelArray.append(label)
            self.addSubview(label)

            paddingToAdd += 8.0 + componentDimension
            tagCount -= 1
        }
    }
    
    func updateValue(at touch: UITouch) {
        
        defer {
            sendActions(for: .valueChanged)
        }
        
        for label in labelArray {
            
            label.textColor = componentActiveColor
            
            if label.frame.contains(touch.location(in: self)) {
                value = label.tag
                label.performFlare()
            }
            
            if label.tag > value {
                label.textColor = componentInactiveColor
            }
        }
    }
}

extension CustomControl {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(at: touch)
        sendActions(for: [.touchDown])
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: [.touchDragInside])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else { return }
        
        if bounds.contains(touch.location(in: self)) {
            updateValue(at: touch)
            sendActions(for: [.touchUpInside])
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
    }
}

extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
