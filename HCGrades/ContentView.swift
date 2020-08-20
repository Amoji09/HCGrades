//
//  ContentView.swift
//  HCGrades
//
//  Created by Amogh Mantri on 5/24/20.
//  Copyright © 2020 Amogh Mantri. All rights reserved.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State var login = LoginView()
    var body: some View{
        VStack{
                login
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
