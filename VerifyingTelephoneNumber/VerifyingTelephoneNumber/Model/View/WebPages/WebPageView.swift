//
//  WebPageView.swift
//  VerifyingTelephoneNumber
//
//  Created by Андрей on 30.9.22.
//

import Foundation
import SwiftUI
import WebKit

struct WebPage: UIViewRepresentable {
    
    var urlString: String
    @Binding var showLoading: Bool
    
    func makeUIView(context: Context) -> some UIView {
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL!")
            return getDefaultWebPage()
        }
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    private func getDefaultWebPage() -> WKWebView {
        let defaultURL = URL(string: ConstantsGlobal().defaultWebPage)!
        let webView = WKWebView()
        let request = URLRequest(url: defaultURL)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator {
            showLoading = true
        } didFinish: {
            showLoading = false
        }

    }
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    
    var didStart: () -> Void
    var didFinish: () -> Void
    
    init(didStart: @escaping () -> Void = {}, didFinish: @escaping () -> Void = {}) {
        self.didStart = didStart
        self.didFinish = didFinish
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        didStart()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinish()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
}
