//
//  FailedCV.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 6.10.22.
//

import SwiftUI

struct FailedCV: View {
    var loginData: LoginData
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: "exclamationmark.circle.fill")
                    .setImageStyle(foregroundColor: .yellow)
                
                Text("Verification failed!")
                    .setTitleStyle()
            }
            
            Text("We were unable to verify your mobile number, please try entering your number again or visit our help desk.")
                .setSubtitleStyle()
            
            Spacer()
            
            VStack(spacing: 20) {
                
                Button {
                    loginData.loadingProcess = false
                    loginData.failAuth = false
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Try again")
                        .setRegularGreenStyle()
                }
                
                NavigationLink(destination: HelpWebPageCV(), label: {
                    Text("Help desk")
                        .setRegularWhiteStyle()
                })
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Authentication")
        .navigationBarBackButtonHidden(true)
        // Navigation bur buttons
        .toolbar {
            // Right
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    // Pop to root screen
                    rootPresentation.wrappedValue = false
                } label: {
                    Text("Close")
                        .foregroundColor(Color(.label))
                }
            }
        }
    }
}

struct FailedCV_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FailedCV(loginData: LoginData())
        }
    }
}
