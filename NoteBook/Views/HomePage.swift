//
//  HomePage.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-10.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomePage: View {
    
    @State var searchText = ""
    @State var searchSheet = false
    @StateObject var vm = BookViewModel()
    
    var body: some View {
        if vm.loaded {
            NavigationView {
                VStack{
                    HStack {
                        Text("My BookShelf").font(.title).fontWeight(.bold).padding([.top, .horizontal])
                        Spacer()
                    }
                    List{
                        ForEach (searchResult, id: \.id) { book in
                            NavigationLink {
                                BookDetailView()
                                    .onAppear{
                                        vm.setBook(book: book)
                                    }
                            } label: {
                                BookCellView(book: book)
                            }
                        }
                    }.searchable(text: $searchText, prompt: "Search your Bookshelf")
                }.toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("NoteBook")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            AddBookView()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .environmentObject(vm)
            .sheet(isPresented: $searchSheet) {
                AddBookView()
            }
        } else {
            LoadingView()
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(BookViewModel())
    }
}

extension HomePage {
    private var searchBar: some View {
        HStack{
            TextField("Search Bookshelf", text: $searchText).padding(.leading, 30)
        }
        .padding()
        .background(
            Color(.systemGray5)
        )
        .cornerRadius(6)
        .padding(.horizontal)
        .overlay(
            HStack{
                Image(systemName: "magnifyingglass")
                Spacer()
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                
            }.padding(.horizontal, 32)
                .foregroundColor(.gray)
        )
    }
    var searchResult: [BookEntity] {
        if searchText.isEmpty {
            return vm.books
        } else {
            let books = vm.books.filter({
                $0.title?.contains(searchText) ?? false
            })
            return books
        }
    }
}
