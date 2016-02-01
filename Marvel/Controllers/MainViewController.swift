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
    var loaderScroll: LoaderScroll?
    
    
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return ComicCollectionViewCell.cellSize(collectionView.frame.width)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueComicDetail {
            if let selectedComic = viewModel.selectedComic(comicsCollection), let destinationViewController = segue.destinationViewController as? ComicDetailViewController {
                destinationViewController.viewModel.comic = selectedComic
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        loaderScroll?.show()
        viewModel.retrieveMoreComicsOnScroll(scrollView) { success, error in
            self.loaderScroll?.hide()
            if success {
                self.comicsCollection.reloadData()
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: viewModel.kFooterIdentifier, forIndexPath: indexPath)
        
        
        loaderScroll = LoaderScroll(inView: view)
        if let loaderScroll = loaderScroll {
            view.addSubview(loaderScroll)
        }
        
        return view
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    


}

