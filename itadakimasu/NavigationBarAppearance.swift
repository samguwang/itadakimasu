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
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "futura-medium", size: 24)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        navBar.translucent = false
        navBar.barStyle = UIBarStyle.Black
        navBar.tintColor = UIColor.whiteColor()

        
        //Remove hairline pixel seperating navbar and background
        UINavigationBar.appearance().setBackgroundImage(
            UIImage(),
            forBarPosition: .Any,
            barMetrics: .Default)
        
        UINavigationBar.appearance().shadowImage = UIImage()
    

        
        
    }
    
    
}