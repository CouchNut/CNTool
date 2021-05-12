//
//  CNRichText.swift
//  CNTool_Example
//
//  Created by Copper on 2021/5/12.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

import Foundation
import UIKit

extension String {
    func cn_allRanges(with subString: String) -> [NSRange] {
        var result: [NSRange] = []
        
        if self.count < subString.count {
            return result
        }
        
        for idx in 0...self.count-subString.count {
            let range = NSRange(location: idx, length: subString.count)
            let temp = NSString(string: self).substring(with: range)
            if temp == subString {
                result.append(range)
            }
        }
        
        return result
    }
}

struct CNProperty {
    var operaString: String
    var location: Int
    
    init() {
        self.operaString = ""
        self.location = 0
    }
}

struct CNAttribute {
    var key: NSAttributedString.Key
    var value: Any
}

class CNRichText: NSObject {
    private var property: CNProperty
    var attributedString: NSMutableAttributedString
    
    init(content: String) {
        self.attributedString = NSMutableAttributedString(string: content)
        self.property = CNProperty()
        super.init()
    }
    
    private func cn_addAttributed(with attribute: CNAttribute) {
        self.attributedString.addAttributes([attribute.key : attribute.value], range: self.cn_operationRange())
    }
    
    /// 如果传入"", 则之后的效果作用到整个文字内容
    func cn_text(_ content: String) -> CNRichText {
        self.property.operaString = content.count == 0 ? self.attributedString.string : content
        return self
    }
    
    /// 富文本效果第几个字符串有效，默认为 0
    @discardableResult
    func cn_location(_ local: Int) -> CNRichText {
        self.property.location = local
        return self
    }
    
    private func cn_operationRange() -> NSRange {
        guard self.property.operaString.count > 0 else {
            return NSRange(location: 0, length: self.attributedString.string.count)
        }
        
        let ranges = self.attributedString.string.cn_allRanges(with: self.property.operaString)
        let index = self.property.location >= ranges.count ? 0 : self.property.location
        return ranges[index]
    }
    
    @discardableResult
    func cn_font(_ font: UIFont) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .font, value: font))
        return self
    }
    
    @discardableResult
    func cn_underlineStyle(_ underlineStyle: NSUnderlineStyle) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .underlineStyle, value: underlineStyle))
        return self
    }
    
    @discardableResult
    func cn_underlineColor(_ color: UIColor) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .underlineColor, value: color))
        return self
    }
    
    @discardableResult
    func cn_textColor(_ color: UIColor) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .foregroundColor, value: color))
        return self
    }
    
    @discardableResult
    func cn_textBackgroundColor(_ color: UIColor) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .backgroundColor, value: color))
        return self
    }
    
    /// 文字填充颜色
    @discardableResult
    func cn_strokeColor(_ color: UIColor) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .strokeColor, value: color))
        return self
    }
    
    /// 负值填充效果，正值中空效果
    @discardableResult
    func cn_strokeWidth(_ width: Float) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .strokeWidth, value: width))
        return self
    }
    
    /// 段落排版格式
    @discardableResult
    func cn_paragraphStyle(_ style: @escaping ()->(NSParagraphStyle)) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .paragraphStyle, value: style()))
        return self
    }
    
    /// 0 表示没有连体字符，1 表示使用默认的连体字符
    @discardableResult
    func cn_ligature(_ ligature: Int) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .ligature, value: ligature))
        return self
    }
    
    /// 传值为 NSNumber（整数）类型
    @discardableResult
    func cn_strikethroughStyle(_ strikethroughStyle: Int) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .strikethroughStyle, value: strikethroughStyle))
        return self
    }
    
    @discardableResult
    func cn_textEffect(_ textEffect: String) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .textEffect, value: textEffect))
        return self
    }
    
    /// 常用于文字图片混排
    @discardableResult
    func cn_attachment(_ attachment: @escaping ()->(NSTextAttachment)) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .attachment, value: attachment()))
        return self
    }
    
    /// 点击后调用浏览器打开指定URL地址
    @discardableResult
    func cn_link(_ link: URL) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .link, value: link))
        return self
    }
    
    /// 下划线偏移量，正值上偏，负值下偏
    @discardableResult
    func cn_baselineOffset(_ baselineOffset: Float) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .baselineOffset, value: baselineOffset))
        return self
    }
    
    @discardableResult
    func cn_strikethroughColor(_ strikethroughColor: UIColor) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .strikethroughColor, value: strikethroughColor))
        return self
    }
    
    /// 设置文字书写方向，从左向右书写或者从右向左书写
    @discardableResult
    func cn_writingDirection(_ writingDirection: NSWritingDirection) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .writingDirection, value: writingDirection))
        return self
    }
    
    /// 设置文本横向拉伸属性，正值横向拉伸文本，负值横向压缩文本
    @discardableResult
    func cn_expansion(_ expansion: Float) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .expansion, value: expansion))
        return self
    }
    
    /// 设置文字排版方向，0 表示横排文本，1 表示竖排文本
    @discardableResult
    func cn_verticalGlyphForm(_ verticalGlyphForm: Int) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .verticalGlyphForm, value: verticalGlyphForm))
        return self
    }
    
    /// 设置字符间距，正值间距加宽，负值间距变窄
    @discardableResult
    func cn_kern(_ kern: Int) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .kern, value: kern))
        return self
    }
    
    /// 设置字形倾斜度，正值右倾，负值左倾
    @discardableResult
    func cn_obliqueness(_ obliqueness: Float) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .obliqueness, value: obliqueness))
        return self
    }
    
    /// 设置阴影属性
    @discardableResult
    func cn_shadow(_ shadow: @escaping ()->(NSShadow)) -> CNRichText {
        self.cn_addAttributed(with: CNAttribute(key: .shadow, value: shadow()))
        return self
    }
}
