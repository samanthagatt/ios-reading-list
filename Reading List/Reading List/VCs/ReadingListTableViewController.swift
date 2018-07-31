//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Samantha Gatt on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Functions
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            let book = bookController.unreadBooks[indexPath.row]
            return book
        } else {
            let book = bookController.readBooks[indexPath.row]
            return book
        }
    }
    
    func toggleHasBeenRead(forCell: BookTableViewCell) {
        guard let book = forCell.book else { return }
        bookController.updateHasBeenRead(forBook: book)
        tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if bookController.unreadBooks.count != 0 {
                return "Unread Books"
            } else { return nil }
        default:
            if bookController.readBooks.count != 0 {
                return "Read Books"
            } else { return nil }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return bookController.unreadBooks.count
        default:
            return bookController.readBooks.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        guard let conformingCell = cell as? BookTableViewCell else { fatalError("Cell is not a BookTableViewCell") }
        
        conformingCell.book = bookFor(indexPath: indexPath)
        conformingCell.delegate = self

        return conformingCell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.delete(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? BookDetailViewController else { return }
        destinationVC.bookController = bookController
        
        if segue.identifier == "ShowBookDetails" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let book = bookFor(indexPath: indexPath)
            destinationVC.book = book
        }
    }
    
    
    // MARK: - Properties
    
    let bookController = BookController()
}
