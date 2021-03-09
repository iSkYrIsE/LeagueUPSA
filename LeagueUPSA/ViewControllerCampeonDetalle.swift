//
//  ViewControllerCampeonDetalle.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 30/04/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import UIKit
import LeagueAPI

class ViewControllerCampeonDetalle: UIViewController{
    
    @IBOutlet weak var imageCampeon: UIImageView!
    @IBOutlet weak var labelNombreCampeon: UILabel!
    @IBOutlet weak var textAreaLore: UITextView!
    
    @IBOutlet weak var cuartaHabilidad: UILabel!
    @IBOutlet weak var terceraHabilidad: UILabel!
    @IBOutlet weak var segundaHabilidad: UILabel!
    @IBOutlet weak var primeraHabilidad: UILabel!
    var apiFunctions = APIFunctions()
    var viewFunctions = ViewFunctions()
    var modeloPrincipal = ModeloPrincipal()
    
    let queue = OperationQueue()
    let group = DispatchGroup()
    
    var campeonNombre:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        print("-------------View Controller Campeon Detallado----------------")
        queue.maxConcurrentOperationCount = 1
        cargarParametrosVista()
    }
    
    func cargarParametrosVista(){
        
        queue.addOperation {
            self.apiFunctions.buscarCampeonPorNombre(league: APIResources.league, nombre: self.campeonNombre)
        }
        
        queue.addOperation {
            self.apiFunctions.buscarImagenCampeonPerfil(imageWithUrl: (APIResources.championDetails?.images!.splash)!)
        }
        queue.waitUntilAllOperationsAreFinished()
        queue.addOperation {
            DispatchQueue.main.async {
                
                self.imageCampeon.image = APIResources.imagenCampeon
                self.labelNombreCampeon.text = APIResources.championDetails?.name
                self.textAreaLore.text = APIResources.championDetails?.lore
                
                self.primeraHabilidad.text = APIResources.championDetails?.spells[0].name
                self.segundaHabilidad.text = APIResources.championDetails?.spells[1].name
                self.terceraHabilidad.text = APIResources.championDetails?.spells[2].name
                self.cuartaHabilidad.text = APIResources.championDetails?.spells[3].name
            }
        }
    }
}
