//
//  FirstTabViewController.swift
//  TabBarProgrammatic
//
//  Created by Jorge Ferrusca on 31/05/24.
//

import UIKit

class FirstTabViewController: UIViewController {
    // Persisting data
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customizing the tab bar manually
        self.title = "First Controller"
        self.tabBarItem.image = UIImage(systemName: "eraser")
        self.tabBarItem.selectedImage = UIImage(systemName: "eraser.fill")
        
        userDefaults.set("490", forKey: "myKey")
        print(userDefaults.integer(forKey: "myKey"))
        
        struct MyStruct: Codable {
            var property1: String
            var property2: Int
        }

        // Crear un arreglo de estructuras
        let myArray: [MyStruct] = [
            MyStruct(property1: "Valor1", property2: 42),
            MyStruct(property1: "Valor2", property2: 55)
        ]

        // Usar JSONEncoder para codificar el arreglo en formato JSON
        if let encodedData = try? JSONEncoder().encode(myArray) {
            // Guardar el JSON codificado en UserDefaults con una clave específica
            userDefaults.set(encodedData, forKey: "myArrayKey")
        }

        // Para leer el arreglo de estructuras
        if let savedData = userDefaults.data(forKey: "myArrayKey"),
           let decodedArray = try? JSONDecoder().decode([MyStruct].self, from: savedData) {
            // `decodedArray` ahora contiene los datos guardados
            print(decodedArray[0])
        } else {
            // No se encontraron datos guardados o hubo un error al decodificar
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
