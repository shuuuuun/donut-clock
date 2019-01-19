//
//  RootViewController.swift
//  DonutClock
//
//  Created by motoki-shun on 2019/01/19.
//  Copyright © 2019 motoki-shun. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pageViewController: UIPageViewController!
    var viewControllersArray: Array<UIViewController> = []
    var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard: UIStoryboard = self.storyboard!
        let pageControlFrame = CGRect(x: 0, y: self.view.frame.height - 70, width: self.view.frame.width, height: 50)

        let clockViewController = storyboard.instantiateViewController(withIdentifier: "ClockViewController") as! ClockViewController
        let stopwatchViewController = storyboard.instantiateViewController(withIdentifier: "StopWatchViewController") as! StopWatchViewController
        viewControllersArray = [clockViewController, stopwatchViewController]

        for index in 0 ..< viewControllersArray.count {
            let viewController = viewControllersArray[index]
            viewController.view.tag = index
        }

        pageViewController = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll,
                                                  navigationOrientation: UIPageViewController.NavigationOrientation.horizontal,
                                                  options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([viewControllersArray.first!], direction: .forward, animated: true, completion: nil)
        pageViewController.view.frame = self.view.frame
        self.view.addSubview(pageViewController.view!)

        pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = viewControllersArray.count
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        self.view.addSubview(pageControl)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = viewController.view.tag
        pageControl.currentPage = index
        if index == viewControllersArray.count - 1 {
            return nil
        }
        index = index + 1
        return viewControllersArray[index]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = viewController.view.tag
        pageControl.currentPage = index
        index = index - 1
        if index < 0 {
            return nil
        }
        return viewControllersArray[index]
    }

    //Viewが変更されると呼ばれる
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {
        print("moved")
    }
}
