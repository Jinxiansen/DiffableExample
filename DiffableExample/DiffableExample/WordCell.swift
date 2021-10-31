//
//  WordCell.swift
//  DiffableExample
//
//  Created by 晋先森 on 10/31/21.
//

import UIKit

class WordCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var deleteItemClosure: ((WordItem) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configurationUpdateHandler = { cell, state in
            var background = cell.backgroundConfiguration?.updated(for: state)
            if state.isHighlighted {
                background?.backgroundColor = .secondarySystemFill
            } else if state.isSelected {
                background?.backgroundColor = .quaternarySystemFill
            } else {
                background?.backgroundColor = .clear
            }
            cell.backgroundConfiguration = background
        }
    }
    
    var item: WordItem? {
        didSet {
            guard let item = item else { return }
            titleLabel.text = item.riddle
            subTitleLabel.text = item.answer
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        guard let item = item else { return }
        deleteItemClosure?(item)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
