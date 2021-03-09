//
//  fondoAnimado.swift
//  AplicacionSwift
//
//  Created by Administrador on 25/4/19.
//  Copyright © 2019 Administrador. All rights reserved.
//

import Foundation
import UIKit

class fondoAnimado {
    
    var arrayImagenes: [UIImage] = [UIImage(named: "Campeon1.jpeg")!, UIImage(named: "Campeon2.jpeg")!, UIImage(named: "Campeon3.jpeg")!, UIImage(named: "Campeon4.jpeg")!]
    
    func animate(vistaImagenes: UIImageView, imagenes: [UIImage]){
        vistaImagenes.animationImages = imagenes
        vistaImagenes.animationDuration = 15.0
        vistaImagenes.animationRepeatCount = 0
        vistaImagenes.startAnimating()
    }
        
    
    
    //vistaImagenes.stopAnimating()----Importante para cuando se verifique el usuario de la aplicacion

 
  /*
    var diccionarioFotos: [Int: UIImage] = [1: UIImage(named: "Campeon1.jpeg")!, 2: UIImage(named: "Campeon2.jpeg")!, 3:UIImage(named: "Campeon3.jpeg")!, 4:UIImage(named: "Campeon4.jpeg")!]

    
    func imagenAleatoria() -> UIImage {
        
        var numeroImagen:Int
        var imagenElegida: UIImage
        
        numeroImagen = getRandomNumberBetween(From: 0, To: 3)
        imagenElegida = diccionarioFotos [numeroImagen]!
        
        return imagenElegida
    }
    
    func getRandomNumberBetween (From: Int , To: Int) -> Int {
        return From + Int(arc4random_uniform(UInt32(To - From + 1)))
    }
    */
}

