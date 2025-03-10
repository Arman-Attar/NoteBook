//
//  ContentView.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-09.
//

import SwiftUI
import CodeScanner
import SDWebImageSwiftUI
import TelemetryDeck


struct AddBookView: View {
    @State var present = false
    @State var secondSheet = false
    @State var code: String = ""
    @State var searchText = ""
    @EnvironmentObject var vm: BookViewModel
    var body: some View {
            VStack {
                HStack{
                    searchBar
                        .submitLabel(.search)
                        .onSubmit {
                            Task{
                                await vm.searchBook(title: searchText)
                            }
                            TelemetryDeck.signal("Name.Search")
                        }
                    Spacer()
                    Button {
                        present.toggle()
                        TelemetryDeck.signal("QR.Search")
                    } label: {
                        Image(systemName: "barcode.viewfinder")
                            .font(.system(size: 35)).padding(.trailing)
                    }
                }
                ScrollView {
                    ForEach(vm.searchedBooks, id: \.id) { book in
                        Button {
                            self.code = book.volumeInfo?.industryIdentifiers?[0].identifier ?? ""
                            secondSheet = true
                        } label: {
                            HStack{
                                WebImage(url: URL(string: book.coverURL ?? ""))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: UIScreen.main.bounds.height/7)
                                    .shadow(radius: 10)
                                    .padding(.leading)
                                Spacer()
                                Text(book.volumeInfo?.title ?? "N/A").font(.title3).fontWeight(.bold)
                                Spacer()
                            }.padding()
                        }
                        Divider().padding(.horizontal)
                    }.foregroundColor(.primary)
                }.navigationTitle("Add a book")
                    .padding()
                    .sheet(isPresented: $present) {
                        sheet
                    }
                    .sheet(isPresented: $secondSheet) {
                        BookPreviewView().environmentObject(vm).onAppear{
                            Task {
                                await vm.getBook(isbn: self.code)
                            }
                        }
                    }
                Spacer()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
            .environmentObject(BookViewModel())
    }
}

extension AddBookView {
    private var searchBar: some View {
        HStack{
            TextField("Search Book", text: $searchText).padding(.leading, 30)
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
                    vm.resetSearedBooks()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                
            }.padding(.horizontal, 32)
                .foregroundColor(.gray)
        )
    }
    
    private var sheet: some View {
        CodeScannerView(
            codeTypes: [.ean13]) { result in
                if case let .success(success) = result {
                    self.code = success.string
                    present = false
                    secondSheet = true
                } else {
                    self.code = ""
                    present = false
                }
            }
    }
}
