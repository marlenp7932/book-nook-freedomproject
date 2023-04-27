//
//  SecondViewController.swift
//  book-nook-fp
//
//  Created by marlen :P on 4/26/23.
//

import UIKit

class ViewController: UIViewController {
   // creating an outlet --> controls table view
   @IBOutlet var tableView: UITableView!
   var books = [String]()
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.title = "books"
      tableView.delegate = self
      tableView.dataSource = self
      
      // set up
      if !UserDefaults().bool(forKey: "setup"){
         UserDefaults().set(true, forKey: "setup")
         UserDefaults().set(0, forKey: "count")
      }
   }
   
   func updateBooks(){
      books.removeAll()
      guard let count = UserDefaults().value(forKey: "count") as? Int else {
         return
      }
      for x in 0..<count {
         if let book = UserDefaults().value(forKey: "book_\(x+1)") as? String {
            books.append(book)
         }
      }
      tableView.reloadData()
   }
   
   @IBAction func pressedAddBook(){
      let vc = storyboard?.instantiateViewController(withIdentifier: "addedBook") as! SecondViewController
      vc.title = "New Book"
      vc.update = {
         DispatchQueue.main.async{
            self.updateBooks()
         }
         self.updateBooks()
      }
   }
}

// creating delegates using extensions
extension ViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
      tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension ViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return books.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      cell.textLabel?.text = books[indexPath.row]
      return cell
  }
}

