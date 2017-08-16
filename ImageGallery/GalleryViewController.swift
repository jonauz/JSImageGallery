//
//  GalleryViewController.swift
//  ImageGallery
//
//  Created by Jonas Simkus on 15/08/2017.
//  Copyright © 2017 Jonas Simkus. All rights reserved.
//

import UIKit
//import RxSwift
//import RxCocoa

class GalleryViewController: UIViewController {
    
    var viewModel = GalleryViewModel()
    
    fileprivate lazy var colleciontView: UICollectionView = {
        let frame = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width / 2 - 0.5, height: frame.width / 2 - 0.5)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let view = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        view.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
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
        
        setupCellConfiguration()
        viewModel.fetchPhotos()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupCellConfiguration() {
        viewModel.photosUpdateHandler = { [weak self] in
            guard let sSelf = self else { return }
            sSelf.colleciontView.reloadData()
        }
        //let cellIdentifier = GalleryCollectionViewCell.cellReuseIdentifier
        //let cellType = GalleryCollectionViewCell.self
        //viewModel.photos2
        //    .bind(to: colleciontView.rx.items(cellIdentifier: cellIdentifier, cellType: cellType)) { (item, photo, cell) in
        //        cell.setup(photo: photo)
        //    }
        //    .disposed(by: viewModel.disposeBag)
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
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.cellReuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        cell.setup(photo: viewModel.photos[indexPath.item])
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

}
