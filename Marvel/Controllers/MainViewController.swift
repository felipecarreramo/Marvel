//
//  ViewController.swift
//  Marvel
//
//  Created by Felipe Carrera on 27/07/15.
//  Copyright (c) 2015 Juan Felipe Carrera Moya. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let viewModel = ComicsViewModel()
    
    private let segueComicDetail = "showComicDetail"
    
    @IBOutlet weak var comicsCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.allComics { comics, error in
            guard let _ = error else {
                self.comicsCollection.reloadData()
                return
            }
            
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.comics == nil ? 0: viewModel.comics!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let collectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("ComicInCollection", forIndexPath: indexPath) as? ComicCollectionViewCell {
            collectionCell.setupCell( viewModel.comics![indexPath.row])
            return collectionCell
        }else {
            return ComicCollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        viewModel.selectedComic = viewModel.comics?[indexPath.row]
        performSegueWithIdentifier(segueComicDetail, sender: nil)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width / 2, 250 )
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueComicDetail {
            if let destinationViewController = segue.destinationViewController as? ComicDetailViewController, let selectedComic = viewModel.selectedComic {
                destinationViewController.viewModel.comic = selectedComic
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    


}

