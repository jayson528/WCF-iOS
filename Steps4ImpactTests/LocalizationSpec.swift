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

import Quick
import Nimble
@testable import Steps4Impact

class LocalizationSpec: QuickSpec {
  override func spec() {
    describe("Localization") {
      var englishLocalization: [String: String]!
      var otherLocalizations: [[String: String]?]!
      let localizations = ["hi"]

      beforeEach {
        let englishFile = Bundle.main.url(
          forResource: "Localizable",
          withExtension: "strings",
          subdirectory: nil,
          localization: "en")!
        englishLocalization = NSDictionary(
          contentsOf: englishFile) as? [String: String]
        otherLocalizations = localizations
          .map { Bundle.main.url(
            forResource: "Localizable",
            withExtension: "strings",
            subdirectory: nil,
            localization: $0)! }
          .map { NSDictionary(contentsOf: $0) as? [String: String] }
      }

      it("should be able to parse localization file") {
        expect(englishLocalization).toNot(beNil())
      }

      it("should have the same keys for all localizations") {
        for localization in otherLocalizations {
          expect(localization?.keys).to(equal(englishLocalization.keys))
        }
      }
    }
  }
}
