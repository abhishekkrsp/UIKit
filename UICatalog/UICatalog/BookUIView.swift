//
//  BookUIView.swift
//  UICatalog
//
//  Created by Abhishek Kumar on 03/03/22.
//

import Foundation
import UIKit

class BookView: UIView {
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.addRect(bounds)
            context.setLineWidth(10)
            UIColor.yellow.withAlphaComponent(0.7).setStroke()
            context.strokePath()
        }
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 15.0)
        roundedRect.addClip()
        UIColor.gray.withAlphaComponent(0.4).setFill()
        roundedRect.fill()
    }
}
