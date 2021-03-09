//
//  fondoAnimado.swift
//  AplicacionSwift
//
//  Created by Administrador on 25/4/19.
//  Copyright © 2019 Administrador. All rights reserved.
//

import Foundation
import UIKit

class FondoAnimado {
    
    var arrayImagenes: [UIImage] = [UIImage(named: "Campeon1.jpeg")!, UIImage(named: "Campeon2.jpeg")!, UIImage(named: "Campeon3.jpeg")!, UIImage(named: "Campeon4.jpeg")!]
    
    func animate(vistaImagenes: UIImageView, imagenes: [UIImage]){
        vistaImagenes.animationImages = imagenes
        vistaImagenes.animationDuration = 15.0
        vistaImagenes.animationRepeatCount = 0
        vistaImagenes.startAnimating()
    }
    
}


