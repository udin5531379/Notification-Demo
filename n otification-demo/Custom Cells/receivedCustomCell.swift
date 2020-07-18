//
//  receivedCustomCell.swift
//  n otification-demo
//
//  Created by Udin Rajkarnikar on 10/11/18.
//  Copyright © 2018 Udin Rajkarnikar. All rights reserved.
//

import UIKit

class receivedCustomCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var receivedCallsCompletedNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInitFromReceivedClass(_memberGroup: String, _memberName: String, _callsNotAnswered: Int){
        
        groupLabel.text = _memberGroup
        nameLabel.text = _memberName
        receivedCallsCompletedNumber.text = String(_callsNotAnswered)
        
        
    }
    
}
