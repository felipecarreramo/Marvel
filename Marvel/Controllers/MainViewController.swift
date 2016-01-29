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
        viewModel.retrieveComics { comics, error in
            guard let _ = error else {
                self.comicsCollection.reloadData()
                return
            }
            
            print(error)
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInCollection()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        return viewModel.setupCollectionViewCell(indexPath, collectionView: collectionView)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        viewModel.selectComicAtIndex(indexPath)
        performSegueWithIdentifier(segueComicDetail, sender: nil)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return ComicCollectionViewCell.cellSize(collectionView.frame.width)
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

