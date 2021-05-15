//
//  Sequence+histogram.swift
//  VictoryPoints
//
//  Created by Adam Del Castillo on 5/13/21.
//

import Foundation

extension Sequence where Element: Hashable {
    var histogram: [Element: Int] {
        return self.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
    }
}
