/**
 * Copyright © 2019 Aga Khan Foundation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

import UIKit
import WebKit
import SnapKit

class AKFLoginViewController: ViewController {
  // window.webkit.messageHandlers.LoginCompleted message
  private static let LoginCompletedHandlerKey: String = "LoginCompleted"

  var webview: WKWebView = WKWebView()

  deinit {
    // explicitly remove the message handler to avoid a circular reference
    webview.configuration.userContentController.removeScriptMessageHandler(
      forName: AKFLoginViewController.LoginCompletedHandlerKey)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }

  private func configure() {
    view.backgroundColor = Style.Colors.Background

    view.addSubview(webview) { (make) in
      make.centerX.centerY.equalToSuperview()
      make.width.height.equalToSuperview()
    }
    webview.configuration.userContentController.add(self, name: AKFLoginViewController.LoginCompletedHandlerKey)
    webview.load(URLRequest(url: URL(string: "https://www.akfusa.org/steps4impact/?fbid=\(Facebook.id)")!))
  }
}

extension AKFLoginViewController: WKScriptMessageHandler {
  func userContentController(_ userContentController: WKUserContentController,
                             didReceive message: WKScriptMessage) {
    // TODO(compnerd) handle the message, save the AKFID
  }
}
