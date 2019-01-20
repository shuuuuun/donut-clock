//
//  DonutView.swift
//  DonutClock
//
//  Created by motoki-shun on 2019/01/10.
//  Copyright © 2019 motoki-shun. All rights reserved.
//

import UIKit

class DonutView: UIView {

    let lineMargin: CGFloat = 2
    let lineWidth: CGFloat = 30
    let maxRadius: CGFloat = 120
    let adjustY: CGFloat = 30
    let fontSize: CGFloat = 20
    let pi = CGFloat(Double.pi)

    let redColor = UIColor.init(hex: "f31e58")
    let greenColor = UIColor.init(hex: "99f700")
    let blueColor = UIColor.init(hex: "00dad8")
    let yellowColor = UIColor.init(hex: "f8c437")

    var redLayer = CAShapeLayer()
    var greenLayer = CAShapeLayer()
    var blueLayer = CAShapeLayer()
    var yellowLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear

        let center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0 + adjustY)
        initDonutLayer(sublayer: redLayer, color: redColor, center: center, radius: maxRadius - lineWidth*0 - lineMargin*0, label: "H")
        initDonutLayer(sublayer: greenLayer, color: greenColor, center: center, radius: maxRadius - lineWidth*1 - lineMargin*1, label: "M")
        initDonutLayer(sublayer: blueLayer, color: blueColor, center: center, radius: maxRadius - lineWidth*2 - lineMargin*2, label: "S")

//        setupAnimatioin(layer: redLayer, duration: 1, ratio: 0)
//        setupAnimatioin(layer: greenLayer, duration: 1, ratio: 0)
//        setupAnimatioin(layer: blueLayer, duration: 1, ratio: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showMilliSecond() {
        let center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0 + adjustY)
        initDonutLayer(sublayer: yellowLayer, color: yellowColor, center: center, radius: maxRadius - lineWidth*3 - lineMargin*3 + lineWidth/4, label: "MS", sizeRatio: 0.5)
//        setupAnimatioin(layer: yellowLayer, duration: 0.5, ratio: 0)
    }

    private func initDonutLayer(sublayer: CAShapeLayer, color: UIColor, center: CGPoint, radius: CGFloat, label: String = "", sizeRatio: CGFloat = 1) {
        let startAngle = -pi / 2
        let endAngle = 2 * pi * 3/4

        // background
        let bgLayer = CAShapeLayer()
        let bgPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        bgLayer.path = bgPath.cgPath
        bgLayer.fillColor = UIColor.clear.cgColor
        bgLayer.strokeColor = color.cgColor
        bgLayer.lineWidth = lineWidth * sizeRatio
        bgLayer.strokeEnd = 1.0
        bgLayer.opacity = 0.2
        sublayer.addSublayer(bgLayer)

        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        sublayer.lineCap = CAShapeLayerLineCap.round
        sublayer.path = circlePath.cgPath
        sublayer.fillColor = UIColor.clear.cgColor
        sublayer.strokeColor = color.cgColor
        sublayer.lineWidth = lineWidth * sizeRatio
        sublayer.strokeEnd = 0.0
//        sublayer.shadowColor = UIColor.black.cgColor
//        sublayer.shadowRadius = 8.0
//        sublayer.shadowOpacity = 0.9
//        sublayer.shadowOffset = CGSize(width: 0, height: 0)
//        sublayer.shadowOffset.path = UIBezierPath(ovalInRect: CGRectMake(0, 40, 20, 20)).cgPath
//        sublayer.shadowOffset.fillColor = UIColor.grayColor().cgColor
        layer.addSublayer(sublayer)

//        let gradLayer = CAGradientLayer()
//        gradLayer.frame = frame
//        gradLayer.colors = [
//            UIColor.red.cgColor,
//            UIColor.blue.cgColor,
//        ]
//        gradLayer.mask = sublayer
//        layer.addSublayer(gradLayer)

        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: center.x - lineWidth/2, y: center.y - radius - lineWidth/2*sizeRatio + 3*sizeRatio, width: lineWidth, height: lineWidth)
        textLayer.string = label
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.font = "Futura-Medium" as CFString
        textLayer.fontSize = fontSize * sizeRatio
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
//        textLayer.backgroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale // for retina
        sublayer.addSublayer(textLayer)

