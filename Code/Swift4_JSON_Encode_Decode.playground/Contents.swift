//: Playground - noun: a place where people can play

import UIKit

class Tutorial: Codable {
  let title: String
  let author: String
  let editor: String
  let type: String
  let publishDate: Date
  let book: Book
  
  init(title: String, author: String, editor: String, type: String, publishDate: Date, book: Book) {
    self.title = title
    self.author = author
    self.editor = editor
    self.type = type
    self.publishDate = publishDate
    self.book = book
  }
}

class Book: Codable{
  let name: String
  let progress: Float
  init(name: String, progress: Float) {
    self.name = name
    self.progress = progress
  }
}

let book = Book(name: "Rose", progress: 20.33)

let tutorial = Tutorial(title: "Hello", author: "Rocoo", editor: "rocoo", type: "normal", publishDate: Date(), book: book)



// Encode
let encoder = JSONEncoder()
let data = try encoder.encode(tutorial)

let string = String(data: data, encoding: .utf8)


// Decode
let decoder = JSONDecoder()
let article = try decoder.decode(Tutorial.self, from: data)
let info = "\(article.title) \(article.author) \(article.editor) \(article.type) \(article.publishDate)"
