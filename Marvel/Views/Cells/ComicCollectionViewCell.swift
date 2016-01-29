//
//  ComicCollectionViewCell.swift
//  Marvel
//
//  Created by Juan Carrera on 1/18/16.
//  Copyright © 2016 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


class ComicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    func setupCell(urlStringThumb: String?, title: String?) {
        if let urlStringThumb = urlStringThumb {
            thumbnail.sd_setImageWithURL( NSURL(string: urlStringThumb))
        }
        
        titleLbl.text = title
    }
    
    class func cellSize(containerWidth: CGFloat) -> CGSize {
        return CGSizeMake(containerWidth / 2, 250 )
    }
    
}
