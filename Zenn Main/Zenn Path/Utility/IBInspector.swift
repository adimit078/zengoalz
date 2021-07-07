//
//  inspectableView.swift
//  BlackWeather
//
//  Created by Cubezy Tech on 15/03/21.
//

import Foundation
import UIKit
extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    //Set title font and title color
    func setTitlet(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                          range: NSMakeRange(0, title.utf8.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                          range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
    
    //Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    
    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
}

@IBDesignable class IBLabel: UILabel {
    
    @IBInspectable var borderWidth: Double {
        get
        {
            return Double(layer.borderWidth)
        }
        set
        {
            layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(layer.cornerRadius)
        }
        set
        {
            layer.cornerRadius = CGFloat(newValue)
        }
    }
    @IBInspectable var bordercolor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = bordercolor.cgColor
        }
    }
}

@IBDesignable class IBButton: UIButton {
    @IBInspectable var borderWidth: Double {
        get
        {
            return Double(layer.borderWidth)
        }
        set
        {
            layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(layer.cornerRadius)
        }
        set
        {
            layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var bordercolor: UIColor = UIColor.black {
        
        didSet {
            layer.borderColor = bordercolor.cgColor
        }
    }
}

@IBDesignable class IBImage: UIImageView {
    @IBInspectable var borderWidth: Double {
        get
        {
            return Double(layer.borderWidth)
        }
        set
        {
            layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(layer.cornerRadius)
        }
        set
        {
            layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var bordercolor: UIColor = UIColor.black {
        
        didSet {
            layer.borderColor = bordercolor.cgColor
        }
    }
}

@IBDesignable class IBView: UIView {
    @IBInspectable var borderWidth: Double {
        get
        {
            return Double(layer.borderWidth)
        }
        set
        {
            layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(layer.cornerRadius)
            
        }
        set
        {
            layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var bordercolor: UIColor = UIColor.black {
        
        didSet {
            layer.borderColor = bordercolor.cgColor
        }
    }
}

@IBDesignable class  IBTableView: UITableView {
    @IBInspectable var borderWidth: Double {
        get
        {
            return Double(layer.borderWidth)
        }
        set
        {
            layer.borderWidth = CGFloat(newValue)
        }
        
    }
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(layer.cornerRadius)
            
        }
        set
        {
            layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var bordercolor: UIColor = UIColor.black {
        
        didSet {
            layer.borderColor = bordercolor.cgColor
        }
    }
}


