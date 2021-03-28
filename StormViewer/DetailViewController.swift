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

		title = selectedImage

		if let imageToLoad = selectedImage {
			imageView.image = UIImage(named: imageToLoad)
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnTap = true
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.hidesBarsOnTap = false
	}

}
