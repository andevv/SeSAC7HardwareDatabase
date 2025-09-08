//
//  OnboardingViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by andev on 9/8/25.
//

import UIKit

class FirstViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
    }
    
}

class SecondViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
    }
    
}

class ThirdViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
    }

}

final class OnboardingViewController: UIPageViewController {
    
    var list: [UIViewController] = []
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = [FirstViewController(), SecondViewController(), ThirdViewController()]
        
        delegate = self
        dataSource = self
        
        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
    


}


extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //현재 보고있는 뷰컨 배열의 인덱스
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : list[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        return nextIndex >= list.count ? nil : list[nextIndex]
    }
    
}
