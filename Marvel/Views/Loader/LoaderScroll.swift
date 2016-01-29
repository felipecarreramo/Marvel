//
//  LoaderScroll.swift
//  Marvel
//
//  Created by Juan Carrera on 1/29/16.
//  Copyright © 2016 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import UIKit
import FLAnimatedImage

class LoaderScroll: UICollectionReusableView {
    
    private let nibName = "LoaderScroll"
    
    @IBOutlet weak var loaderImage: FLAnimatedImageView!
    
    init(inView: UIView) {
        super.init(frame: CGRectMake(0, 0,  inView.bounds.width,  inView.bounds.height))
        loadFromNib()

        if let pathGifFile = NSBundle.mainBundle().pathForResource("loaderScroll", ofType: "gif") {
            loaderImage.animatedImage = FLAnimatedImage(animatedGIFData: NSFileManager.defaultManager().contentsAtPath(pathGifFile))
        }
//        loaderImage.center = CGPointMake((inView.bounds.width / 2) - 10, (inView.bounds.height / 2) - 10)
        loaderImage.hidden = true
        hidden = true
        inView.addSubview(self)
        
    }
    
    
    func show() {
        self.hidden = false
        loaderImage.hidden = false
        self.layoutIfNeeded()
    }
    
    func hide(){
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func loadFromNib(){
        
//        if let view = NSBundle.mainBundle().loadNibNamed(nibName, owner: self, options: [:]).first as? UIView {
//            addSubview(view)
//        }
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        if let view = nib.instantiateWithOwner(self, options: nil).first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            self.addSubview(view)
        }
        
        
    }
}