//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Samantha Gatt on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        updateViews()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        guard let thisBook = book else { self.title = "Add a new book"; return }
        self.title = thisBook.title
        titleTextField.text = thisBook.title
        reasonToReadTextView.text = thisBook.reasonToRead
    }

    
    @IBAction func save(_ sender: Any) {
        guard let title = titleTextField.text,
            let reasonToRead = reasonToReadTextView.text else { return }
        
        if let thisBook = book {
            bookController?.update(book: thisBook, title: title, reasonToRead: reasonToRead)
        } else {
            bookController?.create(title: title, reasonToRead: reasonToRead)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
}
