//
//  ViewController.swift
//  Marvel
//
//  Created by Felipe Carrera on 27/07/15.
//  Copyright (c) 2015 Juan Felipe Carrera Moya. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let viewModel = ComicsViewModel()
    
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
            collectionCell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.yellowColor() : UIColor.greenColor()
            collectionCell.setupCell( viewModel.comics![indexPath.row])
            return collectionCell
        }else {
            return ComicCollectionViewCell()
        }
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    


}

