//
//  ComicViewModel.swift
//  Marvel
//
//  Created by Juan Carrera on 1/18/16.
//  Copyright © 2016 Juan Felipe Carrera Moya. All rights reserved.
//

import Foundation


class ComicsViewModel {
    
    var comics: [Comic]?
    var selectedComic: Comic?
    
    func allComics(completion:(comics: [Comic]?, error: NSError?)->()){
        
        MarvelNetworkAccess().request(.GET, endpoint: "v1/public/comics")
            .responseArray { (values: [Comic]?, error: NSError?) in
                guard let _ = error else {
                    self.comics = values
                    completion(comics: values, error: nil)
                    return
                }
                
                completion(comics: nil, error: error)
        }
        
    }
    
}