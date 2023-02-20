//
//  MainView.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-10.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = BookViewModel()
    var body: some View {
        TabView{
            HomePage()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            AddBookView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }.environmentObject(vm)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
