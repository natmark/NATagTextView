//
//  String.swift
//  NATagTextView
//
//  Created by AtsuyaSato on 2017/04/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

extension String{
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from ..< to
    }
    func substring(with range: NSRange) -> String {
        return substring(with: self.range(from: range)!)
    }
}
