//
//  UIViewEX.swift
//  breakpoint
//
//  Created by Mac on 11/1/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit


extension UIView {
    func bindToKeyBoard(){
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChangeFrame (_ notification:NSNotification){
        
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        
        let beginningFrame = (notification.userInfo! [UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo! [UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let delayY = endFrame.origin.y - beginningFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue:curve), animations: {
            self.frame.origin.y += delayY
        }, completion: nil)
        
        
        
    }
}
