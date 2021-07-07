//
//  Extension.swift
//  Swift Login
//
//  Created by Sumesh Vs on 03/07/21.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
