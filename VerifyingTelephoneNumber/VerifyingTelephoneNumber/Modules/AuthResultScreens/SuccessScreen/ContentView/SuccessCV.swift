//
//  SuccessCV.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 5.10.22.
//

import SwiftUI
import Firebase

struct SuccessCV: View {
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: "checkmark.circle.fill")
                    .setImageStyle(foregroundColor: .green)
                
                Text("Your account is verified!")
                    .setTitleStyle()
            }
            
            Text("Thanks for your verifying account and helping us create a safe invieroment. You can now create your adverb.")
                .setSubtitleStyle()
            
            Spacer()
            
            NavigationLink(destination: HelpWebPageCV(), label: {
                Text("Continue")
                    .setRegularGreenStyle()
            })
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Authentication")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Right
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    SessionServiceImpl().logout()
                    // Pop to root screen
                    rootPresentation.wrappedValue = false
                } label: {
                    Text("Sign out")
                        .foregroundColor(Color(.label))
                }
            }
        }
    }
}

struct SuccessCV_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SuccessCV()
        }
    }
}
