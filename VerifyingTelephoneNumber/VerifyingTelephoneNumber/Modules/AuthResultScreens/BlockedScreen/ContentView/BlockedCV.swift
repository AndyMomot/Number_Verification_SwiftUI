//
//  BlockedCV.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 6.10.22.
//

import SwiftUI

struct BlockedCV: View {
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: "exclamationmark.circle.fill")
                    .setImageStyle(foregroundColor: .red)
                
                Text("Account blocked!")
                    .setTitleStyle()
            }
            
            Text("Your account has been blocked due to too many failed verification attempts. Please contact our.")
                .setSubtitleStyle()
            
            VStack(spacing: 20) {
                NavigationLink(destination: HelpWebPageCV(), label: {
                    Text("Help desk")
                        .setRegularGreenStyle()
                })
                
                Button {
                    // Pop to root screen
                    rootPresentation.wrappedValue = false
                } label: {
                    Text("Close")
                        .setRegularWhiteStyle()
                }
            }
            
            Spacer()
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
                    rootPresentation.wrappedValue = false
                } label: {
                    Text("Close")
                        .foregroundColor(Color(.label))
                }
            }
        }
    }
}

struct BlockedCV_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BlockedCV()
        }
    }
}
