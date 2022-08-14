//
//  WebVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit
import WebKit

protocol WebView: AnyObject {
    
    func load(_ request: URLRequest)
    func setTitle(_ value: String)
}

class WebVC: UIViewController, WebView {

    // MARK: - Coordinators
    var onBack: VoidClosure?
    
    
    // MARK: - Outlets
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var progressView: UIProgressView!
    
    // MARK: - Properties
    private var estimatedProgressObserver: NSKeyValueObservation?
    var presenter: WebPresenter
    
    // MARK: - View
    init(presenter: WebPresenter) {
        self.presenter = presenter
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        updateData()
    }
    
    // MARK: - Private
    private func configure() {
        self.view.backgroundColor = Styles.shared.color.vc
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new], changeHandler: { (webview, _) in
            self.progressView.progress = Float(webview.estimatedProgress)
        })
        progressView.isHidden = true
        progressView.alpha = 0
    }
    
    // MARK: - Data
    func updateData() {
        presenter.updateData()
    }
}

// MARK: - WebView
extension WebVC {
    
    func load(_ request: URLRequest) {
        webView.load(request)
    }
    
    func setTitle(_ value: String) {
        self.title = value
    }
}


// MARK: Navigation Delegate
extension WebVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if progressView.isHidden {
            progressView.isHidden = false
        }
        UIView.animate(withDuration: 0.25) {
            self.progressView.alpha = 1
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIView.animate(withDuration: 0.25, animations: {
            self.progressView.alpha = 0
        }) { isFinished in
            // true if finished, false if enterrupted, for example, by new load
            self.progressView.isHidden = isFinished
        }
    }
}
