//
//  LoadingView.swift
//  NoteBook
//
//  Created by Arman Zadeh-Attar on 2023-02-17.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Spacer()
                LottieView().frame(height: UIScreen.main.bounds.height / 2)
                Text("Loading").font(.title3).fontWeight(.bold)
                Spacer()
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
