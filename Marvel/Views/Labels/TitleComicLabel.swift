//
//  TitleComicLabel.swift
//  Marvel
//
//  Created by Juan Carrera on 2/1/16.
//  Copyright © 2016 Juan Felipe Carrera Moya. All rights reserved.
//

import UIKit

class TitleComicLabel: UILabel {


    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(0, 5)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1
        layer.masksToBounds = false
        
        
    }


}
