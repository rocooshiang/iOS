

import UIKit

let myTextView = UITextView()

let descAttributes: [String : Any] = [
  NSFontAttributeName: UIFont.systemFont(ofSize: 16),
  NSForegroundColorAttributeName: UIColor.black
]

// 這一段是文字是 link，在這邊設定顏色是沒有用的
let mailAttributes: [String : Any] = [
  NSFontAttributeName: UIFont.systemFont(ofSize: 16)
]

let desc = NSMutableAttributedString(string: "If you have further questions, please contact us at", attributes: descAttributes)

let mail = NSMutableAttributedString(string: " rocoo@gmail.com", attributes: mailAttributes)

// 設定 mail 文字所觸發的 link 事件
mail.addAttribute(NSLinkAttributeName, value: "mailto:rocoo@gmail.com", range: NSRange(location: 0, length: mail.length))


desc.append(mail)


// 使整段文字至中
let paragraph = NSMutableParagraphStyle()
paragraph.alignment = .center
let attributes: [String : Any] = [NSParagraphStyleAttributeName: paragraph]
desc.addAttributes(attributes, range: NSRange(location: 0, length: desc.length))

// link 的顏色要在 textView 這邊設定
myTextView.linkTextAttributes = [NSForegroundColorAttributeName: UIColor.green]


myTextView.attributedText = desc








