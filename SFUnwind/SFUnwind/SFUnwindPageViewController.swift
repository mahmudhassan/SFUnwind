//
// SFUnwindPageViewController.swift - Primary View Controller for the SFUnwind application
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Adam Badke
// Contributing Programmers: David Magaril
// Known issues: None
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit

class SFUnwindPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // Array of feature screen pages
    lazy var theViewControllers: [UIViewController] = {
        return [self.VCInstance(name: "SquareBreathingViewController"),
                self.VCInstance(name: "GroundingExerciseViewController"),
                self.VCInstance(name: "PositiveAffirmationViewController"),
                self.VCInstance(name: "PanicAlertViewController")]
    }()
    
    // UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate protocol functions:
    //*******************************************************************************************************
    // Load the main storyboard:
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    // Called every time the view loads:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstVC = theViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // Move to previous page: Load the previous view controller
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        guard let viewControllerIndex = theViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        // Infinite scroll: Loops from the first page to the last
        guard previousIndex >= 0 else {
            return theViewControllers.last
        }
        
        // Catch out of bounds indexes, return nil to prevent crashes
        guard theViewControllers.count > previousIndex else {
            return nil
        }
        
        // Return the previous view controller
        return theViewControllers[previousIndex]
        
    }
    
    // Move to next page: Load the next view controller
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        guard let viewControllerIndex = theViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        
        // Infinite scroll: Loops from the first page to the last
        guard nextIndex < theViewControllers.count else {
            return theViewControllers.first
        }
        
        // Catch out of bounds indexes, return nil to prevent crashes
        guard theViewControllers.count > nextIndex else {
            return nil
        }
        
        // Return the next view controller
        return theViewControllers[nextIndex]    }
    
    
    // Controls page view Dots: PLACEHOLDER: To be updated with menu graphics
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return theViewControllers.count
    }
    
    // Controls page view Dots: PLACEHOLDER: To be updated with menu graphics
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = theViewControllers.index(of: firstViewController) else {
            return 0
        }
        return firstViewControllerIndex
    }

} // End SFUnwindPageViewController
