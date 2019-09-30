//
//  DisintegrateAdapter.swift
//  DisintegrateDemo
//
//  Created by K Y on 6/22/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Disintegrate

extension UIView {
    @objc open func disintegrate(withEstimatedTriangleCount: Int = 50,
                                        completion: (()->())? = nil) {
        disintegrate(direction: .random(),
                     estimatedTrianglesCount: withEstimatedTriangleCount,
                     completion: completion)
    }
}
