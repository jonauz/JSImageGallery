//
//  GalleryViewController.swift
//  ImageGallery
//
//  Created by Jonas Simkus on 15/08/2017.
//  Copyright © 2017 Jonas Simkus. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    var viewModel = GalleryViewModel()
    var data = GalleryModel()
    
    fileprivate lazy var colleciontView: UICollectionView = {
        let frame = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width / 2 - 1, height: frame.width / 2 - 1)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let view = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.alwaysBounceVertical = true
        view.backgroundColor = .appDarkModerateCyan
        view.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.cellReuseIdentifier)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .appVeryDarkBlue
        view.backgroundColor = .appDarkModerateCyan
        view.addSubview(colleciontView)
        
        colleciontView.dataSource = self
        colleciontView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.cellReuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

}
