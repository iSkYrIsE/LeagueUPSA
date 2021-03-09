//
//  APIFunctions.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 30/04/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import LeagueAPI


class APIFunctions{
    
    var imagenURL:ImageWithUrl?
    
    func buscarInvocadorQueue(league: LeagueAPI, invocador: String, region: Region){
        
        let semaphore = DispatchSemaphore(value: 0)
        league.riotAPI.getSummoner(byName: invocador, on: region) { (summoner, errorMsg) in
            semaphore.signal()
            if let summoner = summoner {
                print("Exito en la busqueda del invocador queue")
                
                APIResources.summoner = summoner
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
        print("Cierre señal buscar invocador queue")
    }
    
    func buscarInvocadorGroup(league: LeagueAPI, invocador: String, region: Region, group: DispatchGroup){
        
        group.enter()

        league.riotAPI.getSummoner(byName: invocador, on: region) { (summoner, errorMsg) in
            if let summoner = summoner {
                print("Exito en la busqueda del invocador group")

                DispatchQueue.main.async {
                    APIResources.summoner = summoner
                }
                group.leave()
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
                group.leave()
            }
        }

        print("Cierre señal buscar invocador group")
    }
    
    func listaPartidas(league: LeagueAPI, invocador: String, region: Region, summoner: Summoner){
        
        let semaphore = DispatchSemaphore(value: 0)
        league.riotAPI.getMatchList(by: AccountId(summoner.accountId.description), on: .EUW) { (matchList, errorMsg) in
            semaphore.signal()
            if let matchList = matchList {
                print("Exito en buscando lista de partidas")
                APIResources.listadoPartidas = matchList
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
        print("Cierre señal listar partidas")
    }
    
    
    func buscarImagenGeneral(league: LeagueAPI, invocador: String, region: Region, profileIconId:ProfileIconId){
        
        let semaphore = DispatchSemaphore(value: 0)
        league.getProfileIcon(by: ProfileIconId(profileIconId.value)) { (profileIconInfo, errorMsg) in
            semaphore.signal()
            if let profileIconInfo = profileIconInfo {
                print("Exito en la busqueda de icono de invocador")
                self.imagenURL = profileIconInfo.profileIcon
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
        print("Cierre señal busqueda icono invocador")
    }
    
    func buscarImagen(){
        let semaphore = DispatchSemaphore(value: 0)
        self.imagenURL!.getImage() { (image, errorMsg) in
            semaphore.signal()
            if let image = image {
                print("Imagen de invocador encontrada")
                APIResources.imagenInvocador = image
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
        print("Cierre señal busqueda de imagen")
    }
    
    func buscarPartidaAvanzado(league: LeagueAPI, invocador: String, region: Region, gameID: GameId){
        let semaphore = DispatchSemaphore(value: 0)
        
        league.riotAPI.getMatch(by: GameId(gameID.value), on: .EUW) { (game, errorMsg) in
            semaphore.signal()
            if let game = game {
                print("Partida encontrada")
                APIResources.listadoPartidasAvanazado.append(game)
                
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
        print("Cierre señal buscar partida avanzada")
    }
    
    
    func buscarCampeon(league: LeagueAPI, invocador: String, region: Region, championId: ChampionId){
        let semaphore = DispatchSemaphore(value: 0)
        league.getChampionDetails(by: ChampionId(championId.value)) { (champion, errorMsg) in
            semaphore.signal()
            if let champion = champion {
                print("Campeon encontrado")
                APIResources.listadoCampeonesJugados.append(champion)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
        print("Cierre señal buscar campeon")
    }
    
    func buscarImagenCampeon(imageWithUrl: ImageWithUrl){
        let semaphore = DispatchSemaphore(value: 0)
        imageWithUrl.getImage() { (image, errorMsg) in
            semaphore.signal()
            if let image = image {
                print("Imagen de invocador encontrada")
                APIResources.listadoImagenesCampeones.append(image)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
        print("Cierre señal buscar imagen")
    }
    
    
    func buscarTodosCampeones(league: LeagueAPI){
        league.getAllChampionIds() { (championIds, errorMsg) in
            if let championIds = championIds {
                print("Exito en busqueda de lista de ID's de campeon")
                APIResources.listadoIDCampeones = championIds
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    
    func buscarCampeonListado(league: LeagueAPI, invocador: String, region: Region, championId: ChampionId){
        let semaphore = DispatchSemaphore(value: 0)
        league.getChampionDetails(by: ChampionId(championId.value)) { (champion, errorMsg) in
            semaphore.signal()
            if let champion = champion {
                print("Campeon encontrado")
                APIResources.listadoCampeonesView.append(champion)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
        print("Cierre señal buscar campeon")
    }
    
    
    func buscarImagenCampeonDetalle(imageWithUrl: ImageWithUrl){
        let semaphore = DispatchSemaphore(value: 0)
        imageWithUrl.getImage() { (image, errorMsg) in
            semaphore.signal()
            if let image = image {
                print("Imagen de invocador encontrada")
                APIResources.listadoImagenesCampeonesDetalle.append(image)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
        
        print("Cierre señal buscar imagen")
    }
    
    func buscarImagenCampeonPerfil(imageWithUrl: ImageWithUrl){
        let semaphore = DispatchSemaphore(value: 0)
        imageWithUrl.getImage() { (image, errorMsg) in
            semaphore.signal()
            if let image = image {
                print("Imagen de invocador encontrada")
                APIResources.imagenCampeon = image
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
    }
    
    func buscarCampeonPorNombre(league: LeagueAPI, nombre: String){
        league.getChampionDetails(byName: nombre) { (champion, errorMsg) in
            if let champion = champion {
                print("Campeon por nombre")
                APIResources.championDetails = champion
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    
    
    func buscarCampeonPartida(league: LeagueAPI, invocador: String, region: Region, championId: ChampionId){
        let semaphore = DispatchSemaphore(value: 0)
        league.getChampionDetails(by: ChampionId(championId.value)) { (champion, errorMsg) in
            semaphore.signal()
            if let champion = champion {
                print("Campeon encontrado")
                APIResources.listadoCampeonesPartida.append(champion)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
        print("Cierre señal buscar campeon")
    }
    
    func buscarImagenCampeonPartida(imageWithUrl: ImageWithUrl){
        let semaphore = DispatchSemaphore(value: 0)
        imageWithUrl.getImage() { (image, errorMsg) in
            semaphore.signal()
            if let image = image {
                print("Imagen de invocador encontrada")
                APIResources.listadoImagenesCampeonesPartida.append(image)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
    }
    
    
    func partidaEnDirecto(league:LeagueAPI, summoner:Summoner){
        let semaphore = DispatchSemaphore(value: 0)
        league.riotAPI.getLiveGame(by: SummonerId(summoner.id.description), on: .EUW) { (liveGame, errorMsg) in
             semaphore.signal()
            if let liveGame = liveGame {
                print("Success!")
                
                APIResources.directo = true
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
        semaphore.wait()
    }
    
    
    
}
