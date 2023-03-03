//
//  StartContentView.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 28.9.22.
//

import SwiftUI

struct StartContentView: View {
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>
    
    @StateObject var sessionService = SessionServiceImpl()
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Verify your phone number")
                    .setTitleStyle()
                
                Text("All users must verify their account with a valid mobile number before posting a pet advertisement. Doing so will help us prevent animal welfare issues and reduce fraudulent behaviors.")
                    .setSubtitleStyle()
            }
            
            Spacer()
            
            NavigationLink(destination: PhoneInputContentView(), label: {
                Text("Verify Account")
                    .setRegularGreenStyle()
            })
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Authentication")
        .toolbar {
            Button {
                // Pop to root screen
                rootPresentation.wrappedValue = false
            } label: {
                Text("Close")
                    .foregroundColor(.black)
            }
        }
        .accentColor(.black)
    }
}

struct StartContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StartContentView()
        }
    }
}
