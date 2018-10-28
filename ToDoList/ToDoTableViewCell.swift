//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Татьяна on 28.10.2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    var delegate: ToDoCellDelegate!
    var indexPath: IndexPath!
    
    @IBOutlet weak var compliteButton: UIButton!
    @IBOutlet weak var name: UILabel!

    @IBAction func toggleIsCompliteToDo(_ sender: UIButton) {
        delegate?.toggleComplite(for: indexPath)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
