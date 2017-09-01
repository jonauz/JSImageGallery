//
//  GalleryViewModel.swift
//  ImageGallery
//
//  Created by Jonas Simkus on 15/08/2017.
//  Copyright © 2017 Jonas Simkus. All rights reserved.
//

import Foundation
//import RxSwift
//import RxCocoa

class GalleryViewModel: NSObject {
    
    var apiManager: FlickrAPICalls = FlickrAPIManager()
    //let disposeBag = DisposeBag()
    
    var photos: [GalleryPhoto] = []
    //var photos2: Observable<[GalleryPhoto]> = Observable.just([GalleryPhoto]())
    var photosUpdateHandler: VoidClosure?
    
    func fetchPhotos(for query: String? = nil) {
        apiManager.galleryPhotos(query: query) { (photos) in
            if let photos = photos {
                self.setupCollectionView(with: photos)
            }
        }
    }
    
    func setupCollectionView(with photos: [GalleryPhoto]) {
        // #1
        self.photos = photos.sorted(by: { $0.date > $1.date })
        photosUpdateHandler?()
        
        // #2
        //photos2 = Observable.just(photos)
    }

}
