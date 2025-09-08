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

// @unknown: 멤버가 추가될 가능성이 있는 열거형, unfrozen Enum (라이브러리, 프레임워크)
enum Onboarding: Int {
    case first = 0
    case second
    case third
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
        
        let a = NSTextAlignment.center
        
        switch a {
        case .left:
            <#code#>
        case .center:
            <#code#>
        case .right:
            <#code#>
        case .justified:
            <#code#>
        case .natural:
            <#code#>
        @unknown default:
            <#fatalError()#>
        }
        
        getRandom()
        
        list = [FirstViewController(), SecondViewController(), ThirdViewController()]
        
        view.backgroundColor = .systemBlue
        
        delegate = self
        dataSource = self
        
        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
    
    @discardableResult
    func getRandom() -> Int {
        let random = Int.random(in: 1...100)
        print(random)
        return random
    }
    


}


extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else {
            return 0
        }
        return index
    }
    
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
