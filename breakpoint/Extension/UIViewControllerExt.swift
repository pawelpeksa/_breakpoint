//
//  UIViewControllerExt.swift
//  breakpoint
//
//  Created by Mac on 11/10/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController{
    
    func presentDetail(_ ViewControlerToPresent:UIViewController){
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(ViewControlerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail(){
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
        
    }
    
}
