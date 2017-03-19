//
//  ViewController.swift
//  HowToWebViewCell
//
//  Created by Denis Hennessy on 19/03/2017.
//  Copyright © 2017 Peer Assembly. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    fileprivate var rowHeights: [CGFloat] = []
    fileprivate let estimatedHeight: CGFloat = 64

    fileprivate func setRowHeight(_ height: CGFloat, forRow row: Int) {
        while rowHeights.count <= row {
            rowHeights.append(estimatedHeight)
        }
        if rowHeights[row] != height {
            rowHeights[row] = height
        }
    }

}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10
    }
    
}

extension ViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if row < rowHeights.count {
            return rowHeights[row]
        } else {
            return estimatedHeight
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let webCellView = tableView.make(withIdentifier: "WebCellView", owner: self) as! WebCellView
        webCellView.onSizeChanged = { height in
            Swift.print("Height of row \(row): \(height)")
            self.setRowHeight(height, forRow: row)
            tableView.noteHeightOfRows(withIndexesChanged: IndexSet(integer: row))
        }
        let html = makeTestHtml(row: row)
        webCellView.webView.mainFrame.loadHTMLString(html, baseURL: nil)
        return webCellView
    }
    
    func makeTestHtml(row: Int) -> String {
        var html = "<h1>Row \(row)</h1>\n"
        for _ in 0...row {
            html.append("<p>This is a sample paragraph containing some <b>bold</b> and <i>italic</i> text.</p>\n")
            html.append("<ul>\n")
            html.append("<li>Bullet point</li>\n")
            html.append("<li>Bullet point 2</li>\n")
            html.append("</ul>\n")
        }
        return html
    }
}
