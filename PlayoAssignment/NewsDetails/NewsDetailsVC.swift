//
//  NewsDetailsVC.swift
//  PlayoAssignment
//
//  Created by Akila Arun on 7/15/22.
//

import UIKit
import WebKit
import ANLoader
class NewsDetailsVC: UIViewController, WKNavigationDelegate {
    var url = ""
   
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(url != ""){
           
            let url = URL (string: "\(url)")
           
            let requestObj = URLRequest(url: url!)
            
            webView.load(requestObj)
          
            
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
   

}
