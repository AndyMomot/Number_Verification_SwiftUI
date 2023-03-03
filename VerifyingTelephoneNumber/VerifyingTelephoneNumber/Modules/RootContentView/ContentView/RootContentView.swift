//
//  ContentView.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 28.9.22.
//

import SwiftUI

struct RootContentView: View {
    @StateObject var sessionService: SessionServiceImpl
    var body: some View {
            VStack(alignment: .leading, spacing: nil, content: {
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Verification failed!")
                        .setTitleStyle()
                }
                
                Spacer()
                
                NavigationLink(destination: StartContentView(), label: {
                    Text("Auth")
                        .setRegularGreenStyle()
                })
            })
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Authentication")
            .navigationBarBackButtonHidden(true)
            .opacity(sessionService.state == .loggedIn ? 0 : 1)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootContentView(sessionService: SessionServiceImpl())
    }
}
