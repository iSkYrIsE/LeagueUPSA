//
//  ViewControllerGeneralView.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 30/04/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import LeagueAPI
import UIKit

class ViewControllerGeneralView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var labelNombreInvocador: UILabel!
    @IBOutlet weak var labelNivelInvocador: UILabel!
    @IBOutlet weak var imageViewInvocador: UIImageView!
    @IBOutlet weak var progressPorcentaje: UIProgressView!
    @IBOutlet weak var labelPorcentaje: UILabel!
    
    @IBOutlet weak var tableViewPartidas: UITableView!
    let queue = OperationQueue()
    let group = DispatchGroup()
    
    var invocador:String?
    var indice:Int?
    var apiFunctions = APIFunctions()
    var viewFunctions = ViewFunctions()
    var modeloPrincipal = ModeloPrincipal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        queue.maxConcurrentOperationCount=1
        
        print("-------------View Controller General----------------")
        
        cargarOpcionesVista()
        cargarParametrosVista()
        
    }
    
    func cargarParametrosVista(){
        queue.addOperation {
            self.apiFunctions.buscarInvocadorQueue(league: APIResources.league, invocador: APIResources.summonerName!, region: APIResources.region)
        }
        
        queue.waitUntilAllOperationsAreFinished()
       
        //Cargamos las partidas para el invocador seleccionado
        queue.addOperation {
            self.apiFunctions.listaPartidas(league: APIResources.league, invocador: APIResources.summoner!.name, region: APIResources.region, summoner: APIResources.summoner!)
        }
        
        //Realizamos la operacion de busqueda para la imagen de invocador con las dos siguientes operaciones
        queue.addOperation {
            self.apiFunctions.buscarImagenGeneral(league: APIResources.league, invocador: APIResources.summoner!.name, region: APIResources.region, profileIconId: APIResources.summoner!.iconId)
        }
        queue.addOperation {
            self.apiFunctions.buscarImagen()
        }
        
        
        //Realizamos la busqueda de las ultimas partidas jugadas por el invocador de manera avanzada
        queue.addOperation {
            for indice in 0...APIResources.num_partidas{
                self.apiFunctions.buscarPartidaAvanzado(league: APIResources.league, invocador: APIResources.summoner!.name, region: APIResources.region, gameID: (APIResources.listadoPartidas?.matches[indice].gameId)!)
            }
        }
        
        queue.addOperation {
            for indice in 0...APIResources.num_partidas{
                self.apiFunctions.buscarCampeon(league: APIResources.league, invocador: APIResources.summoner!.name, region: APIResources.region, championId: (APIResources.listadoPartidas?.matches[indice].championId)!)
            }
        }
        
        queue.addOperation {
            for indice in 0...APIResources.num_partidas{
                self.apiFunctions.buscarImagenCampeon(imageWithUrl: APIResources.listadoCampeonesJugados[indice].images!.square)
                
                print(APIResources.listadoCampeonesJugados[indice].name)
            }

        }
        
        queue.addOperation {
            self.modeloPrincipal.resultadoPartida()
            self.modeloPrincipal.obtenerKDA()
        }
        
        
        queue.waitUntilAllOperationsAreFinished()
        //Ultima operación,muestra los datos en cada uno de los contenedores
        queue.addOperation {
            DispatchQueue.main.async {
                self.labelPorcentaje.text = "Victorias: "
                self.labelPorcentaje.text?.append(self.modeloPrincipal.calcularMediaVictorias().description)
                self.labelPorcentaje.text?.append("%")
                self.progressPorcentaje.setProgress(Float(self.modeloPrincipal.calcularMediaVictorias()/10), animated: true)
                self.labelNombreInvocador.text = APIResources.summoner?.name
                self.labelNivelInvocador.text = APIResources.summoner?.level.description
                self.imageViewInvocador.image = APIResources.imagenInvocador
                self.tableViewPartidas.reloadData()
            }
        }
    }
    
    func cargarOpcionesVista(){
        viewFunctions.setLabelOptions(label: labelNombreInvocador)
        viewFunctions.setLabelOptions(label: labelNivelInvocador)
        viewFunctions.prepareSummonerImage(imageView: imageViewInvocador)
    }
    
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        if(APIResources.listadoPartidas?.matches.count != nil){
            return (4)
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewCell", for: indexPath) as! TablaPrincipal
        var title = "Ver partida "

        cell.labelTipoPartida.text = APIResources.listadoPartidasAvanazado[indexPath.row].gameMode.mode.rawValue
        cell.labelMapa.text = APIResources.listadoPartidasAvanazado[indexPath.row].map.name
        cell.labelDuracion.text = Int(APIResources.listadoPartidasAvanazado[indexPath.row].gameDuration.durationMinutes).description
        cell.labelDuracion.text?.append(" minutos")
        cell.imagenCampeon.image = APIResources.listadoImagenesCampeones[indexPath.row]
        cell.labelEstadisticas.text = APIResources.jugadorKDA[indexPath.row]
        title.append(indexPath.row.description)
        cell.buttonPartida.setTitle(title, for: .normal)
        if(APIResources.resultadoPartidas[indexPath.row]){
            cell.backgroundColor = UIColor.green
        }else{
            cell.backgroundColor = UIColor.red
        }
        
        
        return cell
    }
    @IBAction func verPartidaButton(_ sender: UIButton) {
        

        switch sender.titleLabel?.text {
        case "Ver partida 0":
            indice = 0
            
        case "Ver partida 1":
            indice = 1
        case "Ver partida 2":
            indice = 2
        case "Ver partida 3":
            indice = 3
        default:
            indice = 0
        }
        
        self.performSegue(withIdentifier: "seguePartidaDetallada", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? ViewControllerPartidaDetallada {
            nextViewController.indicePartida = indice!
        }
        
    }
    
}
