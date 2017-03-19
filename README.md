## How to use a WebView in an NSTableCellView

The purpose of this project is to find the best way to host a WebKit `WebView` in the cell of an `NSTableView`.
When the content is initially set, and as the containing window is adjusted in size, the row height of each cell 
should be adjusted so that the web view precisely fits it.

### Current Issues

1. The solution does not correctly adjust the height when the window size is adjusted.

The approach taken was to use KVO to observe the `mainFrame.frameView.documentView.frame` property of the web view.
Unfortunately, this property does not appear to support KVO.

2. The row height is never reduced, even if the full height is not needed.

This issue can be seen by setting the `estimatedHeight` to 200 and running the app. The first row will be too big.

3. There's a slight visual effect as each row is resized.

