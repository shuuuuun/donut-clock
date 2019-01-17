//
//  DonutView.swift
//  DonutClock
//
//  Created by motoki-shun on 2019/01/10.
//  Copyright © 2019 motoki-shun. All rights reserved.
//

import UIKit

class DonutView: UIView {

    let lineMargin: CGFloat = 1
    let lineWidth: CGFloat = 30.0
    let maxRadius: CGFloat = 120
    let adjustY: CGFloat = 30
    let fontSize: CGFloat = 20
    let pi = CGFloat(Double.pi)

    let redColor = UIColor.init(hex: "f31e58")
    let greenColor = UIColor.init(hex: "99f700")
    let blueColor = UIColor.init(hex: "00dad8")

    var redLayer = CAShapeLayer()
    var greenLayer = CAShapeLayer()
    var blueLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear

        let center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0 + adjustY)
        initDonutLayer(sublayer: redLayer, color: redColor, center: center, radius: maxRadius - lineWidth*0 - lineMargin*0, label: "H")
        initDonutLayer(sublayer: greenLayer, color: greenColor, center: center, radius: maxRadius - lineWidth*1 - lineMargin*2, label: "M")
        initDonutLayer(sublayer: blueLayer, color: blueColor, center: center, radius: maxRadius - lineWidth*2 - lineMargin*4, label: "S")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initDonutLayer(sublayer: CAShapeLayer, color: UIColor, center: CGPoint, radius: CGFloat, label: String = "") {
        let startAngle = -pi / 2
        let endAngle = 2 * pi * 3/4

        // background
        let bgLayer = CAShapeLayer()
        let bgPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        bgLayer.path = bgPath.cgPath
        bgLayer.fillColor = UIColor.clear.cgColor
        bgLayer.strokeColor = color.cgColor
        bgLayer.lineWidth = lineWidth
        bgLayer.strokeEnd = 1.0
        bgLayer.opacity = 0.2
        sublayer.addSublayer(bgLayer)

        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        sublayer.lineCap = CAShapeLayerLineCap.round
        sublayer.path = circlePath.cgPath
        sublayer.fillColor = UIColor.clear.cgColor
        sublayer.strokeColor = color.cgColor
        sublayer.lineWidth = lineWidth
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
        textLayer.frame = CGRect(x: center.x - lineWidth/2, y: center.y - radius - lineWidth/2 + 3, width: lineWidth, height: lineWidth)
        textLayer.string = label
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.font = "Futura-Medium" as CFString
        textLayer.fontSize = fontSize
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

    func animateCircle(duration: TimeInterval, redRatio: CGFloat = 1.0, greenRatio: CGFloat = 1.0, blueRatio: CGFloat = 1.0) {
        var animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = redRatio
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        redLayer.strokeEnd = redRatio
        redLayer.add(animation, forKey: "animateCircle")

        animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = greenRatio
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        greenLayer.strokeEnd = greenRatio
        greenLayer.add(animation, forKey: "animateCircle")

        animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = blueRatio
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        blueLayer.strokeEnd = blueRatio
        blueLayer.add(animation, forKey: "animateCircle")
    }

    func drawDonut(redRatio: CGFloat = 1.0, greenRatio: CGFloat = 1.0, blueRatio: CGFloat = 1.0) {
        redLayer.strokeEnd = redRatio
        greenLayer.strokeEnd = greenRatio
        blueLayer.strokeEnd = blueRatio
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

    override func draw(_ rect: CGRect) {
        //        drawStrokeCircle(rect: CGRect(x: 50, y: 50, width: 100, height: 100))
//        drawStrokeCircle(rect: rect)
    }

    private func drawStrokeCircle(rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let startAngle = -pi / 2
        context.setLineWidth(lineWidth)
        let center = CGPoint(x: rect.origin.x + rect.size.width/2, y: rect.origin.y + rect.size.height/2)
        //        print(rect.origin, rect.size, center)

        context.setStrokeColor(redColor.cgColor)
        context.addArc(center: center, radius: maxRadius - lineWidth*0, startAngle: startAngle, endAngle: pi, clockwise: false)
        context.strokePath()

        context.setStrokeColor(greenColor.cgColor)
        context.addArc(center: center, radius: maxRadius - lineWidth*1, startAngle: startAngle, endAngle: pi, clockwise: false)
        context.strokePath()

        context.setStrokeColor(blueColor.cgColor)
        context.addArc(center: center, radius: maxRadius - lineWidth*2, startAngle: startAngle, endAngle: pi, clockwise: false)
        context.strokePath()
    }
}
