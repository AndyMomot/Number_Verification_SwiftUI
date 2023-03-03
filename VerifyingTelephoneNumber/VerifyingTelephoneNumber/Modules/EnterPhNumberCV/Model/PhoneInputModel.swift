//
//  PhoneInputModel.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 7.10.22.
//

import SwiftUI

class PhoneInputModel {
    var textForegroundColor = Color.black
    var showWarningLabel = false
    
    
    static let countryCode = "380"
    static let countryFlag = "🇺🇦"
    static let placeholderText = "123456789"
}

// Error processing
extension PhoneInputModel {
    func showInvalidNumberError() {
        withAnimation {
            textForegroundColor = .red
            showWarningLabel = true
        }
        
    }
    
    func backButtonPressed() {
        textForegroundColor = Color.black
        showWarningLabel = false
    }
}

extension PhoneInputModel {
    func showWarningLabelView(_ showWarningLabel: Bool) -> some View {
        VStack(alignment: .leading) {
            Text("Please enter a valid mobile number")
                .foregroundColor(self.textForegroundColor)
                .setSubtitleStyle()
                .opacity(showWarningLabel ? 1 : 0)
        }
    }
    
    func showProgressView(loadingProcess: Bool) -> some View {
        VStack {
            if loadingProcess {
                ProgressView()
            } else {
                EmptyView()
                    .frame(height: 0)
            }
        }
    }
}
