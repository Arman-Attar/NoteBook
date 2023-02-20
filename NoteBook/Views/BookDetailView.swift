//
//  BookDetailView.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-15.
//

import SwiftUI

struct BookDetailView: View {
    
    @State var selectedIndex = 0
    @EnvironmentObject var vm: BookViewModel
    @State var showNoteSheet = false
    @State var addNoteSheet = false
    
    var body: some View {
        if let book = vm.book {
            VStack{
                Picker("Select" ,selection: $selectedIndex) {
                    Text("Book Detail").tag(0)
                    Text("Notes").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                if selectedIndex == 0 {
                    ScrollView{
                        BookPreviewView()
                    }
                } else {
                    if let notes = book.notes?.allObjects as? [NoteEntity] {
                        List {
                            ForEach(notes) { note in
                                Button {
                                    showNoteSheet.toggle()
                                } label: {
                                    NoteCellView(note: note)
                                }.foregroundColor(.primary)
                                    .sheet(isPresented: $showNoteSheet) {
                                        NoteView(note: note)
                                            .presentationDetents([.medium, .large])
                                    }
                            }.onDelete { indexSet in
                                vm.deleteNote(offSet: indexSet, noteID: nil)
                            }
                        }
                    }
                
                }
                Spacer()
            }.navigationTitle(book.title ?? "N/A")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            addNoteSheet.toggle()
                        } label: {
                            HStack{
                                Text("Add Note")
                                Image(systemName: "square.and.pencil")
                            }
                        }
                    }
                }
                .sheet(isPresented: $addNoteSheet) {
                    AddNoteView()
                }
        } else {
            ProgressView()
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
            .environmentObject(BookViewModel())
    }
}
