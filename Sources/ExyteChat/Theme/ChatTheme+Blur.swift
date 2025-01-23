//
//  ChatTheme+Blur.swift
//  Chat
//
//  Created by Brandon Toms on 1/22/25.
//

import SwiftUI

// TODO: Only support blur below (behind the input view). If the user wants to drive the blur above, they should place the ChatView under the element and set a custom footer.
public enum BlurEffectStyle {
    // TODO: Get this value dynamically...
    static let MinInputHeight:CGFloat = 72
    case underInputOnly(material:Material, headerSize:CGFloat = 0, verticalContentOffset:CGFloat = 0)
    
    internal var material:Material {
        switch self {
        case .underInputOnly(let material, _, _):
            return material
        }
    }
    
    internal var paddingTop:CGFloat {
        switch self {
        case .underInputOnly:
            return 0
        }
    }
    
    internal var paddingBottom:CGFloat {
        switch self {
        case .underInputOnly(_, _, let verticalContentOffset):
            return -BlurEffectStyle.MinInputHeight - verticalContentOffset
        }
    }
    
    internal var headerHeight:CGFloat {
        switch self {
        case .underInputOnly(_, let headerHeight, _):
            return headerHeight
        }
    }
    
    internal var footerHeight:CGFloat {
        switch self {
        case .underInputOnly:
            return BlurEffectStyle.MinInputHeight
        }
    }
}
