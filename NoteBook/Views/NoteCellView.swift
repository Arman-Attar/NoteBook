//
//  NoteCellView.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-16.
//

import SwiftUI

struct NoteCellView: View {
    var note: NoteEntity
    var body: some View {
        HStack{
            Text(note.title ?? "Untitled").font(.headline)
            Spacer()
            HStack{
                if note.type == "User Note"{
                    Text("User Note")
                    Image(systemName: "person.text.rectangle.fill")
                } else {
                    Text("Quote")
                    Image(systemName: "text.quote")
                }
            }.font(.caption)
        }.padding()
    }
}

struct NoteCellView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCellView(note: NoteEntity())
    }
}
