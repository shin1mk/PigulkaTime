//
//  Models.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 09.11.2023.
//

import Foundation

struct Pill {
    var name: String?
    var dosage: String
    var type: String // Добавлено поле для хранения типа
    var isEditable: Bool
}
