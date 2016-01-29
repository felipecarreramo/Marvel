//
//  ComicViewModel.swift
//  Marvel
//
//  Created by Juan Carrera on 1/18/16.
//  Copyright © 2016 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import UIKit


class ComicsViewModel {
    
    var comics: [Comic]?
    var selectedComic: Comic?
    
    private let kCellIdentifier = "ComicInCollection"
    
    func numberOfItemsInCollection() -> Int {
        var numberOfItems = 0
        if let comics = comics {
            numberOfItems = comics.count
        }
        return numberOfItems
    }
    
    func setupCollectionViewCell(indexPath: NSIndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as? ComicCollectionViewCell {
            
            let comic = comics?[indexPath.row]
            cell.setupCell("\(comic?.thumbnail ?? "").\(comic?.thumbnailExtension ?? "")", title: comic?.title)
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func selectComicAtIndex(indexPath: NSIndexPath) {
        selectedComic = comics?[indexPath.row]
    }
    
    func retrieveComics(completion:(comics: [Comic]?, error: NSError?)->()){
        Comic.retrieveComics { comics, error in
            self.comics = comics
            completion(comics: comics, error: error)
        }
    }
    
}