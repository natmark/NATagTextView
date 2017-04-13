//
//  NATagTextView.swift
//  NATagTextView
//
//  Created by AtsuyaSato on 2017/04/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import UIKit

public enum NATagApprovalOption {
    case lowerCase
    case upperCase
    case number
    case hiragana
    case katakana
    case kanji

    public var regStr: String {
        switch self {
        case .lowerCase: return "a-z"
        case .upperCase: return "A-Z"
        case .number: return "0-9"
        case .hiragana: return "ぁ-ん"
        case .katakana: return "ァ-ヶ"
        case .kanji: return "一-龠"
        }
    }
}

public protocol NATagTextViewDelegate : UITextViewDelegate {
    func tagTextView(_ view: NATagTextView, didUpdateTags tags: [String])
}
public extension NATagTextViewDelegate {
    func tagTextView(_ view: NATagTextView, didUpdateTags tags: [String]){}
}

public class NATagTextView: UITextView {

    public var tagColor = UIColor.blue
    public var symbol = "#"
    public var approvalOption : [NATagApprovalOption] = [.lowerCase , .upperCase , .number]
    public var tags = Set<String>()
    
    private var escapedTextColor : UIColor?
    public override var textColor: UIColor?{
        didSet{
            escapedTextColor = textColor
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged(notification:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged(notification:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func textChanged(notification:NSNotification?) -> (Void) {
        let range = self.selectedTextRange

        if (self.markedTextRange == nil) {
            self.attributedText = convertTagStr(from: self.attributedText.string)
        }

        let position = self.position(from: (range?.start)!, offset:0)!
        self.selectedTextRange = self.textRange(from: position, to: position)
    }

    /// convert simple text to tag attributed string
    /// - parameter from: simple text
    /// - returns: tagAttributedString (NSAttributedString)
    private func convertTagStr(from simpleText:String) -> NSAttributedString {
        let attrStr = NSMutableAttributedString(string: simpleText)
        attrStr.addAttributes([NSForegroundColorAttributeName:escapedTextColor!,NSFontAttributeName:UIFont.systemFont(ofSize: (self.font?.pointSize)!)], range: NSMakeRange(0, attrStr.length))
        do {
            let approvedStr = approvalOption.map{ $0.regStr }.reduce("",+)

            let regexp = try NSRegularExpression(pattern: "(\(symbol)[\(approvedStr)]+?\\s)", options:NSRegularExpression.Options(rawValue: 0))
            let matches = regexp.matches(in: attrStr.string, options:NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, attrStr.length))

            tags.removeAll()

            for match in matches {
                var range = match.rangeAt(1)
                // Remove last whitespace
                range.length = range.length - 1
                attrStr.addAttributes([NSForegroundColorAttributeName:tagColor], range: range)

                // Remove symbol mark
                range.location = range.location + 1
                tags.insert(attrStr.string.substring(with: range))
            }
            (delegate as! NATagTextViewDelegate).tagTextView(self, didUpdateTags: Array(tags))
        } catch {
        }
        return attrStr
    }
}
