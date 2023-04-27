//
//  ThirdViewController.swift
//  book-nook-fp
//
//  Created by marlen :P on 4/26/23.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    // second outlet
    @IBOutlet var field: UITextField!
     
     var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveBookTitle))
        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        saveBookTitle()
        return true
    }

     @objc func saveBookTitle(){
         guard let book = field.text, !book.isEmpty else {
             return
         }
        
        guard let count = UserDefaults().value(forKey: "count")as? Int else{
           return
        }
        let newCount = count + 1
        UserDefaults().set(newCount, forKey:"count")
        UserDefaults().set(book, forKey:"book_\(newCount)")
          
        update?()
          navigationController?.popViewController(animated: true)
     }
}

