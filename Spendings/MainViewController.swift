//
//  ViewController.swift
//  Spendings
//
//  Copyright © 2017 Козлов Егор. All rights reserved.
//

import UIKit
import RealmSwift

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ViewController: UIViewController {

    struct Storyboard {
        static let cellIdentifier = "cellId"
    }
    @IBOutlet weak var collectionView: UICollectionView!

    let realm = try! Realm()
    
    override func viewDidLoad() {
        
        self.setNeedsStatusBarAppearanceUpdate()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var types: Results<SpendingType> {
        get {
            return realm.objects(SpendingType)
        }
    }
    
    var valueString: String? {
        get {
            return self.navigationItem.title
        }
        set {
            self.navigationItem.title = newValue
        }
    }
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func clearClick(_ sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            self.valueString = String(self.valueString!.characters.dropLast())
            if self.valueString == "" {
                userIsInTheMiddleOfTypingANumber = false
                self.valueString = "Введите сумму"
            }
        }
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        let char = sender.titleLabel?.text
        
        if userIsInTheMiddleOfTypingANumber && self.valueString?.characters.count > 10 {
            return
        }
        if char == "." && self.valueString!.characters.contains(char!.characters.first!) {
            return
        }
        if !userIsInTheMiddleOfTypingANumber {
            if char == "0" {
                return
            }
            self.valueString = ""
            userIsInTheMiddleOfTypingANumber = true
        }
        self.valueString = self.valueString! + char!
    }
    
    fileprivate func saveData(_ cost: Double, type: SpendingType) {
        let spending = Spending()
        spending.cost = cost
        spending.type = type
        spending.data = Date()
        try! realm.write {
            realm.add(spending)
        }
        self.valueString = "Введите сумму"
        self.userIsInTheMiddleOfTypingANumber = false
    }
    
    @IBAction func saveClick(_ sender: AnyObject) {
        var fail = false
        var failDescription: String?
        
        if let value = NumberFormatter().number(from: self.valueString!)?.doubleValue {
            if let selected = collectionView.indexPathsForSelectedItems?.first {
                let type = types[selected.row]
                
                let alert = UIAlertController(title: "Сохранить", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
                
                let action = UIAlertAction(title: "Сохранить", style: .default) { [unowned self] _ in
                    self.saveData(value, type: type)
                }
                let cancelAction = UIAlertAction(title: "Отменить", style: UIAlertActionStyle.cancel, handler: nil)
                
                alert.addAction(action)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true, completion: nil)
            } else {
                fail = true
                failDescription = "Нужно выбрать тип"
            }
        } else {
            fail = true
            failDescription = "Введено некорректная сумма"
        }
        if fail {
            let alert = UIAlertController(title: "Ошибка", message: failDescription, preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "Ок", style: UIAlertActionStyle.cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func openMenu(_ sender: AnyObject) {
        toggleSideMenuView()
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.cellIdentifier, for: indexPath) as! LabeledImageCollectionViewCell
        let item = types[indexPath.row]
        cell.image.image = UIImage(named: item.image)
        cell.textLable.text = item.title
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! LabeledImageCollectionViewCell
        cell.bordered = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)  as! LabeledImageCollectionViewCell
        cell.bordered = false
    }

}

