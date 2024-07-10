//
//  CatsDetailsViewController.swift
//  cats
//
//  Created by Alan Rodriguez on 02/07/24.
//

import UIKit
import WebKit

class CatsDetailsViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.uiDelegate = self
            webView.navigationDelegate = self
        }
    }
    @IBOutlet weak var tagsLabel: UILabel!
    
    var viewModel: CatsDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let url = URL(string: viewModel.url) else { return }
        webView.load(URLRequest(url: url))
                
        tagsLabel.textColor = .blue
        tagsLabel.text = viewModel.tags.joined(separator: ", ")
        title = viewModel.tags.joined(separator: ", ")
    }
}
