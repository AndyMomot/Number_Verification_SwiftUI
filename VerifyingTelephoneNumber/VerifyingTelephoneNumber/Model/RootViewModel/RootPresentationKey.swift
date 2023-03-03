//
//  RootPresentationKey.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 14.10.2022.
//

import SwiftUI

struct RootPresentationKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var rootPresentation: Binding<Bool> {
        get { self[RootPresentationKey.self] }
        set { self[RootPresentationKey.self] = newValue}
    }
}
