//
//  ViewControllorePartidaDetallada.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 30/04/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import UIKit
import LeagueAPI

class ViewControllerPartidaDetallada: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var baronesUno: UILabel!
    @IBOutlet weak var baronesDos: UILabel!
    @IBOutlet weak var dragonesDos: UILabel!
    @IBOutlet weak var dragonesUno: UILabel!
    @IBOutlet weak var tableViewPartidaDetallada: UITableView!
    var indicePartida:Int = 0
    var indiceI:Int = 0
    var indiceJ:Int = 5
    
    
    
    var apiFunctions = APIFunctions()
    var viewFunctions = ViewFunctions()
    var modeloPrincipal = ModeloPrincipal()
    
    let queue = OperationQueue()
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        print("-------------View Controller Partida Detallada----------------")
        queue.maxConcurrentOperationCount = 1
        tableViewPartidaDetallada.alwaysBounceVertical = false;
        APIResources.listadoImagenesCampeonesPartida.removeAll()
        APIResources.listadoCampeonesPartida.removeAll()
        cargarParametrosVista()
    }
    
    func cargarParametrosVista(){
        
        queue.addOperation {
            for indice in 0...9{
                
                self.apiFunctions.buscarCampeonPartida(league: APIResources.league, invocador: APIResources.summoner!.name, region: APIResources.region, championId: APIResources.listadoPartidasAvanazado[self.indicePartida].participantsInfo[indice].championId)
            }
        }
        
        queue.addOperation {
            for indice in 0...9{
                
                self.apiFunctions.buscarImagenCampeonPartida(imageWithUrl: APIResources.listadoCampeonesPartida[indice].images!.square)
 
            }
        }
        queue.waitUntilAllOperationsAreFinished()
        queue.addOperation {
            DispatchQueue.main.async {
                
            self.baronesUno.text?.append(APIResources.listadoPartidasAvanazado[self.indicePartida].teamsInfo[0].baronKills.description)
            self.baronesDos.text?.append(APIResources.listadoPartidasAvanazado[self.indicePartida].teamsInfo[1].baronKills.description)
                
            self.dragonesUno.text?.append(APIResources.listadoPartidasAvanazado[self.indicePartida].teamsInfo[0].dragonKills.description)
                
            self.dragonesDos.text?.append(APIResources.listadoPartidasAvanazado[self.indicePartida].teamsInfo[1].dragonKills.description)
                self.tableViewPartidaDetallada.reloadData()
                self.indiceJ = 0;
                self.indiceI = 5;
                self.tableViewPartidaDetallada.reloadData()
                
            }
        }
        
    }
    
    
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewCellJugadorDetallado", for: indexPath) as! TablaJugadorDetallado
        
        if(APIResources.listadoCampeonesPartida.count == 10){
            cell.nombreUno.text = APIResources.listadoPartidasAvanazado[self.indicePartida].participants[indiceI].player.summonerName
            cell.nombreDos.text = APIResources.listadoPartidasAvanazado[self.indicePartida].participants[indiceJ].player.summonerName
            
            cell.nombreCampeonUno.text = APIResources.listadoCampeonesPartida[indiceI].name
            cell.nombreCampeonDos.text = APIResources.listadoCampeonesPartida[indiceJ].name
            
            cell.imagenDos.image = APIResources.listadoImagenesCampeonesPartida[indiceJ]
            cell.imagenUno.image = APIResources.listadoImagenesCampeonesPartida[indiceI]
            
            cell.resultadoUno.text = self.modeloPrincipal.obtenerKDAParameter(stats: APIResources.listadoPartidasAvanazado[self.indicePartida].participantsInfo[indiceI].stats)
            cell.resultadoDos.text = self.modeloPrincipal.obtenerKDAParameter(stats: APIResources.listadoPartidasAvanazado[self.indicePartida].participantsInfo[indiceJ].stats)
            self.indiceI = self.indiceI+1
            self.indiceJ = self.indiceJ+1
        }
        return cell
    }
}
