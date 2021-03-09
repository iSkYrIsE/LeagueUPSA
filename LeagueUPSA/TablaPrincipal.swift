//
//  TablaPrincipal.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 30/04/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import UIKit

class TablaPrincipal: UITableViewCell {
    
    @IBOutlet weak var buttonPartida: UIButton!
    @IBOutlet weak var imagenCampeon: UIImageView!
    @IBOutlet weak var labelDuracion: UILabel!
    @IBOutlet weak var labelMapa: UILabel!
    @IBOutlet weak var labelEstadisticas: UILabel!
    @IBOutlet weak var labelTipoPartida: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
