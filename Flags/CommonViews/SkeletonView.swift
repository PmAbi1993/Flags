//
//  SkeletonView.swift
//  ShimmerAnimationComplete
//
//  Created by admin on 15/07/21.
//

import UIKit

class SkeletonView: UIView {
    let gradientLayer = CAGradientLayer()
    var gradientColorOne: CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    var gradientColorTwo: CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() {
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne,
                                gradientColorTwo,
                                gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        self.layer.addSublayer(gradientLayer)
        let animation = addAnimation()
        gradientLayer.add(animation, forKey: animation.keyPath)

    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateFrames()
    }
    func updateFrames() {
        for traversedLayer in layer.sublayers ?? [] {
            print(gradientLayer == traversedLayer)
            if gradientLayer == traversedLayer {
                traversedLayer.frame = self.bounds
            }
        }
    }
    func addAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 0.9
        return animation
    }
    func startAnimating() {
        let animation = addAnimation()
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
}
