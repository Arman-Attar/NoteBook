//
//  BookCellView.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-11.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookCellView: View {
    var book: BookEntity
    var body: some View {
                    HStack{
                        WebImage(url: URL(string: book.coverURL ?? ""))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: UIScreen.main.bounds.height/7.5)
                            .shadow(radius: 10)
                            .padding()
                        VStack(alignment: .leading) {
                            Text(book.title ?? "N/A").font(.title3).fontWeight(.bold).lineLimit(2).minimumScaleFactor(0.5)
                            ForEach(book.authors ?? [], id: \.self) { author in
                                Text(author)
                            }
                        }.foregroundColor(.primary)
                        Spacer()
                    }.padding(.horizontal, 5)
    }
}

//struct BookCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookCellView(book: Book(id: "sxVHDwAAQBAJ", volumeInfo: VolumeInfo(title: "12 Rules for Life", authors: ["Jordan B. Peterson"], pageCount: 450, categories: ["Psychology"]), searchInfo: SearchInfo(textSnippet: "")))
//    }
//}
