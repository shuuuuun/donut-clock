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
        view.addSubview(donutView)

        let animationDuration = 1.0
        donutView.animateCircle(duration: animationDuration, redRatio: 1, greenRatio: 1, blueRatio: 1)

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
        if clockTimer == nil {
            start()
        }
        else {
            stop()
        }
    }

    private func start() {
        print("start")
        startDateTime = Date()
        clockTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
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
        let second = CGFloat(elapsedTime) - minute * 60
        print(elapsedTime, hour, minute, second)
        donutView.drawDonut(redRatio: hour / 24, greenRatio: minute / 60, blueRatio: second / 60)
        digitalClock.text = String(format: "%02d", Int(hour)) + ":" + String(format: "%02d", Int(minute)) + ":" + String(format: "%02d", Int(second))
    }
}

