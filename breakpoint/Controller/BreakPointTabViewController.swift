//
//  BreakPointTabViewController.swift
//  breakpoint
//
//  Created by Paweł on 29/11/2018.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class BreakPointTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageService = ImageService()
        setImageServiceForControllers(imageService)
    }
    
    func createImageService() -> ImageService {
        return ImageService()
    }
    
    func setImageServiceForControllers(_ imageService:ImageService) {
        
        if let viewControllers = self.viewControllers {
            
            for controller in viewControllers {
                
                if let meVC = controller as? MeVC {
                    meVC.imageService = imageService
                }
                
                if let feedVC = controller as? FeedVC {
                    feedVC.imageService = imageService
                }
            }

        }
        
    }
}
