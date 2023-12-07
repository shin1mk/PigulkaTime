//
//  Extension + String.swift .swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 06.12.2023.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
}
