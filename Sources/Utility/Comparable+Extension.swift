//
//  Comparable+Extension.swift
//  RUIKit
//
//  Created by Rachel Lee on 12/27/24.
//

import Foundation

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}
