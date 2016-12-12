//
//  GifSearchPresenter.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 01/12/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import Foundation
import UIKit

class GifSearchPresenter: GifPresenter
{
    var view : GifView?
    var service : GifService
    
    var gifs : [Gif] = []
    
    required init(service: GifService) {

        self.service = service
    }
    
    func searchGifs(query: String) {
        
        guard (view != nil) else {
            
            //View should be injected by now
            return
        }
        
        view!.startLoading()
        
        if (query.isEmpty) {
            
            service.retrieveTrendingGifs(success: { (gifs) in
                
                self.gifs = gifs
                self.view!.finishLoading()
                
                if (self.gifs.count == 0) {
                    
                    self.view!.setSearchEmpty(message: "No trending gifs were found.")
                }
                else {
                 
                    self.view!.setSearchResult(gifs: self.gifDisplays(from: gifs))
                }
                
            }, failure: { (error) in
                
                self.view!.finishLoading()
                self.view!.setSearchError(error: error.localizedDescription)
                
            })
        }
        else {
            self.service.retrieveGifs(filter: query, success: { gifs in
                
                self.gifs = gifs
                self.view!.finishLoading()
                
                if (self.gifs.count == 0) {
                    
                    self.view!.setSearchEmpty(message: "No results were found.")
                }
                else {
                
                    self.view!.setSearchResult(gifs: self.gifDisplays(from: gifs))
                }
                
            }, failure: { error in
                
                self.view!.finishLoading()
                self.view!.setSearchError(error: error.localizedDescription)
            })
        }
    }
    
    private func gifDisplays(from: [Gif]) -> [GifDisplay] {
        
        var gifDisplays : [GifDisplay] = []
        for gif in from {
            
            if let url = URL(string: gif.downSampledGifUrl) {
                
                if let dateString = Utils.string(from: gif.importDate!) {
                    gifDisplays.append(GifDisplay(imageUrl: url, date: dateString, source: gif.source))
                }
                else
                {
                    gifDisplays.append(GifDisplay(imageUrl: url, date: "", source: gif.source))
                }
            }
            else
            {
                gifDisplays.append(GifDisplay(imageUrl: URL(string: "")!, date: "", source: ""))
            }
        }
        
        return gifDisplays
    }
}
