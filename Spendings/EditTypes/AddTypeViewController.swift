//
//  AddTypeViewController.swift
//  Spendings
//
//  Copyright © 2017 Козлов Егор. All rights reserved.
//

import UIKit
import RealmSwift

class AddTypeViewController: UIViewController {
    
    fileprivate struct Storyboard {
        static let cellIdentifier = "cellId"
        static let doneSegueIdentifier = "done"
    }
    
    fileprivate struct Constants {
        static let imageCount = 19
    }
    
    let realm = try! Realm()

    @IBOutlet weak var titleTextField: UITextField! {
        didSet{
            titleTextField.becomeFirstResponder()
            titleTextField.delegate = self
        }
    }
    @IBOutlet weak var imageSelectionView: UICollectionView!
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if let itemIndex = imageSelectionView.indexPathsForSelectedItems?.first?.row {
            let imageName = "Image\(itemIndex)"
            if let title = titleTextField.text {
                let spendingType = SpendingType(value: [title, imageName])
                try! realm.write {
                    realm.add(spendingType)
                }
            }
        }
        self.performSegue(withIdentifier: Storyboard.doneSegueIdentifier, sender: self)
    }
}

extension AddTypeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.text != ""
    }
}

extension AddTypeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.imageCount
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.cellIdentifier, for: indexPath) as! ImageCollectionViewCell
        let name = "Image\(indexPath.row)"
        cell.image.image = UIImage(named: name)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension AddTypeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        cell.bordered = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        cell.bordered = false
    }

}
