//
//  ModeloPrincipal.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 30/04/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import LeagueAPI

class ModeloPrincipal{
    
    func resultadoPartida(){
        
        //Cargamos los dos equipos que han participado en la partida
        var equipoUno:TeamStats?
        var equipoDos:TeamStats?
        //Averiguamos en que equipo estamos
        
        for indice in 0...APIResources.num_partidas{
            
            equipoUno = APIResources.listadoPartidasAvanazado[indice].teamsInfo[0]
            equipoDos = APIResources.listadoPartidasAvanazado[indice].teamsInfo[1]
            
            for indice_jugadores in 0...APIResources.num_jugadores{
                if(APIResources.listadoPartidasAvanazado[indice].teamsInfo[0].teamId ==
                    APIResources.listadoPartidasAvanazado[indice].participantsInfo[indice_jugadores].teamId){
                    
                    if(APIResources.listadoPartidasAvanazado[indice].participants[indice_jugadores].player.summonerName == APIResources.summoner?.name){
                        
                        APIResources.resultadoPartidas.append(APIResources.listadoPartidasAvanazado[indice].teamsInfo[0].win)
                    }
                    
                    
                }else{
                    if(APIResources.listadoPartidasAvanazado[indice].participants[indice_jugadores].player.summonerName == APIResources.summoner?.name){
                        APIResources.resultadoPartidas.append(APIResources.listadoPartidasAvanazado[indice].teamsInfo[1].win)
                    }
                }
                
            }
        }
    }
    
    func calcularMediaVictorias() -> Int{
        var contador = 0
        var media = 0
        
        for item in APIResources.resultadoPartidas{
            if(item){
                contador = contador + 1
            }
        }
        
        if(APIResources.resultadoPartidas.count>0){
            media = (100 * contador) / APIResources.resultadoPartidas.count
        }else{
            media = 0
        }
        return media
    }
    
    
    func obtenerKDA(){
        
        var cadenaKDA = ""
        for indice in 0...APIResources.num_partidas{
            
            for numJugador in 0...APIResources.num_jugadores{
                if(APIResources.summoner?.name == APIResources.listadoPartidasAvanazado[indice].participants[numJugador].player.summonerName){
                    cadenaKDA = APIResources.listadoPartidasAvanazado[indice].participantsInfo[numJugador].stats.kills.description
                    cadenaKDA.append("/")
                    cadenaKDA.append(APIResources.listadoPartidasAvanazado[indice].participantsInfo[numJugador].stats.deaths.description)
                    cadenaKDA.append("/")
                    cadenaKDA.append(APIResources.listadoPartidasAvanazado[indice].participantsInfo[numJugador].stats.assists.description)
                    
                    APIResources.jugadorKDA.append(cadenaKDA)
                }
                cadenaKDA = "";
            }
            
            
        }
    }
    
    func obtenerKDAParameter(stats: MatchParticipantStats) -> String{
        var cadenaKDA = ""
        
        
        cadenaKDA = stats.kills.description
        cadenaKDA.append("/")
        cadenaKDA.append(stats.deaths.description)
        cadenaKDA.append("/")
        cadenaKDA.append(stats.assists.description)
        
        return cadenaKDA
    }
    
    func reiniciarDatos(){
        
        APIResources.imagenInvocador = nil
        APIResources.imagenInvocador = nil
        APIResources.listadoPartidas?.matches.removeAll()
        APIResources.championDetails = nil
        APIResources.listadoIDCampeones.removeAll()
        APIResources.listadoCampeonesView.removeAll()
        APIResources.listadoImagenesCampeonesDetalle.removeAll()
        APIResources.listadoImagenesCampeonesPartida.removeAll()
        APIResources.directo = nil
        APIResources.listadoPartidasAvanazado.removeAll()
        APIResources.listadoCampeonesJugados.removeAll()
        APIResources.listadoCampeonesPartida.removeAll()
        APIResources.listadoImagenesCampeones.removeAll()
        APIResources.resultadoPartidas.removeAll()
        APIResources.jugadorKDA.removeAll()
        APIResources.summoner = nil
        APIResources.league.clearCache()
        
    }
    
    
}
    
    

