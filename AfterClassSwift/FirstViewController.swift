//
//  FirstViewController.swift
//  AfterClassSwift
//
//  Created by Dustin Quam on 3/16/15.
//  Copyright (c) 2015 Student Life Marketing + Design. All rights reserved.
//

import UIKit
import WebKit

class FirstViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView
    

    required init(coder aDecoder: NSCoder) {
        let config = WKWebViewConfiguration()
        let scriptURL = NSBundle.mainBundle().pathForResource("Custom", ofType: "js")
        let scriptContent = String(contentsOfFile:scriptURL!, encoding:NSUTF8StringEncoding, error: nil)
        let script = WKUserScript(source: scriptContent!, injectionTime: .AtDocumentStart, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        
        self.webView = WKWebView(frame: CGRectZero, configuration: config)
        super.init(coder: aDecoder)
        
        self.webView.navigationDelegate = self
    }

    func webView(webView: WKWebView!, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError!) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
   func webView(webView: WKWebView!, decidePolicyForNavigationAction navigationAction: WKNavigationAction!, decisionHandler: ((WKNavigationActionPolicy) -> Void)!) {
//        //println(navigationAction.request.URL.description)
//        if (navigationAction.navigationType == WKNavigationType.LinkActivated && navigationAction.request.URL.description == "http://afterclass.uiowa.edu/events") {
//             decisionHandler(WKNavigationActionPolicy.Allow)
//        }else{
//            decisionHandler(WKNavigationActionPolicy.Cancel)
//            
//            
//           // let singleEventView = SingleEventViewController()
//            //self.navigationController?.pushViewController(singleEventView, animated: true)
//            
//        }
    
        if (navigationAction.navigationType == WKNavigationType.LinkActivated) {
            //UIApplication.sharedApplication().openURL(navigationAction.request.URL)
            decisionHandler(WKNavigationActionPolicy.Cancel)
            
            let singleEventView = SingleEventViewController()
            self.navigationController?.pushViewController(singleEventView, animated: true)
            
        } else {
            println(navigationAction.navigationType == WKNavigationType.LinkActivated)
            println(navigationAction.request.URL.description)

            decisionHandler(WKNavigationActionPolicy.Allow)
            
            //let singleEventView = SingleEventViewController()
            //self.navigationController?.pushViewController(singleEventView, animated: true)
            
            
        }
    }
    
    func webView(webView: WKWebView,
        didStartProvisionalNavigation navigation: WKNavigation!){
            
           // self.navigationController?.navigationBar.hidden = false
            
            //let singleEventView = SingleEventViewController()
            //self.navigationController?.pushViewController(singleEventView, animated: true)
            
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        webView.setTranslatesAutoresizingMaskIntoConstraints(false)
        let height = NSLayoutConstraint(item: webView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0)
        view.addConstraints([height, width])
        
        let url = NSURL(string:"http://hulk.imu.uiowa.edu/after-class/events/")
        let request = NSURLRequest(URL:url!)
        webView.loadRequest(request)
        
        webView.addObserver(self, forKeyPath: "title", options: .New, context: nil)
        
        self.navigationController?.navigationBar.hidden = true

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

