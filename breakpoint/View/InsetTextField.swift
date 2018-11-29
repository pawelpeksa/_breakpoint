//
//  insetTextField.swift
//  breakpoint
//
//  Created by Mac on 10/31/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class insetTextField: UITextField {
    
    private var textRectOffSet:CGFloat = 20
    private var  padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    override func awakeFromNib() {
        setUpView()
        super.awakeFromNib()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)

    }
    
    func setUpView() {
         self.attributedPlaceholder = self.getPlaceholder()
    }
    
    func getPlaceholder() -> NSAttributedString{
        return NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
    }
    
}
