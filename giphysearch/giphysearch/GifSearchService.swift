//
//  GifSearchService.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 01/12/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GifSearchService: GifService {
    
    func retrieveGifs(filter: String, success: @escaping ([Gif]) -> Void, failure: @escaping (Error) -> Void) {
        
        Alamofire.request("https://api.giphy.com/v1/gifs/search", method: .get, parameters: ["q" : filter, "api_key" : "dc6zaTOxFJmzC"], encoding: URLEncoding(destination: .queryString)).responseJSON { (response) in
            
            switch response.result {
                case .success(let value):
                    
                    let gifsJson = JSON(value)
                    success(self.gifs(from: gifsJson))
                    break
                    
                case .failure(let error):
                    
                    failure(error)
                    break
            }
        }
    }
    
    func retrieveTrendingGifs(success: @escaping ([Gif]) -> Void, failure: @escaping (Error) -> Void) {
        
        Alamofire.request("https://api.giphy.com/v1/gifs/trending", method: .get, parameters: ["api_key" : "dc6zaTOxFJmzC"], encoding: URLEncoding(destination: .queryString)).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                let gifsJson = JSON(value)
                success(self.gifs(from: gifsJson))
                break
                
            case .failure(let error):
                
                failure(error)
                break
            }
        }
    }
    
    private func gifs(from: JSON) -> [Gif] {
    
        var gifs : [Gif] = []
        for (_,gifJson):(String, JSON) in from["data"] {
            
            gifs.append(Gif(json: gifJson))
        }
        
        return gifs
    }
}
