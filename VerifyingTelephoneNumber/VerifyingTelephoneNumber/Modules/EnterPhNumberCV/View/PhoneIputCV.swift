//
//  PhoneInputCV.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 28.9.22.
//

import SwiftUI
import Firebase
import Combine

struct PhoneInputView: View {
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>
    
    // MARK: Properties
    @State private var loginData = LoginData()
    @State private var phoneInputModel = PhoneInputModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var phoneNumberString = ""
    @State private var textFieldContent = ""
    @State private var countryCode = PhoneInputModel.countryCode
    @State private var countryFlag = PhoneInputModel.countryFlag
    @State private var placeholderText = PhoneInputModel.placeholderText
    
    @State private var showOverlayCountryCodes = false
    @State private var isValidNumber = false
    @State private var showOTPScreen = false
    @State private var idCodeError = false
    @State private var showLoading = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        GeometryReader.init { geometry in
            ScrollView.init {
                VStack.init(alignment: .leading, spacing: nil, content: {
                    
                    VStack(spacing: 20) {
                        // MARK: Header with info text -
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Verify your phone number")
                                .setTitleStyle()
                            
                            Text("Please enter your mobile phone number and receive your 6-digit confirmation code to verify your account.")
                                .setSubtitleStyle()
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Mobile number")
                                .foregroundColor(phoneInputModel.textForegroundColor)
                                .font(.system(size: 18, weight: .bold, design: .default))
                            
                            // MARK: Country code picker -
                            VStack(alignment: .leading) {
                                HStack (spacing: 0) {
                                    Text("\(countryFlag)￬ +\(countryCode)")
                                        .frame(width: 80, height: 50)
                                        .foregroundColor(countryCode.isEmpty ? .secondary : .black)
                                        // Toggle showOverlayCountryCodes if tapped
                                        .onTapGesture {
                                            withAnimation (.spring()) {                   self.showOverlayCountryCodes.toggle()
                                            }
                                        }
                                    // MARK: Phone Number TextField -
                                    TextField(placeholderText, text: $textFieldContent)
                                        .focused($isFocused)
                                        .padding()
                                        .frame(width: 200, height: 50)
                                        .keyboardType(.numberPad)
                                        .onReceive(Just(textFieldContent)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.textFieldContent = filtered
                                            }
                                        }
                                    Spacer()
                                }
                                .border(.secondary)
                                // Open up Country Codes list if showOverlayCountryCodes == true
                                if showOverlayCountryCodes {
                                    showOverlayWithCountryCodes()
                                }
                                // Warnihg Label
                                if phoneInputModel.showWarningLabel {
                                    phoneInputModel.showWarningLabelView(phoneInputModel.showWarningLabel)
                                }
                                
                            }
                        }
                        
                        VStack(spacing: 20) {
                            // 679621628
                            // Send Code Button
                            Button {
                                sendCodeOnImputedNumber()
                            } label: {
                                Text("Send Code")
                                    .setRegularGreenStyle()
                            }
                            .opacity(textFieldContent.count > placeholderText.count ? 0.6 : 1)
                            
                            // Showing progress view if needed
                            phoneInputModel.showProgressView(loadingProcess: loginData.loadingProcess)
                            
                            // Link to Enter OTP Screen
                            NavigationLink(isActive: $showOTPScreen) {
                                EnterOTPScreenCV(phoneNumber: phoneNumberString, loginData: loginData)
                            } label: {}
                            .frame(height: 0)
                            
                            // Separator
                            Divider()
                                .background(Color.secondary)
                            
                            // Help aria
                            HStack {
                                Text("Having trouble?")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .foregroundColor(.secondary)
                                // Link to Help web page
                                NavigationLink(destination: HelpWebPageCV(),
                                               label: {
                                                    Text("Get help")
                                                        .font(.system(size: 16, weight: .medium, design: .default))
                                                        .foregroundColor(.blue)
                                                    
                                })
                            }
                        }
                        // Show warning alert if ID Code == nil
                        .alert(isPresented: $idCodeError, content: {
                            Alert(title: Text("Something went wrong"),
                                  message: Text("Try again!"),
                                  dismissButton: .cancel(Text("OK")))
                        })
                        .opacity(showOverlayCountryCodes ? 0 : 1)
                        
                        Spacer()
                    }
                })
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Authentication")
        // hide system back button
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Navigation bur buttons
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    phoneInputModel.backButtonPressed()
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("< Back")
                        .foregroundColor(Color(.label))
                }
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    // Pop to root screen
                    rootPresentation.wrappedValue = false
                } label: {
                    Text("Close")
                        .foregroundColor(Color(.label))
                }
            }
            // Keyboard bur buttons
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Done") {
                        self.isFocused = false
                    }
                }
            }
        }
        // Activate Text Field
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.isFocused = true
            }
        }
    }
}

private extension PhoneInputView {
    func showOverlayWithCountryCodes() -> some View {
        GeometryReader { geo in
            List(loginData.countryDictionary.sorted(by: <), id: \.key) { key , value in
                HStack {
                    Text("\(loginData.flag(country: key))")
                    Text("\(loginData.countryName(countryCode: key) ?? key)")
                    Spacer()
                    Text("+\(value)").foregroundColor(.secondary)
                    
                }.background(Color.clear)
                    .font(.system(size: 20))
                    .onTapGesture {
                        self.countryCode = value
                        self.countryFlag = loginData.flag(country: key)
                        showOverlayCountryCodes.toggle()
                        
                        let countryName = "\(loginData.countryName(countryCode: key) ?? key)"
                        placeholderText = loginData.placeholderNumber(countryName: countryName)
                    }
            }
            .shadow(color: .secondary, radius: 4, x: 0, y: 2)
            .padding()
            .frame(width: 400, height: 300)
            .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).maxY + 120)
        }
    }
    
    func sendCodeOnImputedNumber() {
        // Checking internet connection
         guard Reachability.isInternetAvailable else {
             NotificationCenter.default.post(name: .InternetNotAvailable, object: nil)
             loginData.loadingProcess = false
             return
         }
        // Create phone number
        phoneNumberString = "+\(countryCode)\(textFieldContent)"
        // Activate progress view
        loginData.loadingProcess = true
        // Check numbers count
        if textFieldContent.count == placeholderText.count {
            isValidNumber = true
        }
        
        if isValidNumber {
            // Send OTP code
            loginData.sendCodeTo(number: phoneNumberString)
            // Show next screen if IDCode != nil
            DispatchQueue.global().async {
                while loginData.IDCode == nil {
                    showOTPScreen = false
                    sleep(1)
                }
                showOTPScreen = true
            }

        } else {
            // Stop progress view
            loginData.loadingProcess = false
            phoneInputModel.showInvalidNumberError()
        }
    }
}

struct PhoneInputCV_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PhoneInputView()
        }
    }
}
