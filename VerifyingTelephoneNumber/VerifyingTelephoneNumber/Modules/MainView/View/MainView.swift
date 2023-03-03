//
//  test.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 29.9.22.
//

import SwiftUI
import Firebase

struct MainView: View {
    @StateObject var sessionService = SessionServiceImpl()
    @State var rootPresenting: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Welcome!")
                        .setTitleStyle()
                    
                    Button {
                        rootPresenting.toggle()
                    } label: {
                        Text("Start")
                            .setRegularGreenStyle()
                            .padding(.all,20)
                    }
                    
                    NavigationLink(
                        destination:  getDestination(),
                        isActive: self.$rootPresenting
                    ) { }.hidden()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.rootPresentation, $rootPresenting)
    }
    
    func getDestination() -> some View {
        VStack {
            switch sessionService.state {
            case .loggedIn:
                UserWebPage()
            case .loggedOut:
                RootContentView(sessionService: sessionService)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
