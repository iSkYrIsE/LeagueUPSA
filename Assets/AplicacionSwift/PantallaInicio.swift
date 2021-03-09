//
//  PantallaInicio.swift
//  AplicacionSwift
//
//  Created by Administrador on 25/4/19.
//  Copyright © 2019 Administrador. All rights reserved.
//

import UIKit

class PantallaInicio: UIViewController {

    var fondoInicio = fondoAnimado()
    @IBOutlet weak var ImagenFondo: UIImageView!
    @IBOutlet weak var usuario: UITextField!
    
    @IBOutlet weak var mensajeError: UILabel!
    
    
    var usuario1 = usuarios()
    
    
    
    
    @IBAction func entrar() {
        
        var contador = 0
        usuario.resignFirstResponder()
        
      /*  if let user = usuario.text{
            
            for(elemento in usuario1.arrayUsuarios)
            {
                if(elemento == user)
                {
                    contador = contador + 1
                            performSegue(withIdentifier: "siguiente", sender: self)
                }
                
            }
            
            if (contador > 0)
            {
                mensajeError.text = "El usuario escrito no existe"
            }
            

        }
 */

        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fondoInicio.animate(vistaImagenes: ImagenFondo, imagenes: fondoInicio.arrayImagenes)
        
        configuracionTextField()
        

    }
    
    private func configuracionTextField() {
        usuario.delegate = self
    }
    
    private func configurarTocarFueraTeclado()
    {
        let pulsar = UITapGestureRecognizer(target: self, action: #selector(PantallaInicio.tocar))
        view.addGestureRecognizer(pulsar)
        
    }
    
    @objc func tocar() {
        print("se ha tocado con la mano")
        view.endEditing(true)
    }

   

}

extension PantallaInicio : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
