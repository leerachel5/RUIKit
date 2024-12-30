//
//  ClosedRange+Extension.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/29/24.
//

import Foundation

extension ClosedRange where Bound: Numeric {
    /// Computes the span (distance) of the closed range.
    var span: Bound {
        upperBound - lowerBound
    }
}
