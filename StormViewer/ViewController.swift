//
//  ViewController.swift
//  StormViewer
//
//  Created by Paul Richardson on 28/03/2021.
//

import UIKit

class ViewController: UICollectionViewController {

	var pictures = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Storm Viewer"
		navigationController?.navigationBar.prefersLargeTitles = true

		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fm.contentsOfDirectory(atPath: path)

		for item in items {
			if item.hasPrefix("nssl") {
				pictures.append(item)
			}
		}
		pictures = pictures.sorted()
		print(pictures)

	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pictures.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
			fatalError("Unable to dequeue picture cell.")
		}
		cell.title?.text = "Picture \(indexPath.row + 1)/\(pictures.count)"
		cell.detail?.text = pictures[indexPath.row]
		return cell
	}

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
			vc.selectedImage = pictures[indexPath.row]
			vc.numbers = (indexPath.row, pictures.count)
			navigationController?.pushViewController(vc, animated: true)
		}
	}

}

