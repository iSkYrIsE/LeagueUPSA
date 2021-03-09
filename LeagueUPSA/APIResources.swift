//
//  APIResources.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 30/04/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import LeagueAPI


class APIResources{
    
    static var summonerName:String?
    static var num_partidas = 4
    static var num_jugadores = 9
    static var summoner:Summoner?
    static var region:Region = .EUW
    static var imagenInvocador:UIImage?
    static var imagenCampeon:UIImage?
    static var listadoPartidas:MatchList?
    static var championDetails:ChampionDetails?
    static var listadoIDCampeones = [ChampionId]()
    static var listadoCampeonesView = [ChampionDetails]()
    static var listadoImagenesCampeonesDetalle = [UIImage]()
    static var listadoImagenesCampeonesPartida = [UIImage]()
    static var directo:Bool?
    
    static var listadoPartidasAvanazado = [Match]()
    static var listadoCampeonesJugados = [ChampionDetails]()
    static var listadoCampeonesPartida = [ChampionDetails]()
    static var listadoImagenesCampeones = [UIImage]()
    static var resultadoPartidas = [Bool]()
    static var jugadorKDA = [String]()
    

    static var api_key = "RGAPI-e77faffe-d8d3-4428-81bf-8bde18bae775"
    static var league:LeagueAPI = LeagueAPI(APIToken: APIResources.api_key)
    
    
    
}
