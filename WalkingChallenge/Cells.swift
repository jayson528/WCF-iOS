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

protocol CellContext: Context {
  var cellIdentifier: String { get }
}

protocol ConfigurableCell: class {
  func configure(context: CellContext)
}

typealias ConfigurableTableViewCell = ConfigurableCell & TableViewCell
typealias ConfigurableCollectionViewCell = ConfigurableCell & UICollectionViewCell

protocol ListDataSource {
  var cells: [[CellContext]] { get set }
  func reload(completion: @escaping GenericBlock)
  func configureCells()
  func cell(for indexPath: IndexPath) -> CellContext?
  func numberOfSections() -> Int
  func numberOfItems(in section: Int) -> Int
}

extension ListDataSource {
  func reload(completion: @escaping GenericBlock) {
    configureCells()
    completion()
  }
  
  func numberOfSections() -> Int {
    return cells.count
  }
  
  func numberOfItems(in section: Int) -> Int {
    return cells[safe: section]?.count ?? 0
  }
}

protocol TableViewDataSource: ListDataSource {}
extension TableViewDataSource {
  func cell(for indexPath: IndexPath) -> CellContext? {
    return cells[safe: indexPath.section]?[safe: indexPath.row]
  }
}

protocol CollectionViewDataSource: ListDataSource {}
extension CollectionViewDataSource {
  func cell(for indexPath: IndexPath) -> CellContext? {
    return cells[safe: indexPath.section]?[safe: indexPath.item]
  }
}
