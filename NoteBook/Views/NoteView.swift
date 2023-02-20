//
//  NoteView.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-16.
//

import SwiftUI

struct NoteView: View {
    var note: NoteEntity
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: BookViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Form {
                    Section {
                        Text(note.note ?? "Error Loading Note")
                            .font(.headline)
                            .padding()
                            .lineLimit(nil)
                    }
                    Section {
                        Button {
                            vm.deleteNote(offSet: nil, noteID: note.id)
                            dismiss()
                        } label: {
                            HStack{
                                Spacer()
                                Text("Delete Note")
                                Spacer()
                            }
                        }
                    }
                }
            }.navigationTitle(note.title ?? "Untitled")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack{
                            if note.chapter ?? "" != "" {
                                Text("Chapter: \(note.chapter!)")
                            }
                            if note.pageNumber ?? "" != "" {
                                Text("Page: \(note.pageNumber!)")
                            }
                        }.font(.headline)
                    }
                }
        }
    }
}

//struct NoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteView()
//    }
//}
