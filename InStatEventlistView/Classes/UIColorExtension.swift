//
//  UIColorExtension.swift
//  Scout
//
//  Created by Beslan Tularov on 16.10.17.
//  Copyright © 2017 InStat. All rights reserved.
//

import UIKit.UIColor

extension UIColor {

    /// Основной цвет приложения
    static var baseColor: UIColor {
        return UIColor(red: 1.00, green: 0.51, blue: 0.00, alpha: 1.0)
    }

    enum NavigationBar {

        static var bar: UIColor {
            return UIColor(red: 1.00, green: 0.51, blue: 0.00, alpha: 1.0)
        }

        static var text: UIColor {
            return .white
        }
    }

    enum TabBar {

        static var bar: UIColor {
            return UIColor(red: 1.00, green: 0.51, blue: 0.00, alpha: 1.0)
        }

        static var text: UIColor {
            return .white
        }
    }
}

extension UIColor {
    enum Parameters {
        static var Clickable: UIColor {
            return UIColor(red: 0, green: 102 / 255, blue: 1, alpha: 1)
        }
    }
}

extension UIColor {
    
    enum BlackTheme {
        
        static var navigationColor: UIColor {
            return UIColor(red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 1)
        }

        static var mainBackground: UIColor {
            return UIColor(red: 33 / 255, green: 33 / 255, blue: 33 / 255, alpha: 1)
        }

        static var averageColor: UIColor {
            return UIColor(red: 232 / 255, green: 244 / 255, blue: 230 / 255, alpha: 1)
        }

        static var episodeCellLabelColor: UIColor {
            return UIColor(red: 232 / 255, green: 232 / 255, blue: 232 / 255, alpha: 1)
        }
        
        static var separatorColor: UIColor {
            return UIColor(red: 99 / 255, green: 98 / 255, blue: 98 / 255, alpha: 1)
        }
        
        static var searchLightGrayColor: UIColor {
            return UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)
        }
        
        static var headerCellBackgroundColor: UIColor {
            return UIColor(red: 0.91, green: 0.96, blue: 0.9, alpha: 1.00)
        }
        
        static var darkHeaderCellBackgroundColor: UIColor {
            return UIColor(red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 0.9)
        }
        
        static var headerViewBackgroundColor: UIColor {
            return UIColor(red: 242 / 255, green: 242 / 255, blue: 242 / 255, alpha: 1)
        }
        
        static var matchCardBackgroundColor: UIColor {
            return UIColor(red:204/255.0, green:204/255.0, blue:204/255.0, alpha: 1)
        }
    }
}
