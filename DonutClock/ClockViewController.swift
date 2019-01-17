//
//  ClockViewController.swift
//  DonutClock
//
//  Created by motoki-shun on 2019/01/09.
//  Copyright © 2019 motoki-shun. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {

    var donutView: DonutView!
    var clockTimer: Timer!

    @IBOutlet weak var digitalClock: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        donutView = DonutView(frame: self.view.frame)
        view.addSubview(donutView)

        let animationDuration = 1.0
        let (hour, minute, second) = getTimeNum()
        donutView.animateCircle(duration: animationDuration, redRatio: hour / 24, greenRatio: minute / 60, blueRatio: second / 60)

        // アニメーションが終わったらスタート
        Timer.scheduledTimer(timeInterval: animationDuration, target: self, selector: #selector(start), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        super.viewWillDisappear(animated)

        if (clockTimer != nil) && !clockTimer.isValid {
            start()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)

        if let workingTimer = clockTimer {
            workingTimer.invalidate()
        }
    }

    @objc private func start() {
        print("start")
        clockTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }

    @objc private func updateClock() {
        let (hour, minute, second) = getTimeNum()
        donutView.drawDonut(redRatio: hour / 24, greenRatio: minute / 60, blueRatio: second / 60)
        drawDigitalClock()
    }

    private func drawDigitalClock() {
        let now = Date()
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .medium
        let str = df.string(from: now)
//        print(str)
        digitalClock.text = str
    }

    private func getTimeNum() -> (CGFloat, CGFloat, CGFloat) {
        let now = Date()
        let calendar = Calendar.current
        let hour = CGFloat(calendar.component(.hour, from: now))
        let minute = CGFloat(calendar.component(.minute, from: now))
        let second = CGFloat(calendar.component(.second, from: now))
        let nanosecond = CGFloat(calendar.component(.nanosecond, from: now))
        print(hour, minute, second, nanosecond)
        return (hour, minute, second + nanosecond / 1000 / 1000 / 1000)
    }
}
