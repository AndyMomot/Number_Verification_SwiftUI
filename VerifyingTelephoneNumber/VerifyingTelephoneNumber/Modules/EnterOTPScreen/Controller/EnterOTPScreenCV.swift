//
//  EnterOTPScreenCV.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 30.9.22.
//

import SwiftUI
import Combine

struct EnterOTPScreenCV: View {
    // Input objects
    var phoneNumber: String
    var loginData: LoginData
    // Navigation objects
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>
    @Environment(\.presentationMode) private var presentationMode
    // Class objects
    @StateObject private var enterOTPModel = EnterOTPModel(repeatingCount: ConstantsGlobal().numberOfOTPFields)
//    @StateObject private var otpModel: OTPViewModel = .init(repeatingCount: ConstantsGlobal().numberOfOTPFields)
    // Text Field Focus State objects
    @FocusState private var activeField: OTPField?
    @FocusState private var isFocused: Bool
    // SMS code code storage
    @State private var enteredSMSCode: String = ""
    // Validation check objects
    @State private var isValidOTPNumber = false
    // Present next screen
    @State private var showSuccessScreen = false
    @State private var showFailScreen = false
    @State private var showBlockScreen = false
    // Present warning alerts
    @State private var showWarningAlert = false
    @State private var showReportAlert = false
    // Show progress view
    @State private var showLoading = false
    
    var body: some View {
        GeometryReader.init { geometry in
            ScrollView.init {
                VStack.init(alignment: .leading, spacing: nil, content: {
                    VStack(spacing: 25) {
                        // Info block
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Confirm your phone number")
                                .font(.system(size: 22, weight: .bold, design: .default))
                            
                            Text("Please enter the 6-digit code we send it to")
                                .font(.system(size: 18, weight: .light, design: .default)) +
                            Text(" \(self.phoneNumber). ")
                                .font(.system(size: 18, weight: .bold, design: .default)) +
                            Text("This code will expire in 10 minutes.")
                                .font(.system(size: 18, weight: .light, design: .default))
                        }
                        
                        VStack(spacing: 25) {
                            VStack(spacing: 20) {
                                // OTP Text Field
                                createOTPTextField()
                                // Warning Label
                                HStack {
                                    if showFailScreen {
                                        enterOTPModel.showWarningLabel(numberOfAttempt: loginData.numberOfAttempt)
                                    }
                                    Spacer()
                                }
                            }
                            
                            VStack(alignment: .center, spacing: 20) {
                                // Send code button
                                Button {
                                    // test number - 679621628 / code - 123456
                                    verifyNumber()
                                } label: {
                                    Text("Confirm")
                                        .setRegularGreenStyle()
                                }
                                
                                // Show progress view if needed
                                enterOTPModel.showProgressView(loadingProcess: loginData.loadingProcess)
                                
                                // Warning Alert / Show if ID Code is empty
                                .alert(isPresented: $showWarningAlert) {
                                    Alert(title: Text("ID Code error"),
                                          message: Text("Please try again, check your phone number or send new code"),
                                          dismissButton: .cancel(Text("OK"), action: {
                                        showWarningAlert = false
                                    })
                                    )
                                }
                                .frame(height: 80)
                                // Present next screen (Success/Failed/Blocked)
                                self.goToNextScreen()
                                
                                HStack {
                                    Text("Didn't receive a code?")
                                        .font(.system(size: 18, weight: .medium, design: .default))
                                        .foregroundColor(.secondary)
                                    // Send new otp code button
                                    Button {
                                        loginData.requestCodeOn(number: phoneNumber)
                                        showReportAlert = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            self.showReportAlert = false
                                        }
                                    } label: {
                                        Text("Render code")
                                            .foregroundColor(.blue)
                                    }
                                    // Report Alert / Show if sent new code
                                    .alert(isPresented: $showReportAlert) {
                                        Alert(title: Text("New code sent!"),
                                              message: Text("This code will expire in 10 minutes."),
                                              dismissButton: .cancel(Text("OK"), action: {
                                            loginData.loadingProcess = false
                                            self.isFocused = true
                                        })
                                        )
                                    }
                                }
                                // Separator (Gray horizontal line)
                                Divider()
                                    .background(Color.secondary)
                                
                                HStack {
                                    Text("Having trouble?")
                                        .font(.system(size: 16, weight: .medium, design: .default))
                                        .foregroundColor(.secondary)
                                    // Go to help web page
                                    NavigationLink(destination: HelpWebPageCV(), label: {
                                        Text("Get help")
                                            .font(.system(size: 16, weight: .medium, design: .default))
                                            .foregroundColor(.blue)
                                    })
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    // Fill OTP Text Field
                    .onChange(of: enterOTPModel.otpFields, perform: { newValue in
                        OTPCondition(value: newValue)
                    })
                    // Navigation Bar Preferences
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Authentication")
                    .navigationBarBackButtonHidden(true)
                    // Navigation bur buttons
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button {
                                loginData.IDCode = nil
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("< Back")
                                    .foregroundColor(Color(.label))
                            }
                        }
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
                        // Hide Keyboard Button
                        ToolbarItem(placement: .keyboard) {
                            HStack {
                                Spacer()
                                Button("Done") {
                                    self.isFocused = false
                                }
                            }
                        }
                    }
                })
            }
        }
    }
}

