//
//  StopWatchViewController.swift
//  DonutClock
//
//  Created by motoki-shun on 2019/01/09.
//  Copyright © 2019 motoki-shun. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController {

    var donutView: DonutView!
    var clockTimer: Timer!
    var startDateTime: Date!

    @IBOutlet weak var digitalClock: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        donutView = DonutView(frame: self.view.frame)
        donutView.showMilliSecond()
        view.addSubview(donutView)

        let animationDuration = 1.0
        donutView.animateCircle(duration: animationDuration, redRatio: 1, greenRatio: 1, blueRatio: 1, yellowRatio: 1)

//        for sample
//        donutView.animateCircle(duration: animationDuration, redRatio: 10/12, greenRatio: 8/60, blueRatio: 42/60, yellowRatio: 0.4)
//        digitalClock.text = String(format: "%02d", Int(10)) + ":" + String(format: "%02d", Int(8)) + ":" + String(format: "%02d", Int(42))
//        donutView.animateCircle(duration: animationDuration, redRatio: 0.75, greenRatio: 0.75, blueRatio: 0.75, yellowRatio: 0.75)
//        donutView.animateCircle(duration: animationDuration, redRatio: 0.8, greenRatio: 0.7, blueRatio: 0.6, yellowRatio: 0.5)
//        donutView.animateCircle(duration: animationDuration, redRatio: 0.5, greenRatio: 0.6, blueRatio: 0.7, yellowRatio: 0.8)

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapSingle(sender:)))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        super.viewWillDisappear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
    }

    @objc private func tapSingle(sender: UITapGestureRecognizer) {
//        donutView.drawDonut(redRatio: 0.5, greenRatio: 0.5, blueRatio: 0.5, yellowRatio: 0.5)
//        donutView.drawDonut(redRatio: 0.95, greenRatio: 0.95, blueRatio: 0.95, yellowRatio: 0.95)
//        donutView.animateDonut()
//        return
        if clockTimer == nil {
//            donutView.animateDonut()
            start()
        }
        else {
            stop()
        }
    }

    private func start() {
        print("start")
        startDateTime = Date()
        clockTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }

    private func stop() {
        print("stop")
        if let timer = clockTimer {
            timer.invalidate()
        }
        startDateTime = nil
        clockTimer = nil
    }

    @objc private func updateClock() {
        let elapsedTime = -startDateTime.timeIntervalSinceNow
        let hour = CGFloat(floor(elapsedTime / 60 / 60))
        let minute = CGFloat(floor(elapsedTime / 60)) - hour * 60
        let second = CGFloat(elapsedTime) - hour * 60 - minute * 60
        let millisecond = CGFloat(elapsedTime - floor(elapsedTime))
//        print(elapsedTime, hour, minute, second, millisecond)
        donutView.drawDonut(redRatio: hour / 24, greenRatio: minute / 60, blueRatio: second / 60, yellowRatio: millisecond)
        digitalClock.text = String(format: "%02d", Int(hour)) + ":" + String(format: "%02d", Int(minute)) + ":" + String(format: "%02d", Int(second))
    }
}

