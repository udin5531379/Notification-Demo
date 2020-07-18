//
//  CustomCell.swift
//  n otification-demo
//
//  Created by Udin Rajkarnikar on 10/10/18.
//  Copyright © 2018 Udin Rajkarnikar. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var cell: UIImageView!
    
    @IBOutlet weak var memberLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var callsNotAnsweredLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func commonInit(_memberGroup: String, _memberName: String, _callsNotAnswered: Int){
        
        
        memberLabel.text = _memberGroup
        nameLabel.text = _memberName
        callsNotAnsweredLabel.text = String(_callsNotAnswered)
        
        
    }
    
}
