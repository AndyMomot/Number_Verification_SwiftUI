//
//  HelpWebPageCV.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 11.10.22.
//

import SwiftUI

struct HelpWebPageCV: View {
    @State private var showLoading = false
    var body: some View {
        VStack {
            WebPage(urlString: ConstantsGlobal().helpWebPage, showLoading: $showLoading)
                .overlay(showLoading ? ProgressView().toAnyView() : EmptyView().toAnyView())
        }
    }
}

struct HelpWebPageCV_Previews: PreviewProvider {
    static var previews: some View {
        HelpWebPageCV()
    }
}
