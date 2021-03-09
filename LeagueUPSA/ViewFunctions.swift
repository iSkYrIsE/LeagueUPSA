//
//  ViewFunctions.swift
//  LeagueUPSA
//
//  Created by Daniel Díez Arias on 30/04/2019.
//  Copyright © 2019 MSDIEZ. All rights reserved.
//

import Foundation
import LeagueAPI
import UIKit

class ViewFunctions: UIViewController {
    
    func setLabelOptions(label:UILabel){
        let fontSize: CGFloat = 25
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    func prepareSummonerImage(imageView: UIImageView){
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
    }
}
