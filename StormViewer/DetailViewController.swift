//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Paul Richardson on 29/03/2021.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet var imageView: UIImageView!
	var selectedImage: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()

		if let imageToLoad = selectedImage {
			imageView.image = UIImage(named: imageToLoad)
		}
	}

}
