//
//  Validators.swift
//  FinFlow
//
//  Created by RASHED on 2/8/26.
//

import Foundation

enum Validators {

    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
}

