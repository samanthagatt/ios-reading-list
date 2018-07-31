//
//  BookController.swift
//  Reading List
//
//  Created by Samantha Gatt on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        
        let fm = FileManager.default
        let fileName = "ReadingList.plist"
        
        // Creates a full path where the books will be stored
        guard let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let bookDir = docDir.appendingPathComponent(fileName)
        
        return bookDir
    }
    
    
    var readBooks: [Book] {
        return books.filter {$0.hasBeenRead == true}
    }
    
    var unreadBooks: [Book] {
        return books.filter {$0.hasBeenRead == false}
    }
    
    
    func saveToPersistentStore() {
        
        guard let url = readingListURL else { return }
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            NSLog("Error saving book data: \(error)")
        }
    }
    
    
    func loadFromPersistentStore() {
        do {
            guard let url = readingListURL else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            
            books = decodedBooks
            
        } catch {
            NSLog("Error loading book data: \(error)")
        }
    }
    
    
    func create(title: String, reasonToRead: String) {
        
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        
        saveToPersistentStore()
    }
    
    
    func delete(book: Book) {
        
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    
    func update(book: Book, title: String, reasonToRead: String) {
        
        guard let index = books.index(of: book) else { return }
        
        books[index].title = title
        
        if reasonToRead != books[index].reasonToRead {
            books[index].reasonToRead = reasonToRead
        }
        
        saveToPersistentStore()
    }
    
    
    func updateHasBeenRead(forBook book: Book) {
        
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead = !books[index].hasBeenRead
        
        saveToPersistentStore()
    }
}
