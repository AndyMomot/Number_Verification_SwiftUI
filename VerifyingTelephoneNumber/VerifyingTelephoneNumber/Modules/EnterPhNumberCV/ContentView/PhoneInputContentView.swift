//
//  PhoneInputContentView.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 5.10.22.
//

import SwiftUI
import Firebase

struct PhoneInputContentView: View {
    var body: some View {
        PhoneInputView()
    }
}

struct PhoneIputContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhoneInputContentView()
        }
    }
}
