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
        let transition = self.getRightTransition()
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(ViewControlerToPresent, animated: false, completion: nil)
    }
    
    func getRightTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        return transition
    }
    
    func getLeftTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        return transition
    }
    
    func dismissDetail(){
        let transition = self.getLeftTransition()
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
}
