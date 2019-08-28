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

class TeamRankCardView: StylizedCardView {
  private var lblTeamName: UILabel = UILabel(typography: .title)
  private var lblTeamLead: UILabel = UILabel(typography: .subtitleBold,
                                             color: Style.Colors.FoundationGrey)
  private var lblRankings: UILabel = UILabel(typography: .bodyBold)
  private var tblRankings: UITableView = UITableView(frame: .zero)
  private var btnFullList: UIButton = UIButton(type: .system)

  internal func layout() {
    addSubviews([lblTeamName, lblTeamLead, lblRankings, tblRankings, btnFullList])

    lblTeamName.snp.makeConstraints {
      $0.left.equalToSuperview().inset(Style.Padding.p16)
      $0.top.equalToSuperview().inset(Style.Padding.p16)
    }

    let lblLead: UILabel = UILabel(typography: .subtitleBold,
                                   color: Style.Colors.FoundationGrey)

    addSubview(lblLead)
    lblLead.text = Strings.TeamRankCard.teamLead
    lblLead.snp.makeConstraints {
      $0.left.equalToSuperview().inset(Style.Padding.p16)
      $0.top.equalTo(lblTeamName.snp.bottom)
    }

    lblTeamLead.snp.makeConstraints {
      $0.left.equalTo(lblLead.snp.right)
      $0.top.equalTo(lblTeamName.snp.bottom)
    }

    // TODO(compnerd) add member images

    lblRankings.text = Strings.TeamRankCard.teamMemberRanking
    lblRankings.snp.makeConstraints {
      $0.left.equalToSuperview().inset(Style.Padding.p16)
      $0.top.equalTo(lblTeamLead.snp.bottom)
    }

    tblRankings.snp.makeConstraints {
      $0.left.right.equalToSuperview().inset(Style.Padding.p16)
      $0.top.equalTo(lblRankings.snp.bottom).offset(Style.Padding.p8)
    }

    btnFullList.setTitle(Strings.TeamRankCard.viewFullList, for: .normal)
    btnFullList.snp.makeConstraints {
      $0.left.right.equalToSuperview().inset(Style.Padding.p16)
      $0.top.equalTo(tblRankings.snp.bottom)
      $0.bottom.equalToSuperview()
      $0.height.equalTo(Style.Size.s24)
    }
  }
}

extension TeamRankCardView: CardView {
  static let identifier: String = "TeamRankCard"

  func render(_ context: Any) {
    guard let data = context as? TeamRankCard else { return }

    lblTeamName.text = data.name
    lblTeamLead.text = data.lead

    _ = data
  }
}

struct TeamRankCard: Card {
  let renderer: String = TeamRankCardView.identifier

  // TODO(compnerd) provide a constructor to populate this
  let name: String = "Global Citizens 2018"
  let lead: String = "Sarah Bhamani"
}
