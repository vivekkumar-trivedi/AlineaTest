//
//  AlineaThemeManager.swift
//  AlineaTest
//
//  Created by Vivekkumar Trivedi on 21/11/20.
//

import Foundation
import UIKit


public let CONTENT_BG_COLOR = UIColor { (traitCollection) -> UIColor in
    return traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
}

public let CONTENT_COLOR = UIColor { (traitCollection) -> UIColor in
    return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black //TODO: provide correct color for dark theme
}

public let SELECTED_TINT_COLOR = UIColor { (traitCollection) -> UIColor in
    let lightColor = UIColor(red: (72/255), green: (81/255), blue: (203/255), alpha: 1)
    let darkColor = lightColor //TODO: provide correct color for dark theme
    return traitCollection.userInterfaceStyle == .dark ? darkColor : lightColor
}

public let UNSELECTED_TINT_COLOR = UIColor { (traitCollection) -> UIColor in
    return traitCollection.userInterfaceStyle == .dark ? UIColor.gray : UIColor.gray //TODO: provide correct colors
}

public let SEP_COLOR = UIColor { (traitCollection) -> UIColor in
    return traitCollection.userInterfaceStyle == .dark ? UIColor.gray : UIColor.gray //TODO: provide correct color for dark theme
}
