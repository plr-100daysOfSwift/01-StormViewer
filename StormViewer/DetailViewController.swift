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
	var numbers: (row: Int, total: Int)?
	
	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Picture \((numbers?.row ?? 0) + 1) of \(numbers?.total ?? 0)"
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
																												target: self,
																												action: #selector(shareTapped))
		navigationItem.largeTitleDisplayMode = .never

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

	@objc func shareTapped() {
		guard let image = imageView.image else { return }

		let renderer = UIGraphicsImageRenderer(size: image.size)
		let renderedImage = renderer.jpegData(withCompressionQuality: 0.8) { ctx in
				let context = ctx.cgContext
				let rectangle = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
				image.draw(in: rectangle)

				context.setTextDrawingMode(.fillStroke)
				let textBox = CGRect(origin: CGPoint(x: 50, y: rectangle.size.height - 100), size: CGSize(width: 600, height: 100))
				let attributes: [NSAttributedString.Key: Any] = [
					.foregroundColor: UIColor.red,
					.font: UIFont.boldSystemFont(ofSize: 48)
				]
				let string = NSAttributedString(string: "From Storm Viewer", attributes: attributes)

				string.draw(in: textBox)

			}

		let vc = UIActivityViewController(activityItems: [renderedImage, selectedImage as Any], applicationActivities: [])
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(vc, animated: true)
	}
}
