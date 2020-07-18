//
//  RoundButton.swift
//  Flash Chat
//
//  Created by Udin Rajkarnikar on 6/13/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//
import Foundation
import UIKit

extension UIButton {
  
    func applyDesign(){
        
        layer.cornerRadius = frame.height/2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
       }
    
    func pulse(){
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
    
    func bouncButton() {
        
        let bounds = layer.bounds
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.layer.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
        }) { (sucess: Bool) in
            if sucess {
                self.layer.bounds = bounds
            }
        }
        
        
        
        
    }
}

extension UITextField {
    
    
    func textFieldBorderRadius(){
        
        layer.cornerRadius = 15.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
