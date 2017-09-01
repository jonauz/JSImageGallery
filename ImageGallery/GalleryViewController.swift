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

class GalleryViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel = GalleryViewModel()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let frame = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width / 2 - 0.5, height: frame.width / 2 + 60 - 0.5)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let view = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        view.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        view.alwaysBounceVertical = true
        view.backgroundColor = .defaultDarkModerateCyan
        view.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.cellReuseIdentifier)
        return view
    }()
    
    fileprivate lazy var searchTextField: UITextField = {
        let view = UITextField(frame: CGRect(x: 64, y: 6, width: self.view.frame.width - 128, height: 32))
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.white
        view.textColor = UIColor.defaultVeryDarkBlue
        view.font = UIFont.systemFont(ofSize: 15)
        view.returnKeyType = .search
        view.placeholder = "Tags"
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 32))
        view.leftView = leftView
        view.leftViewMode = .always
        view.delegate = self
        return view
    }()
    
    fileprivate lazy var confirmButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
        button.setTitle("Search", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.setTitleColor(UIColor.defaultVerySoftLimeGreen, for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: UIControlEvents.touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .defaultVeryDarkBlue
        navigationItem.titleView = searchTextField
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: confirmButton)
//        title = "Flickr Public Gallery"
        view.backgroundColor = .defaultDarkModerateCyan
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupCellConfiguration()
        viewModel.fetchPhotos()
    }
    
    func confirmButtonTapped() {
        searchTextField.resignFirstResponder()
        if let search = searchTextField.text, search.characters.count > 0 {
            viewModel.fetchPhotos(for: search)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        confirmButtonTapped()
        return true
    }
    
    private func setupCellConfiguration() {
        viewModel.photosUpdateHandler = { [weak self] in
            guard let sSelf = self else { return }
            sSelf.collectionView.reloadData()
        }
        //let cellIdentifier = GalleryCollectionViewCell.cellReuseIdentifier
        //let cellType = GalleryCollectionViewCell.self
        //viewModel.photos2
        //    .bind(to: colleciontView.rx.items(cellIdentifier: cellIdentifier, cellType: cellType)) { (item, photo, cell) in
        //        cell.setup(photo: photo)
        //    }
        //    .disposed(by: viewModel.disposeBag)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchTextField.resignFirstResponder()
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
