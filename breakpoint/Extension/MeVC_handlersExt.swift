//
//  MeVC_handlersExt.swift
//  breakpoint
//
//  Created by Mac on 11/10/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import UIKit

extension MeVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    
    @objc func handlerSelectProfileImgView(){
        let picker = getPicker()
        self.presentPicker(picker: picker)
    }
    
    func getPicker()->UIImagePickerController{
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }
    
    func presentPicker(picker:UIImagePickerController){
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedImgFromPicker = self.getSelectedImg(info: info)
        
        if let selectedImg = selectedImgFromPicker {
            profileImg.image = selectedImg
        }
        
        imageService.uploadData(image: profileImg.image!) { (imageUrl) in
            print(imageUrl)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("was canceled")
        dismiss(animated: true, completion: nil)
    }
    
    func getSelectedImg(info:[String:Any])->UIImage? {
        var selectedImgFromPicker: UIImage?
        
        if let editedImg = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImgFromPicker = editedImg
        } else if let originalImg = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImgFromPicker = originalImg
        }
        return selectedImgFromPicker
    }
    
}
