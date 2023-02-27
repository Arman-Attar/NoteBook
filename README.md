# NoteBook

A note taking app for readers, allowing them to save notes and quotes related to a book they are reading. 

[Demo](https://www.armanattar.com/noteBook)

## Description

NoteBook utilizes CodeScanner framework for iOS alongside a simple search bar which allows users to scan or search for the book they are reading. Next, the book is looked up
using the Google Books API and the user is presented with a detailed view of the book which includes its author, category, page numbers and a small description. The user can then
add the book to their bookshelf and this creates an empty container for that book where the user can save their notes. Users can then add notes for that book
and they are given a few options including a title, the note type which can be a user note or a quote, the page and/or the chapter the note is related. Finally, in order to 
save the notes, NoteBook uses Core Data which allows for a simple storage of information.

## Frameworks and APIs

* Core Data
* Google Books API
* [CodeScanner](https://github.com/twostraws/CodeScanner)
* [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI)
