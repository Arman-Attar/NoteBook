//
//  BookDetailView.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-10.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookPreviewView: View {
    @EnvironmentObject var vm: BookViewModel
    @Environment(\.dismiss) var dismiss
    @State var deleteAlert = false
    var body: some View {
        VStack{
            if let book = vm.searchedBook {
                VStack(alignment: .leading){
                    ZStack {
                        if let url = book.coverURL {
                            WebImage(url: URL(string: url))
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 20,height: UIScreen.main.bounds.height/2)
                                .aspectRatio(contentMode: .fit)
                                .blur(radius: 7)
                            
                            WebImage(url: URL(string: url))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 300)
                                .shadow(radius: 20)
                        }
                    }
                }.padding(.top)
                    .frame(height: UIScreen.main.bounds.height/2)
                Divider().padding(.horizontal)
                ScrollView {
                    VStack{
                        Text(book.volumeInfo?.title ?? "Title N/A")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding([.horizontal, .top])
                        ForEach(book.volumeInfo?.authors ?? [], id: \.self) { author in
                            Text(author).font(.headline)
                        }
                        HStack{
                            Divider().frame(height: 10)
                            ForEach(book.volumeInfo?.categories ?? [], id: \.self) { category in
                                Text(category).font(.caption)
                                Divider().frame(height: 10)
                            }
                            Text("\(book.volumeInfo?.pageCount ?? 0) Pages").font(.caption)
                            Divider().frame(height: 10)
                        }
                        Text(book.searchInfo?.textSnippet ?? "No Snippet Available").padding([.horizontal, .bottom])
                        
                        HStack {
                            Button {
                                if vm.added {
                                    deleteAlert.toggle()
                                } else {
                                    vm.addBook(book: book)
                                }
                            } label: {
                                Text(vm.added ? "Remove from Bookshelf" : "Add to Bookshelf")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color(.gray).opacity(0.5))
                                    .cornerRadius(20)
                                    .padding(.horizontal)
                        }
                            Button {
                                dismiss()
                            } label: {
                                Text("Close")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color(.gray).opacity(0.5))
                                    .cornerRadius(20)
                                    .padding(.horizontal)
                        }
                        }.lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .alert(isPresented: $deleteAlert) {
                                Alert(
                                    title: Text("Are you sure you want to remove this book?"),
                                    primaryButton: .destructive(Text("Remove")) {
                                        vm.deleteBook(isbn: book.volumeInfo?.industryIdentifiers?[0].identifier ?? "")
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                    }
                }
            } else {
                ProgressView()
            }
        }
        .padding()
    }
}

struct BookPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        BookPreviewView()
            .environmentObject(BookViewModel())
    }
}
