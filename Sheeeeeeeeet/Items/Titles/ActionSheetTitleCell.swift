//
//  ActionSheetTitleCell.swift
//  Sheeeeeeeeet
//
//  Created by Daniel Saidi on 2019-01-10.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

open class ActionSheetTitleCell: ActionSheetItemCell {
    
    open override func refresh() {
        super.refresh()
        textLabel?.textAlignment = .center
    }
}
