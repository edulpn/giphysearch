//
//  SwinjectStoryboard+Setup.swift
//  giphysearch
//
//  Created by Eduardo Pinto on 06/12/16.
//  Copyright © 2016 Eduardo Pinto. All rights reserved.
//

import Foundation
import SwinjectStoryboard
import Swinject

extension SwinjectStoryboard {
    
    class func setup() {
        
        defaultContainer.register(GifService.self, factory: {(resolver) -> GifSearchService in
            
            return GifSearchService()
        })
        
        defaultContainer.register(GifPresenter.self, factory: {(resolver) -> GifSearchPresenter in
            
            return GifSearchPresenter(service: resolver.resolve(GifService.self)!)
        })
        
        defaultContainer.registerForStoryboard(GifSearchViewController.self, initCompleted: { resolver, controller in
            
            var presenter = resolver.resolve(GifPresenter.self)!
            presenter.view = controller
            controller.gifPresenter = presenter
        })
    }
}
