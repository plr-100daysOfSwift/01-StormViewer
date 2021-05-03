//
//  ViewController.swift
//  StormViewer
//
//  Created by Paul Richardson on 28/03/2021.
//

import UIKit

class ViewController: UITableViewController {

	let defaults = UserDefaults.standard

	var pictures = [String]()
	var viewCounts = [String: Int]()

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

		if let viewCounts = defaults.object(forKey: "ViewCounts") as? [String : Int] {
			self.viewCounts = viewCounts
		}

	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pictures.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
		cell.textLabel?.text = "Picture \(indexPath.row + 1) of \(pictures.count)"
		cell.detailTextLabel?.text = pictures[indexPath.row]
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
			vc.selectedImage = pictures[indexPath.row]
			vc.numbers = (indexPath.row, pictures.count)
			navigationController?.pushViewController(vc, animated: true)
		}
	}
}

