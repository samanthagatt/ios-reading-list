//
//  BookTableViewCellProtocol.swift
//  Reading List
//
//  Created by Samantha Gatt on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(forCell: BookTableViewCell)
}