private extension EnterOTPScreenCV {
    // MARK: Conditions for custom OTP field & Limiting only one text
    func OTPCondition(value: [String]) {
        // Moving next field if current field type
        for index in 0..<(ConstantsGlobal().numberOfOTPFields - 1) {
            if value[index].count == 1 && enterOTPModel.activeStateForIndex(index: index) == activeField {
                activeField = enterOTPModel.activeStateForIndex(index: index + 1)
            }
        }
        
        // Moving back if current is empty and previous is not empty
        for index in 1...(ConstantsGlobal().numberOfOTPFields - 1) {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = enterOTPModel.activeStateForIndex(index: index - 1)
            }
        }
        
        for index in 0..<ConstantsGlobal().numberOfOTPFields {
            // +380 679621628 / 123456
            if value[index].count > 1 {
                let lastChar = String(value[index].last!)
                enterOTPModel.otpFields[index] = lastChar
            }
        }
        getOTP()
    }
    
    func getOTP() {
        enteredSMSCode = ""
        for otpTF in enterOTPModel.otpFields {
            var otpNumber = otpTF
            if !otpNumber.isEmpty {
                otpNumber.removeFirst(otpNumber.count-1)
                enteredSMSCode += otpNumber
            }
        }
    }
    
    func cleanOTP() {
        for index in 0..<enterOTPModel.otpFields.count {
            enterOTPModel.otpFields[index].removeAll()
        }
        enteredSMSCode = ""
        self.isFocused = true
    }
    
    // MARK: Custom OTP Text Field
    @ViewBuilder
    func createOTPTextField() -> some View {
        HStack(spacing: 20) {
            ForEach(0..<ConstantsGlobal().numberOfOTPFields, id: \.self) { index in
                
                VStack(alignment: .center, spacing: 0) {
                    // MARK: Text Field
                    if index == 0 {
                        createTextField(index: index)
                            .focused($isFocused)
                    } else {
                        createTextField(index: index)
                    }
                    
                    // MARK: Focus Line
                    createRectangle(index: index)
                }
                .frame(width: (UIScreen.main.bounds.width/2 - 40) / CGFloat(ConstantsGlobal().numberOfOTPFields), height: 30)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                        if index == 0 {
                            self.isFocused = true
                        } else {
                            self.isFocused = false
                        }
                    }
                }
            }
        }
    }
    
    func createRectangle(index: Int) -> some View {
        VStack {
            if showFailScreen || showBlockScreen {
                Rectangle()
                    .fill(activeField == enterOTPModel.activeStateForIndex(index: index) ? .red : .red.opacity(0.4))
                    .frame(height: 4)
            } else {
                Rectangle()
                    .fill(activeField == enterOTPModel.activeStateForIndex(index: index) ? .blue : .gray.opacity(0.4))
                    .frame(height: 4)
            }
        }
    }
}

private extension EnterOTPScreenCV {
    func verifyNumber() {
        // Checking internet connection
        guard Reachability.isInternetAvailable else {
            NotificationCenter.default.post(name: .InternetNotAvailable, object: nil)
            loginData.loadingProcess = false
            return
        }
        
        if enteredSMSCode.count == ConstantsGlobal().numberOfOTPFields && !showWarningAlert {
            isValidOTPNumber = true
        }
        
        if isValidOTPNumber {
            loginData.verifyWith(otp: enteredSMSCode)
            cleanOTP()
            
            if loginData.showWarningAlert {
                self.showWarningAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.showWarningAlert = false
                }
            }
            
            DispatchQueue.global().async {
                while loginData.successAuth == false &&
                        loginData.failAuth == false &&
                        loginData.blockedAccount == false {
                    
                    sleep(1)
                }
                if loginData.successAuth {
                    rootPresentation.wrappedValue = false
//                    showSuccessScreen = loginData.successAuth
                }
                showFailScreen = loginData.failAuth
                showBlockScreen = loginData.blockedAccount
            }
        }
        isValidOTPNumber = false
    }
    
    func createTextField(index: Int) -> some View {
        TextField("", text: $enterOTPModel.otpFields[index])
            .textContentType(.oneTimeCode)
            .keyboardType(.numberPad)
            .textContentType(.oneTimeCode)
            .multilineTextAlignment(.center)
            .focused($activeField, equals: enterOTPModel.activeStateForIndex(index: index))
            .frame(width: 40, height: 40, alignment: .center)
        // Enter letters block
            .onReceive(Just(enterOTPModel.otpFields[index])) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue {
                    self.enterOTPModel.otpFields[index] = filtered
                }
            }
    }
    // Working with verification status
    private func goToNextScreen() -> some View {
        VStack {
//            NavigationLink(isActive: $showSuccessScreen) { SuccessCV() } label: {}
            // Or
            NavigationLink(isActive: $showFailScreen) { FailedCV(loginData: loginData) } label: {}
            // Or
            NavigationLink(isActive: $showBlockScreen) { BlockedCV() } label: {}
        }
        .frame(height: 0)
        .hidden()
    }
}

struct EnterOTPScreenCV_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EnterOTPScreenCV( phoneNumber: "+380683213512", loginData: LoginData())
        }
    }
}


