//
//  Enum.swift
//  Tourism
//
//  Created by Adhitya Bagas on 21/08/22.
//

import Foundation

enum CustomError: Error {
    case expected(message: String)
    case unexpected(message: String)
}
