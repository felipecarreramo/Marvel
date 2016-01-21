//
//  ComicDetailViewController.swift
//  Marvel
//
//  Created by Felipe Carrera on 20/01/16.
//  Copyright © 2016 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation
import UIKit

class ComicDetailViewController: UIViewController {
    
    let viewModel = ComicDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(viewModel.comic?.title)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}