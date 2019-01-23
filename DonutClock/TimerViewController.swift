//
//  TimerViewController.swift
//  DonutClock
//
//  Created by motoki-shun on 2019/01/20.
//  Copyright © 2019 motoki-shun. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    var donutView: DonutView!
    var clockTimer: Timer!
    var startDateTime: Date!
    var targetDateTime: Date!

    @IBOutlet weak var digitalClock: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        donutView = DonutView(frame: self.view.frame)
        view.addSubview(donutView)

        //        let animationDuration = 1.0
        //        donutView.animateCircle(duration: animationDuration, redRatio: 1, greenRatio: 1, blueRatio: 1, yellowRatio: 1)
        let hour = CGFloat(0)
        let minute = CGFloat(15)
        let second = CGFloat(30)
        targetDateTime = Date(timeIntervalSinceNow: Double(hour * 60 * 60 + minute * 60 + second))
        donutView.drawDonut(redRatio: hour / 24, greenRatio: minute / 60, blueRatio: second / 60)

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
        let elapsedTime = targetDateTime.timeIntervalSinceNow
        let hour = CGFloat(floor(elapsedTime / 60 / 60))
        let minute = CGFloat(floor(elapsedTime / 60)) - hour * 60
        let second = CGFloat(elapsedTime) - hour * 60 - minute * 60
//        print(targetDateTime, elapsedTime, hour, minute, second)
        donutView.drawDonut(redRatio: hour / 24, greenRatio: minute / 60, blueRatio: second / 60)
        digitalClock.text = String(format: "%02d", Int(hour)) + ":" + String(format: "%02d", Int(minute)) + ":" + String(format: "%02d", Int(second))
    }
}

