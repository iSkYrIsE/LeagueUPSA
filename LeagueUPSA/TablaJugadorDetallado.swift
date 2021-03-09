//
//  TablaJugadorDetallado.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 01/05/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import UIKit

class TablaJugadorDetallado: UITableViewCell {
    
    @IBOutlet weak var imagenUno: UIImageView!
    @IBOutlet weak var imagenDos: UIImageView!
    
    @IBOutlet weak var resultadoUno: UILabel!
    @IBOutlet weak var resultadoDos: UILabel!
    
    @IBOutlet weak var nombreUno: UILabel!
    @IBOutlet weak var nombreDos: UILabel!
    
    @IBOutlet weak var nombreCampeonUno: UILabel!
    @IBOutlet weak var nombreCampeonDos: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
