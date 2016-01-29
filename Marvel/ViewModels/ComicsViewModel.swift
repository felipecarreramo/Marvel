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
    
    var selectedComic: Comic?
    
    private var comics: [Comic] = []
    private var indexPagination = 1
    private var limit = 20
    private var retrieving = false
    
    private let kCellIdentifier = "ComicInCollection"
    
    func numberOfItemsInCollection() -> Int {
        return comics.count
    }
    
    func setupCollectionViewCell(indexPath: NSIndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as? ComicCollectionViewCell {
            
            let comic = comics[indexPath.row]
            cell.setupCell("\(comic.thumbnail ?? "").\(comic.thumbnailExtension ?? "")", title: comic.title)
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func selectComicAtIndex(indexPath: NSIndexPath) {
        selectedComic = comics[indexPath.row]
    }
    
    func retrieveComics(params: [String: AnyObject]? = nil, completion:(comics: [Comic]?, error: NSError?)->()){
        retrieving = true
        Comic.retrieveComics(params){ comics, error in
            self.retrieving = false
            if let comics = comics {
                self.comics.appendContentsOf(comics)
            }
            completion(comics: comics, error: error)
        }
    }
    
    func retrieveMoreComicsOnScroll(scrollView: UIScrollView, completion: (success: Bool, error: NSError?) -> ()) {
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.height
        
        if bottomEdge >= scrollView.contentSize.height && !retrieving {
            
            retrieveComics(["offset": (indexPagination * limit) + 1, "limit": limit ]) { comics, error in
                guard let error = error else {
                    self.indexPagination++
                    completion(success: true, error: nil)
                    return
                }
                completion(success: false, error: error)
            }
        }

    }
    
}