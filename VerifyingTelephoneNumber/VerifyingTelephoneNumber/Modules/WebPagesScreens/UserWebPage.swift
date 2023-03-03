//
//  UserWebPage.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 12.10.22.
//

import SwiftUI

struct UserWebPage: View {
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>
    @State private var showLoading = false
    var body: some View {
        VStack {
            WebPage(urlString: ConstantsGlobal().userPage, showLoading: $showLoading)
                .overlay(showLoading ? ProgressView().toAnyView() : EmptyView().toAnyView())
        }
        .navigationTitle("Home")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Right
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    rootPresentation.wrappedValue = false
                    SessionServiceImpl().logout()
                } label: {
                    Text("Sign out")
                        .foregroundColor(Color(.label))
                }
            }
        }
    }
}

struct UserWebPage_Previews: PreviewProvider {
    static var previews: some View {
        UserWebPage()
    }
}
