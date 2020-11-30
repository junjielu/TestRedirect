//
//  ViewController.swift
//  TestRedirect
//
//  Created by 陆俊杰 on 2020/11/10.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getRedirectedUrl("https://mp.weixin.qq.com/s/u_UMgxLtabx-_RrAkz3GAg")
    }

    func getRedirectedUrl(_ currentUrl: String) {
//        let redirectedUrl = "https://redirect.ruguoapp.com/?redirect=" + (currentUrl.stringByAddingPercentEncodingForURLQueryValue ?? "")
        print("redirect url: \(currentUrl)")
        
        let handler = Redirector.follow
        AF.request(currentUrl, method: .head)
            .redirect(using: handler)
            .response { (response) in
                print(response)
            }
    }
}


extension String {
    var stringByAddingPercentEncodingForURLQueryValue: String? {
        // https://www.ietf.org/rfc/rfc3986.txt, "2.3.  Unreserved Characters"
        // Characters that are allowed in a URI but do not have a reserved purpose are called unreserved.  These include uppercase and lowercase letters, decimal digits, hyphen, period, underscore, and tilde.
        var unreservedCharacterSet = CharacterSet.alphanumerics
        unreservedCharacterSet.insert(charactersIn: "-._~")

        return addingPercentEncoding(withAllowedCharacters: unreservedCharacterSet)
    }
}
