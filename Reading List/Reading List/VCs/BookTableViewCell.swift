//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Samantha Gatt on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    func updateViews() {
        guard let thisBook = book else { return }
        bookTitleLabel.text = thisBook.title
        
        if thisBook.hasBeenRead == true {
            readButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            readButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
    }
    
    @IBAction func changeReadStatus(_ sender: Any) {
        delegate?.toggleHasBeenRead(forCell: self)
    }
    
    weak var delegate: BookTableViewCellDelegate?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
}
