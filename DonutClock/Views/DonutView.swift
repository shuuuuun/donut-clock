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

//    let redColor = UIColor.init(hex: "f31e58")
//    let greenColor = UIColor.init(hex: "99f700")
//    let blueColor = UIColor.init(hex: "00dad8")
//    let yellowColor = UIColor.init(hex: "f8c437")
    let redColor = UIColor.init(hex: "444444")
    let greenColor = UIColor.init(hex: "666666")
    let blueColor = UIColor.init(hex: "888888")
    let yellowColor = UIColor.init(hex: "bbbbbb")

    var circleCenter = CGPoint()

    var redLayer = CAShapeLayer()
    var greenLayer = CAShapeLayer()
    var blueLayer = CAShapeLayer()
    var yellowLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear

        circleCenter = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0 + adjustY)
        initDonutLayer(sublayer: redLayer, color: redColor, radius: maxRadius - lineWidth*0 - lineMargin*0, label: "H")
        initDonutLayer(sublayer: greenLayer, color: greenColor, radius: maxRadius - lineWidth*1 - lineMargin*1, label: "M")
        initDonutLayer(sublayer: blueLayer, color: blueColor, radius: maxRadius - lineWidth*2 - lineMargin*2, label: "S")

//        setupAnimatioin(layer: redLayer, duration: 1, ratio: 0)
//        setupAnimatioin(layer: greenLayer, duration: 1, ratio: 0)
//        setupAnimatioin(layer: blueLayer, duration: 1, ratio: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showMilliSecond() {
        initDonutLayer(sublayer: yellowLayer, color: yellowColor, radius: maxRadius - lineWidth*3 - lineMargin*3 + lineWidth/4, label: "MS", sizeRatio: 0.5)
//        setupAnimatioin(layer: yellowLayer, duration: 0.5, ratio: 0)
    }

    private func initDonutLayer(sublayer: CAShapeLayer, color: UIColor, radius: CGFloat, label: String = "", sizeRatio: CGFloat = 1) {
        let startAngle = -pi / 2
        let endAngle = 2 * pi * 3/4

        // background
        let bgLayer = CAShapeLayer()
        let bgPath = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        bgLayer.path = bgPath.cgPath
        bgLayer.fillColor = UIColor.clear.cgColor
        bgLayer.strokeColor = color.cgColor
        bgLayer.lineWidth = lineWidth * sizeRatio
        bgLayer.strokeEnd = 1.0
        bgLayer.opacity = 0.2
        sublayer.addSublayer(bgLayer)

//        let circlelayer = CAShapeLayer()
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: circleCenter.x, y: circleCenter.y - radius), radius: lineWidth*sizeRatio/2, startAngle: 0, endAngle: 2 * pi, clockwise: true)
//        circlelayer.path = circlePath.cgPath
//        circlelayer.fillColor = color.cgColor
//        circlelayer.opacity = 0
//        sublayer.addSublayer(circlelayer)

        let donutPath = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        sublayer.lineCap = CAShapeLayerLineCap.round
        sublayer.path = donutPath.cgPath
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
        textLayer.frame = CGRect(x: circleCenter.x - lineWidth/2, y: circleCenter.y - radius - lineWidth/2*sizeRatio + 3*sizeRatio, width: lineWidth, height: lineWidth)
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
        setupAnimatioin(sublayer: redLayer, duration: 1, ratio: redRatio)
        setupAnimatioin(sublayer: greenLayer, duration: 1, ratio: greenRatio)
        setupAnimatioin(sublayer: blueLayer, duration: 1, ratio: blueRatio)
        setupAnimatioin(sublayer: yellowLayer, duration: 0.05, ratio: yellowRatio)
    }

    private func setupAnimatioin(sublayer: CAShapeLayer, duration: TimeInterval, ratio: CGFloat = 1) {
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.duration = duration
        startAnimation.fromValue = 0
        startAnimation.toValue = 0
        startAnimation.isRemovedOnCompletion = true
        startAnimation.fillMode = CAMediaTimingFillMode.forwards
        startAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        startAnimation.delegate = self as? CAAnimationDelegate
        sublayer.strokeStart = 0
        sublayer.add(startAnimation, forKey: "animateStrokeStart")

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = ratio
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        sublayer.strokeEnd = ratio
        sublayer.add(animation, forKey: "animateCircle")
    }

    func animateRound(sublayer: CAShapeLayer, duration: Double = 0.5) {
        sublayer.strokeStart = 0
        sublayer.strokeEnd = 1
//        sublayer.opacity = 0
//        sublayer.strokeStart += 1
//        sublayer.strokeEnd = ceil(layer.strokeEnd)
//        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(resetDonut), userInfo: sublayer, repeats: false)

        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setCompletionBlock({
            CATransaction.begin()
//            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
            CATransaction.setAnimationDuration(0)
//            CATransaction.setDisableActions(true)
            CATransaction.disableActions()
            sublayer.strokeStart = 0
            sublayer.strokeEnd = 0
//            print(sublayer.sublayers)
            CATransaction.commit()
        })
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.isRemovedOnCompletion = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        sublayer.add(animation, forKey: "animateRound")

        CATransaction.commit()
    }

    @objc func resetDonut(_ sender: Timer) {
        let layer = sender.userInfo as! CAShapeLayer
//        print(layer.animationKeys())
//        let animation = layer.animation(forKey: "animateStrokeStart")
//        print(animation)
//        animation?.duration = 0
//        print(layer.animation(forKey: "animateCircle"))
//        print(layer.animation(forKey: "animateStrokeStart"))

        layer.strokeStart = 0
        layer.strokeEnd = 0
//        layer.opacity = 1
    }

    func drawDonut(redRatio: CGFloat = 1, greenRatio: CGFloat = 1, blueRatio: CGFloat = 1, yellowRatio: CGFloat = 0) {
        drawDonutLayer(sublayer: redLayer, ratio: redRatio)
        drawDonutLayer(sublayer: greenLayer, ratio: greenRatio)
        drawDonutLayer(sublayer: blueLayer, ratio: blueRatio)
        drawDonutLayer(sublayer: yellowLayer, ratio: yellowRatio)
    }

    func drawDonutLayer(sublayer: CAShapeLayer, ratio: CGFloat) {
        let animation = sublayer.animation(forKey: "animateRound")
        if (animation == nil) && sublayer.strokeEnd > 0.9 && ratio < sublayer.strokeEnd && sublayer.strokeEnd != 1 {
            animateRound(sublayer: sublayer)
        }
        else if (animation == nil) {
            sublayer.strokeEnd = ratio
        }

//        print(layer.sublayers)
//        for(layer in redLayer.sublayers) if([layer.name isEqualToString:@"A"])return;

//        let transformCenter = CGAffineTransform(translationX: center.x, y: center.y + adjustY)

//        var capLayer = redLayer.value(forKey: "cap") as! CAShapeLayer
//        var capPath = redLayer.value(forKey: "capBezierPath") as! UIBezierPath
//        capPath.apply(transformCenter.inverted())
//        capPath.apply(CGAffineTransform(rotationAngle: 2 * pi * redRatio))
//        capPath.apply(transformCenter)
//        capLayer.path = capPath.cgPath
//        capPath.apply(transformCenter.inverted())
//        capPath.apply(CGAffineTransform(rotationAngle: -2 * pi * redRatio)) // reset angle
//        capPath.apply(transformCenter)
    }
}
