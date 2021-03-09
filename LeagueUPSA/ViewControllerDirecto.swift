//
//  ViewControllerDirecto.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 01/05/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import UIKit
import LeagueAPI

class ViewControllerDirecto: UIViewController{
    var apiFunctions = APIFunctions()
    var viewFunctions = ViewFunctions()
    var modeloPrincipal = ModeloPrincipal()
    
    @IBOutlet weak var estadoPartida: UILabel!
    @IBOutlet weak var nombreJuador: UILabel!
    let queue = OperationQueue()
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        
        print("-------------View Controller Directo----------------")
        APIResources.directo = false
        queue.maxConcurrentOperationCount = 1
        cargarDatosDirecto()
    }
    
    func cargarDatosDirecto(){
        queue.addOperation {
            self.apiFunctions.partidaEnDirecto(league: APIResources.league, summoner: APIResources.summoner!)
        }
        
        queue.addOperation {
            DispatchQueue.main.async {
                
                self.nombreJuador.text?.append(APIResources.summoner!.name)
                if(APIResources.directo!){
                    self.estadoPartida.text?.append("Se encuentra en directo")
                }else{
                    self.estadoPartida.text?.append("Se encuentra desconectado")
                }
            }
        }
        
    }
}
