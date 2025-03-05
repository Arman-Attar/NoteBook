//
//  AddNoteView.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-15.
//

import SwiftUI

struct AddNoteView: View {
    @State var noteTitle = ""
    @State var types = ["User Note", "Quote"]
    @State var type: String = "User Note"
    @State var pageNumber: String = ""
    @State var chapter: String = ""
    @State var note: String = ""
    @FocusState private var isEditing: Bool
    @EnvironmentObject var vm: BookViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Form {
                    Section("Note Information") {
                        TextField("Note Title", text: $noteTitle)
                        Picker("Note Type", selection: $type) {
                            ForEach(types, id: \.self) {
                                Text($0)
                            }
                        }
                        TextField("Page Number", text: $pageNumber).keyboardType(.numberPad)
                        TextField("Chapter", text: $chapter).keyboardType(.numberPad)
                    }
                    Section("Note") {
                        ZStack(alignment: .topLeading) {
                            if note.isEmpty {
                                Text("Enter your note")
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                                    .padding(.leading, 5)
                            }
                            VStack {
                                TextEditor(text: $note)
                                    .frame(height: 150)
                                    .focused($isEditing)
                                Button("Dismiss Keyboard") {
                                    isEditing = false
                                }
                                .padding()
                            }
                        }
                    }
                    Section {
                        Button {
                            vm.addNote(title: noteTitle, type: type, page: pageNumber, chapter: chapter, note: note)
                            dismiss()
                        } label: {
                            HStack(alignment: .center){
                                Spacer()
                                Text("Save")
                                Spacer()
                            }
                        }
                    }
                }
            }.navigationTitle("Add Note")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        
                    }
                }
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
