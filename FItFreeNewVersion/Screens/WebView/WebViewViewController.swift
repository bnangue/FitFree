//
//  WebViewViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 25.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webViewContainer: WKWebView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var urlToload: URL!
    var businessId: String!
    var  progressView = UIProgressView(progressViewStyle: .default)

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        progressView.sizeToFit()
       
        webViewContainer.addSubview(progressView)
        webViewContainer.navigationDelegate = self
        webViewContainer.uiDelegate = self

        webViewContainer.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        // Do any additional setup after loading the view.
        
        webViewContainer.load(URLRequest(url: urlToload!))
        
        if webViewContainer.isLoading {
            showActivityIndicator()
        }
            
       
        
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if !webView.isLoading{
            stopActivityIndicator()
        
        }
        
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if !webView.isLoading{
            stopActivityIndicator()
            
        }
    
        print(error)
    }
    
   
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webViewContainer.estimatedProgress)
            if webViewContainer.estimatedProgress > 0.7 {
                stopActivityIndicator()
            }
        }
    }
    
    func showActivityIndicator(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    func stopActivityIndicator(){
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
