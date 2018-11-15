//
//  MeVC_handlersExt.swift
//  breakpoint
//
//  Created by Mac on 11/10/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import UIKit

extension MeVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @objc func handlerSelectProfileImgView(){
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImgFromPicket: UIImage?
        
        
        if let editedImg = info["UIImagePickerControllerEditedImage"] as? UIImage{
            
            selectedImgFromPicket = editedImg
            
        } else if let originalImg = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImgFromPicket = originalImg
            
        }
        if let selectedImg = selectedImgFromPicket{
            profileImg.image = selectedImg
        }
        
        ImageService.instance.uploadData(image: profileImg.image!) { (imageUrl) in
            print(imageUrl)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("was canceled")
        dismiss(animated: true, completion: nil)
    }
    
}
