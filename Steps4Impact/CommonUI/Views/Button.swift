/**
 * Copyright © 2019 Aga Khan Foundation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

import UIKit
import SnapKit

class Button: UIButton {
  enum ButtonStyle {
    case primary
    case secondary
    case disabled
    case destructive
    case plain
    case link

    var titleColor: UIColor {
      switch self {
      case .primary, .disabled, .destructive:
        return Style.Colors.white
      case .secondary:
        return Style.Colors.FoundationGreen
      case .plain:
        return Style.Colors.blue
      case .link:
        return Style.Colors.grey
      }
    }

    var backgroundColor: UIColor {
      switch self {
      case .primary:
        return Style.Colors.FoundationGreen
      case .secondary:
        return Style.Colors.white
      case .disabled:
        return Style.Colors.Silver
      case .destructive:
        return Style.Colors.Destructive
      case .plain, .link:
        return .clear
      }
    }
  }

  var style: ButtonStyle = .primary {
    didSet {
      updateFont()
      updateColors()
    }
  }

  convenience init(style: ButtonStyle) {
    self.init()
    self.style = style
    commonInit()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  var title: String? {
    didSet {
      switch self.style {
      case .link:
        if let value = title {
          setAttributedTitle(NSAttributedString(string: value, attributes: [
            .underlineStyle: 1.0,
            .font: Style.Typography.footnote.font!,
            .foregroundColor: Style.Colors.grey
          ]), for: .normal)
        } else {
          setTitle(nil, for: .normal)
        }
      default:
        setTitle(title, for: .normal)
      }
    }
  }

  private func updateFont() {
    var font: UIFont?
    switch self.style {
    case .link:
      font = Style.Typography.footnote.font
    case .plain:
      font = Style.Typography.bodyRegular.font
    default:
      font = Style.Typography.bodyBold.font
    }
    titleLabel?.font = font!
  }

  func commonInit() {
    updateColors()

    layer.cornerRadius = 4
    layer.masksToBounds = true

    setTitle(currentTitle, for: .normal)
    updateFont()

    switch self.style {
    case .secondary:
      layer.borderWidth = 2
      layer.borderColor = style.titleColor.cgColor
      fallthrough
    default:
      snp.makeConstraints { $0.height.equalTo(Style.Size.s48) }

      contentEdgeInsets = UIEdgeInsets(
        top: Style.Size.s16,
        left: Style.Size.s16,
        bottom: Style.Size.s16,
        right: Style.Size.s16)
    }

    // this is to center the title in the actual button
    // descender is the part under the font for lowercase and is a negative number
    titleEdgeInsets = UIEdgeInsets(top: -titleLabel!.font.descender / 2, left: 0, bottom: 0, right: 0)
  }

  private func updateColors() {
    setBackgroundImage(UIImage(color: style.backgroundColor), for: .normal)
    setBackgroundImage(UIImage(color: style.backgroundColor.average(with: .black, scale: 0.1)), for: .highlighted)
    setBackgroundImage(UIImage(color: style.backgroundColor.average(with: .black, scale: 0.1)), for: .selected)
    setTitleColor(style.titleColor, for: .normal)
  }
}
