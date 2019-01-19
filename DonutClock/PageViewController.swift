//
//  PageViewController.swift
//  DonutClock
//
//  Created by motoki-shun on 2019/01/18.
//  Copyright © 2019 motoki-shun. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
//class PageViewController: UIViewController, UIPageViewControllerDelegate {

//    var pageViewController: UIPageViewController?
//    var pageData: [UIViewController.Type] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        pageData = [ClockViewController.self, StopWatchViewController.self]
//        let startingViewController: DataViewController = self.viewControllerAtIndex(0, storyboard: self.storyboard!)!
//        let viewControllers = [startingViewController]
//        self.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })

        self.dataSource = self
        let first = storyboard?.instantiateViewController(withIdentifier: "ClockViewController") as! ClockViewController
//        self.setViewControllers([getFirst()], direction: .forward, animated: false, completion: nil)
        self.setViewControllers([first], direction: .forward, animated: false, completion: nil)
    }

    func getFirst() -> ClockViewController {
        return storyboard!.instantiateViewController(withIdentifier: "ClockViewController") as! ClockViewController
    }

    func getSecond() -> StopWatchViewController {
        return storyboard!.instantiateViewController(withIdentifier: "StopWatchViewController") as! StopWatchViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PageViewController : UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

//        if viewController.isKind(of: ClockViewController.self) {
//            return getSecond()
//        } else if viewController.isKind(of: StopWatchViewController.self) {
//            return getFirst()
//        } else {
//            return nil
//        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

//        if viewController.isKind(of: ClockViewController.self) {
//            return getSecond()
//        } else {
//            return nil
//        }
        return nil
    }
}
