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
import Foundation

class JourneyCardView: StylizedCardView {
  private var lblTitle: UILabel = UILabel(typography: .title)
  private var imgMap: UIImageView = UIImageView()
  private var lblMilestonsCompleted: UILabel =
      UILabel(typography: .smallRegular)
  private var btnDetails: UIButton = UIButton(type: .system)

  internal func layout() {
    addSubviews([lblTitle, imgMap, lblMilestonsCompleted, btnDetails])

    lblTitle.text = Strings.JourneyCard.title
    lblTitle.snp.makeConstraints {
      $0.left.equalToSuperview().inset(Style.Padding.p16)
      $0.top.equalToSuperview().inset(Style.Padding.p16)
    }

    imgMap.snp.makeConstraints {
      $0.left.right.equalToSuperview().inset(Style.Padding.p16)
      $0.top.equalTo(lblTitle.snp.bottom).offset(Style.Padding.p24)
    }

    lblMilestonsCompleted.text = Strings.JourneyCard.milestonesCompleted
    lblMilestonsCompleted.snp.makeConstraints {
      $0.top.equalTo(imgMap.snp.bottom).offset(Style.Padding.p24)
      $0.left.right.equalToSuperview().inset(Style.Padding.p16)
    }

    btnDetails.setTitle(Strings.JourneyCard.viewMilestoneDetails, for: .normal)
    btnDetails.snp.makeConstraints {
      $0.height.equalTo(Style.Size.s24)
      $0.left.right.equalToSuperview()
      $0.top.equalTo(lblMilestonsCompleted.snp.bottom).offset(Style.Padding.p40)
      $0.bottom.equalToSuperview()
    }
  }
}

extension JourneyCardView: CardView {
  static let identifier: String = "JourneyCard"

  func render(_ context: Any) {
    guard let data = context as? JourneyCard else { return }

    _ = data
  }
}

struct JourneyCard: Card {
  let renderer: String = JourneyCardView.identifier
}
