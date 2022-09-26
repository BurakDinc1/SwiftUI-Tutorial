//
//  WSResult.swift
//  Tutorial
//
//  Created by Burak Dinç on 26.09.2022.
//

import Foundation

enum WSResult<T> {
    case success(T)
    case failure(ErrorResponse)
}
