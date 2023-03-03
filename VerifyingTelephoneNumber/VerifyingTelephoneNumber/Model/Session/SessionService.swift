//
//  SessionService.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 6.10.22.
//
import Foundation
import FirebaseAuth
import Combine
import SwiftUI

enum SessionState {
    case loggedIn
    case loggedOut
    
    func isLoggetIn() -> Bool  {
        switch self {
        case .loggedIn:
            return true
        case .loggedOut:
            return false
        }
    }
    
//    func destination() -> some View {
//        VStack {
//            switch self {
//            case .loggedIn:
//                UserWebPage().navigationBarBackButtonHidden(true)
//            case .loggedOut:
//                //PhoneInputView()
//                RootContentView()
//            }
//        }
//    }
}

protocol SessionService {
    var state: SessionState { get }
    func logout()
}

final class SessionServiceImpl: SessionService, ObservableObject {
    
    @Published var state: SessionState = .loggedOut
    //    @Published var userDetails: UserSessionDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        setupObservations()
    }
    
    deinit {
        guard let handler = handler else { return }
        Auth.auth().removeStateDidChangeListener(handler)
        print("deinit SessionServiceImpl")
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}

private extension SessionServiceImpl {
    
    func setupObservations() {
        
        handler = Auth
            .auth()
            .addStateDidChangeListener { [weak self] _,_ in
                guard let self = self else { return }
                
                let currentUser = Auth.auth().currentUser
                self.state = currentUser == nil ? .loggedOut : .loggedIn
            }
    }
}
