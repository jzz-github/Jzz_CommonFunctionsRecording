//
//  CatalogueTableViewCell.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/21.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class CatalogueTableViewCell: UITableViewCell {

    ///标题
    @IBOutlet weak var title_lab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
