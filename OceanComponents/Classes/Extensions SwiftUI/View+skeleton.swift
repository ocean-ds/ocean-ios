//
//  View+skeleton.swift
//  Pods
//
//  Created by Acassio Mendonça on 17/10/24.
//

import SwiftUI
import SkeletonUI

public extension View {
    func oceanSkeleton(with loading: Bool,
                       size: CGSize? = .none,
                       shape: ShapeType = .capsule,
                       lines: Int = 1,
                       scales: [Int: CGFloat]? = .none) -> some View {
        self.skeleton(with: loading,
                  size: size,
                  animation: .none,
                  shape: shape,
                  lines: lines,
                  scales: scales)
    }
}
