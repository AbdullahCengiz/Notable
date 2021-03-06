//
//  TextField.swift
//  Notable
//
//  Created by abdullah cengiz on 02/01/15.
//  Copyright (c) 2015 Trivato. All rights reserved.
//

import Foundation

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5);

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }

    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }

    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }

    private func newBounds(bounds: CGRect) -> CGRect {

        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= (padding.top * 2) - padding.bottom
        newBounds.size.width -= (padding.left * 2) - padding.right
        return newBounds
        
    }
}
