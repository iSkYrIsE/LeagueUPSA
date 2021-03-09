//
//  TablaCampeones.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 30/04/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import UIKit

class TablaCampeones: UITableViewCell {
    
    @IBOutlet weak var imageCampeon: UIImageView!
    @IBOutlet weak var labelCampeon: UILabel!
    @IBOutlet weak var buttonCampeon: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
