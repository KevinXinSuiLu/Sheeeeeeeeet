//
//  CollectionItem.swift
//  Sheeeeeeeeet
//
//  Created by Daniel Saidi on 2019-09-17.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

/**
 Collection items can be used to present item collections of
 a certain item type, e.g. in a collection view.
 
 `IMPORTANT` Note that action sheets that contain items that
 are based on `CollectionItem` must do some tweaks to listen
 for tap events within its `ActionSheetCollectionItem`. This
 is because a `CollectionItem` has no reference to the sheet.
 Have a look at the demo app for an example.
 */
open class CollectionItem: MenuItem {
    
    
    // MARK: - Initialization
    
    public init(
        itemType: CollectionItemType.Type,
        itemCount: Int,
        itemSetupAction: @escaping ItemAction,
        itemSelectionAction: @escaping ItemAction) {
        self.itemType = itemType
        self.itemCount = itemCount
        self.itemSetupAction = itemSetupAction
        self.itemSelectionAction = itemSelectionAction
        super.init(title: "", tapBehavior: .none)
    }
    
    
    // MARK: - Typealiases
    
    public typealias ItemAction = (_ item: CollectionItemType, _ index: Int) -> Void
    
    
    // MARK: - Properties
    
    public let itemType: CollectionItemType.Type
    public let itemCount: Int
    public var itemSelectionAction: ItemAction
    public let itemSetupAction: ItemAction
    

    // MARK: - ActionSheet
    
    /**
     When resolving an action sheet cell for this collection
     item, `CollectionItemType` must be a `UICollectionView`
     cell, and must have a `.xib` file with the same name as
     the class in the same bundle.
     */
    open override func actionSheetCell(for tableView: UITableView) -> ActionSheetItemCell {
        let className = String(describing: type(of: self))
        tableView.register(ActionSheetCollectionItemCell.self, forCellReuseIdentifier: className)
        let cell = tableView.dequeueReusableCell(withIdentifier: className)
        guard let typedCell = cell as? ActionSheetCollectionItemCell else { fatalError("CollectionItem.actionSheetCell(for:) has failed to register ActionSheetCollectionItemCell with the target table view.") }
        let nib = UINib(nibName: String(describing: itemType), bundle: nil)
        let handler = ActionSheetCollectionItemCellHandler(item: self)
        typedCell.setup(withNib: nib, handler: handler)
        return typedCell
    }
    
    open override var actionSheetCellHeight: Double {
        Double(itemType.preferredSize.height)
    }
}


/**
 This protocol must be implemented by any item that is to be
 used together with an `CollectionItem` and presented in the
 collection, regardless of what that collection is.
 */
public protocol CollectionItemType {
    
    static var preferredSize: CGSize { get }
    static var leftInset: CGFloat { get }
    static var rightInset: CGFloat { get }
    static var topInset: CGFloat { get }
    static var bottomInset: CGFloat { get }
    static var itemSpacing: CGFloat { get }
}
