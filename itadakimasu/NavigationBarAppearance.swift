//
//  NavigationBarAppearance.swift
//  itadakimasu
//
//  Created by Sam Wang on 9/2/15.
//  Copyright (c) 2015 eightAM. All rights reserved.
//

import UIKit

class NavigationBarAppearance: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //format navigation controller across all views
        var navBar = self.navigationBar
        navBar.barTintColor = UIColor(red: 235/255, green: 116/255, blue: 57/255, alpha: 1)
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "futura-medium", size: 22)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        navBar.translucent = false
        UIBarButtonItem.appearance().setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 12)!], forState: UIControlState.Normal)
        navBar.barStyle = UIBarStyle.Black

        
        
    }
    
    
}