//        let capLayer = CAShapeLayer()
//        let capX = center.x - lineWidth/2
//        let capY = center.y - radius - lineWidth/2
//        let capPath = UIBezierPath(ovalIn: CGRect(x: capX, y: capY, width: lineWidth, height: lineWidth))
//        capPath.apply(CGAffineTransform(translationX: center.x, y: center.y).inverted())
//        capPath.apply(CGAffineTransform(rotationAngle: endAngle))
//        capPath.apply(CGAffineTransform(translationX: center.x, y: center.y))
//        capLayer.shadowColor = UIColor.black.cgColor
//        capLayer.shadowRadius = 8.0
//        capLayer.shadowOpacity = 0.9
//        capLayer.shadowOffset = CGSize(width: 0, height: 0)
//        capLayer.fillColor = color.cgColor
//        capLayer.path = capPath.cgPath
//        capPath.apply(CGAffineTransform(translationX: center.x, y: center.y).inverted())
//        capPath.apply(CGAffineTransform(rotationAngle: -endAngle)) // reset angle
//        capPath.apply(CGAffineTransform(translationX: center.x, y: center.y))
//        sublayer.setValue(capLayer, forKey: "cap")
//        sublayer.setValue(capPath, forKey: "capBezierPath")
//        sublayer.addSublayer(capLayer)
    }

    func animateCircle(duration: TimeInterval, redRatio: CGFloat = 1, greenRatio: CGFloat = 1, blueRatio: CGFloat = 1, yellowRatio: CGFloat = 1) {
        setupAnimatioin(layer: redLayer, duration: 1, ratio: redRatio)
        setupAnimatioin(layer: greenLayer, duration: 1, ratio: greenRatio)
        setupAnimatioin(layer: blueLayer, duration: 1, ratio: blueRatio)
        setupAnimatioin(layer: yellowLayer, duration: 0.05, ratio: yellowRatio)
    }

    private func setupAnimatioin(layer: CAShapeLayer, duration: TimeInterval, ratio: CGFloat = 1) {
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.duration = duration
        startAnimation.fromValue = 0
        startAnimation.toValue = 0
        startAnimation.isRemovedOnCompletion = true
        startAnimation.fillMode = CAMediaTimingFillMode.forwards
        startAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        startAnimation.delegate = self as? CAAnimationDelegate
        layer.strokeStart = 0
        layer.add(startAnimation, forKey: "animateStrokeStart")

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = ratio
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        layer.strokeEnd = ratio
        layer.add(animation, forKey: "animateCircle")
    }

    func animateRound(layer: CAShapeLayer) {
        print(layer.strokeStart, layer.strokeEnd, ceil(layer.strokeEnd))
        layer.strokeStart = 1
        layer.strokeEnd = 1
//        layer.strokeStart += 1
//        layer.strokeEnd = ceil(layer.strokeEnd)
//        redLayer.strokeStart = 1
//        greenLayer.strokeStart = 1
//        blueLayer.strokeStart = 1
//        yellowLayer.strokeStart = 1
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(resetDonut), userInfo: layer, repeats: false)
    }

    @objc func resetDonut(_ sender: Timer) {
        let layer = sender.userInfo as! CAShapeLayer
//        print(layer.animationKeys())
//        let animation = layer.animation(forKey: "animateStrokeStart")
//        print(animation)
//        animation?.duration = 0
//        print(layer.animation(forKey: "animateCircle"))
//        print(layer.animation(forKey: "animateStrokeStart"))

//        redLayer.strokeStart = 0
//        greenLayer.strokeStart = 0
//        blueLayer.strokeStart = 0
//        yellowLayer.strokeStart = 0
//        redLayer.strokeEnd = 0
//        greenLayer.strokeEnd = 0
//        blueLayer.strokeEnd = 0
//        yellowLayer.strokeEnd = 0

        layer.strokeStart = 0
        layer.strokeEnd = 0
    }

    func drawDonut(redRatio: CGFloat = 1, greenRatio: CGFloat = 1, blueRatio: CGFloat = 1, yellowRatio: CGFloat = 0) {
//        redLayer.strokeEnd = redRatio
//        greenLayer.strokeEnd = greenRatio
//        blueLayer.strokeEnd = blueRatio
//        yellowLayer.strokeEnd = yellowRatio

        if redLayer.strokeEnd > 0.9 && redRatio < redLayer.strokeEnd && redLayer.strokeStart < 1 {
            animateRound(layer: redLayer)
        }
        else {
            redLayer.strokeEnd = redRatio
        }
        if greenLayer.strokeEnd > 0.9 && greenRatio < greenLayer.strokeEnd && greenLayer.strokeStart < 1 {
            animateRound(layer: greenLayer)
        }
        else {
            greenLayer.strokeEnd = greenRatio
        }
        if blueLayer.strokeEnd > 0.9 && blueRatio < blueLayer.strokeEnd && blueLayer.strokeStart < 1 {
            animateRound(layer: blueLayer)
        }
        else {
            blueLayer.strokeEnd = blueRatio
        }
//        if yellowLayer.strokeEnd > 0.9 && yellowRatio <= yellowLayer.strokeEnd {
        if yellowLayer.strokeEnd > 0.9 && yellowRatio < yellowLayer.strokeEnd && yellowLayer.strokeStart < 1 {
//        let yellowCurrentRatio = yellowLayer.strokeEnd - floor(yellowLayer.strokeEnd)
//        print(yellowLayer.strokeEnd, yellowLayer.strokeStart, yellowRatio, yellowCurrentRatio)
//        if yellowCurrentRatio > 0.9 && yellowRatio < yellowCurrentRatio {
            animateRound(layer: yellowLayer)
        }
        else {
            yellowLayer.strokeEnd = yellowRatio
//            yellowLayer.strokeEnd += yellowRatio
//            yellowLayer.strokeEnd = floor(yellowLayer.strokeEnd) + yellowRatio
        }

//        print(layer.sublayers)
//        print(redLayer.sublayers)
//        for(layer in redLayer.sublayers) if([layer.name isEqualToString:@"A"])return;

//        let transformCenter = CGAffineTransform(translationX: center.x, y: center.y + adjustY)
//        print(frame, center, redRatio, greenRatio, blueRatio)

//        var capLayer = redLayer.value(forKey: "cap") as! CAShapeLayer
//        var capPath = redLayer.value(forKey: "capBezierPath") as! UIBezierPath
//        capPath.apply(transformCenter.inverted())
//        capPath.apply(CGAffineTransform(rotationAngle: 2 * pi * redRatio))
//        capPath.apply(transformCenter)
//        capLayer.path = capPath.cgPath
//        capPath.apply(transformCenter.inverted())
//        capPath.apply(CGAffineTransform(rotationAngle: -2 * pi * redRatio)) // reset angle
//        capPath.apply(transformCenter)
//
//        capLayer = greenLayer.value(forKey: "cap") as! CAShapeLayer
//        capPath = greenLayer.value(forKey: "capBezierPath") as! UIBezierPath
//        capPath.apply(transformCenter.inverted())
//        capPath.apply(CGAffineTransform(rotationAngle: 2 * pi * greenRatio))
//        capPath.apply(transformCenter)
//        capLayer.path = capPath.cgPath
//        capPath.apply(transformCenter.inverted())
//        capPath.apply(CGAffineTransform(rotationAngle: -2 * pi * greenRatio)) // reset angle
//        capPath.apply(transformCenter)
//
//        capLayer = blueLayer.value(forKey: "cap") as! CAShapeLayer
//        capPath = blueLayer.value(forKey: "capBezierPath") as! UIBezierPath
//        capPath.apply(transformCenter.inverted())
//        capPath.apply(CGAffineTransform(rotationAngle: 2 * pi * blueRatio))
//        capPath.apply(transformCenter)
//        capLayer.path = capPath.cgPath
//        capPath.apply(transformCenter.inverted())
//        capPath.apply(CGAffineTransform(rotationAngle: -2 * pi * blueRatio)) // reset angle
//        capPath.apply(transformCenter)
    }
}
