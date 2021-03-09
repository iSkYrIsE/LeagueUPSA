//
//  ViewControllerChampions.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 30/04/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import LeagueAPI
import UIKit

class ViewControllerChampions: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var labelCargando: UILabel!
    let queue = OperationQueue()
    let group = DispatchGroup()
    
    var nombreCampeon:String?
    var apiFunctions = APIFunctions()
    var viewFunctions = ViewFunctions()
    var modeloPrincipal = ModeloPrincipal()
    
    @IBOutlet weak var tableViewCampeones: UITableView!
    override func viewDidLoad() {
        
        print("-------------View Controller Campeon----------------")
        APIResources.listadoImagenesCampeonesDetalle.removeAll()
        APIResources.listadoCampeonesView.removeAll()
        APIResources.listadoIDCampeones.removeAll()
        queue.maxConcurrentOperationCount=1
        cargarParametrosVista()
    }
    
    func cargarParametrosVista(){
        queue.addOperation {
            self.apiFunctions.buscarTodosCampeones(league: APIResources.league)
        }
        
        queue.addOperation {
            
            for indice in 0...9{
                self.apiFunctions.buscarCampeonListado(league: APIResources.league, invocador: APIResources.summoner!.name, region: APIResources.region, championId: APIResources.listadoIDCampeones[indice])
            }
        }
        
        queue.addOperation {
            for indice in 0...4{
                self.apiFunctions.buscarImagenCampeonDetalle(imageWithUrl: APIResources.listadoCampeonesView[indice].images!.loading)
            }
        }
        
        queue.addOperation {
            
            DispatchQueue.main.async {
                
                self.tableViewCampeones.reloadData()
                
            }
        }
    }
    
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        if(APIResources.listadoImagenesCampeonesDetalle.count != nil){
            return (APIResources.listadoImagenesCampeonesDetalle.count)
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewCellCampeon", for: indexPath) as! TablaCampeones
        if(APIResources.listadoImagenesCampeonesDetalle.count > 0){
            labelCargando.text = ""
            cell.imageCampeon.image = APIResources.listadoImagenesCampeonesDetalle[indexPath.row]
            cell.buttonCampeon.setTitle(APIResources.listadoCampeonesView[indexPath.row].name, for: .normal)
        }
        
        return cell
    }
    @IBAction func pulsarCampeonDetallado(_ sender: UIButton) {
        
            self.nombreCampeon = sender.titleLabel?.text
            self.performSegue(withIdentifier: "segueDetalleCampeon", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? ViewControllerCampeonDetalle {
            nextViewController.campeonNombre = nombreCampeon! 
        }
        
    }
}
