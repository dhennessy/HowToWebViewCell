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
    fileprivate var lastHeight: CGFloat = 0
    fileprivate var lastWidth: CGFloat = 0
    @IBOutlet weak var webView: WebView!
    
    override var frame: NSRect {
        didSet {
            if frame.size.width != lastWidth {
                let height = webView.mainFrame.frameView.documentView.frame.height
                handleHeightChange(height: height)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        webView.frameLoadDelegate = self
        webView.mainFrame.frameView.allowsScrolling = false
    }

    func handleHeightChange(height: CGFloat) {
        if height != lastHeight {
            lastHeight = height
            onSizeChanged?(height)
        }
    }
}

extension WebCellView: WebFrameLoadDelegate {
    
    func webView(_ sender: WebView!, didFinishLoadFor frame: WebFrame!) {
        handleHeightChange(height: webView.mainFrame.frameView.documentView.frame.height + margins)
    }
    
}
