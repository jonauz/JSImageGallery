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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appDarkModerateCyan
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
