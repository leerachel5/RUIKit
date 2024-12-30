//
//  BinaryFloatingPoint+Extension.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/29/24.
//

import Foundation

extension BinaryFloatingPoint {
    /// Scales a value proportionally from one factor to another.
    /// - Parameters:
    ///   - originalFactor: The original factor associated with the value.
    ///   - targetFactor: The target factor to scale the value to.
    /// - Returns: The scaled value.
    func scaled(from originalFactor: Self, to targetFactor: Self) -> Self {
        return self / originalFactor * targetFactor
    }
}
