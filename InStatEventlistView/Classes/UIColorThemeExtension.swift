//
//  UIColorThemeExtension.swift
//  Basketball
//
//  Created by VladSachivko on 12/11/19.
//  Copyright © 2019 InStat. All rights reserved.
//

import UIKit

extension UIColor {

    // MARK: - Navigation Bar
    
    static var dtNavigationColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "navigationColor")
        } else {
            return UIColor.NavigationBar.bar
        }
    }

    // MARK: - Main Background

    static var dtMainBackgroundColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "mainBackgroundColor")
        } else {
            return UIColor.white
        }
    }

    // MARK: - DarkText

    static var dtDarkTextColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "darkTextColor")
        } else {
            return UIColor.black
        }
    }

    // MARK: - Average View Color

    static var dtAverageColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "averageColor")
        } else {
            return UIColor.BlackTheme.averageColor
        }
    }

    // MARK: - Cell Value Color

    static var dtCellValueColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "cellValueColor")
        } else {
            return UIColor.black
        }
    }

    // MARK: - Episode Label Color

    static var dtEpisodeCellLabelColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "episodeCellLabelColor")
        } else {
            return UIColor.BlackTheme.episodeCellLabelColor
        }
    }

    // MARK: - Separator Color

    static var dtSeparatorColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "separatorColor")
        } else {
            return UIColor.BlackTheme.separatorColor
        }
    }

    // MARK: - Gray Background

    static var dtGrayBackgroundColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "grayBackgroundColor")
        } else {
            return UIColor.white
        }
    }

    // MARK: - Gray Text Color

    static var dtGrayTextColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "grayTextColor")
        } else {
            return UIColor.black
        }
    }

    // MARK: - Black Background Color

    static var dtBlackBackgroundColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "blackBackgroundColor")
        } else {
            return UIColor.white
        }
    }

    // MARK: - Light Gray Background Color

    static var dtLightGrayBackgroundColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "lightGrayBackgroundColor")
        } else {
            return UIColor.BlackTheme.searchLightGrayColor
        }
    }

    // MARK: - Header Cell Background Color

    static var dtHeaderCellBackgroundColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "headerCellBackgroundColor")
        } else {
            return UIColor.BlackTheme.headerCellBackgroundColor
        }
    }

    // MARK: - Match Card Background Color

    static var dtMatchCardBackgroundColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "matchCardBackgroundColor")
        } else {
            return UIColor.BlackTheme.matchCardBackgroundColor
        }
    }

    // MARK: - Header View Background Color

    static var dtHeaderViewBackgroundColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "headerViewBackgroundColor")
        } else {
            return UIColor.BlackTheme.headerViewBackgroundColor
        }
    }

    // MARK: - Checkmark Color

    static var dtCheckmarkColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "checkMarkColor")
        } else {
            return UIColor.white
        }
    }
    
    // MARK: - Base color of app
    
    static var dtBaseColor: UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor(named: "baseColor")
        } else {
            return .baseColor
        }
    }
}

