//
//  WebCellView.swift
//  HowToWebViewCell
//
//  Created by Denis Hennessy on 19/03/2017.
//  Copyright © 2017 Peer Assembly. All rights reserved.
//

import Cocoa
import WebKit

class WebCellView: NSTableCellView {

    var onSizeChanged: ((CGFloat) -> ())?
    fileprivate let margins = CGFloat(6)
    fileprivate var observerContext = 0
    fileprivate let frameKeyPath = #keyPath(WebView.mainFrame.frameView.documentView.frame)

    @IBOutlet weak var webView: WebView!
    
    deinit {
        webView.removeObserver(self, forKeyPath: frameKeyPath)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        webView.frameLoadDelegate = self
        webView.addObserver(self, forKeyPath: frameKeyPath, options: [.new, .old] , context: &observerContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath, keyPath == frameKeyPath {
            onSizeChanged?(webView.mainFrame.frameView.documentView.frame.height + margins)
        }
    }

}

extension WebCellView: WebFrameLoadDelegate {
    
    func webView(_ sender: WebView!, didFinishLoadFor frame: WebFrame!) {
        onSizeChanged?(webView.mainFrame.frameView.documentView.frame.height + margins)
    }
    
}
