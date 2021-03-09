//
//  ViewController.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 30/04/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import UIKit
import LeagueAPI

class ViewController: UIViewController {
    
    
    @IBOutlet weak var textNombreInvocador: UITextField!
    
    @IBOutlet weak var imagenFondo: UIImageView!
    var textInvocador:String?
    
    var fondoInicio = FondoAnimado()
    var apiFunctions = APIFunctions()
    var modeloPrincipal = ModeloPrincipal()
    

    let queue = OperationQueue()
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fondoInicio.animate(vistaImagenes: imagenFondo, imagenes: fondoInicio.arrayImagenes)
        queue.maxConcurrentOperationCount = 1;

    }

    @IBAction func botonBusquedaInvocador(_ sender: Any) {
        textInvocador = textNombreInvocador.text
        APIResources.summonerName = textInvocador
        
        queue.addOperation {
            self.modeloPrincipal.reiniciarDatos()
        }
        queue.waitUntilAllOperationsAreFinished()
        
        queue.addOperation {

            self.apiFunctions.buscarInvocadorQueue(league: APIResources.league, invocador: APIResources.summonerName!, region: APIResources.region)
            
        }
        queue.waitUntilAllOperationsAreFinished()
        
        if(APIResources.summoner != nil){
            self.performSegue(withIdentifier: "seguePrincipal", sender: self)
        }
        
          
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
    


}

