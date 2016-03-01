//
// DTSpaceRichLabel.swift
//
// Copyright (c) 2016 https://github.com/Dante-Edge/DTSpacingLabel
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

@IBDesignable
class DTSpacingLabel: UILabel {
    
    @IBInspectable
    var kern:Float = 0.0 {
        didSet {
            self.awakeFromNib()
        }
    }
    
    @IBInspectable
    var textLineSpacing:CGFloat = 0.0 {
        didSet {
            self.awakeFromNib()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let attributedText = NSMutableAttributedString(attributedString: super.attributedText!)
        
        attributedText.beginEditing()
        attributedText.addAttributes([NSKernAttributeName: self.kern], range: NSMakeRange(0, attributedText.length))
        attributedText.endEditing()
        
        
        var range : NSRange = NSMakeRange(0, attributedText.length)
        let attributeDict = attributedText.attributesAtIndex(0, effectiveRange: &range)
        
        
        var paragraphStyle: NSMutableParagraphStyle!
        
        if let originalParagraphStyle = attributeDict[NSParagraphStyleAttributeName] {
            paragraphStyle = (originalParagraphStyle as! NSParagraphStyle).mutableCopy() as! NSMutableParagraphStyle
        }
        else {
            paragraphStyle = NSMutableParagraphStyle()
        }
        
        paragraphStyle.lineSpacing = self.textLineSpacing
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        
        super.attributedText = attributedText
    }
}