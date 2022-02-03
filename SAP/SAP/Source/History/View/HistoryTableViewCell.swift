//
//  HistoryTableViewCell.swift
//  SAPTest
//
//  Created by Hamza Ahmed on 01/02/2022.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var lblSearchedText: UILabel!
    var cellViewModel : HistoryCellViewModel!{
        didSet{
            configCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    private func configCell() {
        lblSearchedText.text = cellViewModel.history.searchText
    }
    
}
