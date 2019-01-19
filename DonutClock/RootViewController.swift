//
//  RootViewController.swift
//  DonutClock
//
//  Created by motoki-shun on 2019/01/19.
//  Copyright © 2019 motoki-shun. All rights reserved.
//

import UIKit

//class RootViewController: UIViewController, UIPageViewControllerDelegate {
//class RootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
//
//    var pageViewController: UIPageViewController?
////    var pageViewController:UIPageViewController!
//    var viewControllersArray:Array<UIViewController> = []
//    let colors:Array<UIColor> = [UIColor.red, UIColor.gray, UIColor.blue]
//    var pageControl: UIPageControl!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        // Configure the page view controller and add it as a child view controller.
//        self.pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
//        self.pageViewController!.delegate = self
//
////        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
//        let startingViewController: ClockViewController = storyboard?.instantiateViewController(withIdentifier: "ClockViewController") as! ClockViewController
//        let viewControllers = [startingViewController]
//        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
//
////        self.pageViewController!.dataSource = self.modelController
//        self.pageViewController!.dataSource = self
//        self.pageViewController!.delegate = self
//
//        self.addChild(self.pageViewController!)
//        self.view.addSubview(self.pageViewController!.view)
//
//        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
////        var pageViewRect = self.view.bounds
////        if UIDevice.current.userInterfaceIdiom == .pad {
////            pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
////        }
////        self.pageViewController!.view.frame = pageViewRect
//
////        self.pageViewController!.didMove(toParent: self)
//    }
//
////    var modelController: ModelController {
////        // Return the model controller object, creating it if necessary.
////        // In more complex implementations, the model controller may be passed to the view controller.
////        if _modelController == nil {
////            _modelController = ModelController()
////        }
////        return _modelController!
////    }
//
////    var _modelController: ModelController? = nil
//
//    // MARK: - UIPageViewController delegate methods
//
////    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
////        if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
////            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewController.SpineLocation.mid' in landscape orientation sets the doubleSided property to true, so set it to false here.
////            let currentViewController = self.pageViewController!.viewControllers![0]
////            let viewControllers = [currentViewController]
////            self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
////
////            self.pageViewController!.isDoubleSided = false
////            return .min
////        }
////
////        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
//////        let currentViewController = self.pageViewController!.viewControllers![0] as! ClockViewController
////        var viewControllers: [UIViewController]
////
//////        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
//////        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
//////            let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController)
//////            viewControllers = [currentViewController, nextViewController!]
//////        } else {
//////            let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBefore: currentViewController)
//////            viewControllers = [previousViewController!, currentViewController]
//////        }
////        let currentViewController = storyboard?.instantiateViewController(withIdentifier: "ClockViewController") as! ClockViewController
////        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "StopWatchViewController") as! StopWatchViewController
////        viewControllers = [currentViewController, nextViewController]
////        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
////
////        return .mid
////    }
//
//}

class RootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pageViewController: UIPageViewController!
    var viewControllersArray: Array<UIViewController> = []
//    let colors: Array<UIColor> = [UIColor.red, UIColor.gray, UIColor.blue]
    var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard: UIStoryboard = self.storyboard!

        //        self.view.backgroundColor = .white
        let clockViewController = storyboard.instantiateViewController(withIdentifier: "ClockViewController") as! ClockViewController
        let stopwatchViewController = storyboard.instantiateViewController(withIdentifier: "StopWatchViewController") as! StopWatchViewController
//        print(clockViewController, stopwatchViewController)
        viewControllersArray = [clockViewController, stopwatchViewController]

        //PageViewControllerに表示するViewControllerを生成
        //電子書籍アプリなど、大量のViewControllerを使う場合は一気にインスタンスを作らず、逐次生成する方が良いらしいです
        for index in 0 ..< viewControllersArray.count {
            let viewController = viewControllersArray[index]
            viewController.view.tag = index
//            let viewController = UIViewController()
//            viewController.view.backgroundColor = colors[index]
//            viewController.view.tag = index
//            let label = UILabel()
//            label.text = "page:" + index.description
//            label.textColor = .white
//            label.font = UIFont.boldSystemFont(ofSize: 40)
//            label.frame = self.view.frame
//            label.textAlignment = .center
//            viewController.view.addSubview(label)
//            viewControllersArray.append(viewController)
        }

        //PageViewControllerの生成
        pageViewController = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll,
                                                  navigationOrientation: UIPageViewController.NavigationOrientation.horizontal,
                                                  options: nil)
        //DelegateとDataSouceの設定
        pageViewController.dataSource = self
        pageViewController.delegate = self

        //はじめに生成するページを設定
        pageViewController.setViewControllers([viewControllersArray.first!], direction: .forward, animated: true, completion: nil)
        pageViewController.view.frame = self.view.frame
        self.view.addSubview(pageViewController.view!)


        //PageControlの生成
        pageControl = UIPageControl(frame: CGRect(x:0, y:self.view.frame.height - 100, width:self.view.frame.width, height:50))
//        pageControl.backgroundColor = .orange

        // PageControlするページ数を設定する.
        pageControl.numberOfPages = viewControllersArray.count

        // 現在ページを設定する.
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        self.view.addSubview(pageControl)
    }

    //DataSourceのメソッド
    //指定されたViewControllerの前にViewControllerを返す
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = viewController.view.tag
        pageControl.currentPage = index
        if index == viewControllersArray.count - 1{
            return nil
        }
        index = index + 1
        return viewControllersArray[index]
    }

    //DataSourceのメソッド
    //指定されたViewControllerの前にViewControllerを返す
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = viewController.view.tag
        pageControl.currentPage = index
        index = index - 1
        if index < 0{
            return nil
        }
        return viewControllersArray[index]
    }

    //Viewが変更されると呼ばれる
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {
        print("moved")
    }
}
