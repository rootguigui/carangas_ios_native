//
//  CarViewController+Extension.swift
//  Carangas
//
//  Created by gui on 01/06/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import Foundation
import UIKit
import WebKit

extension CarViewController : WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
