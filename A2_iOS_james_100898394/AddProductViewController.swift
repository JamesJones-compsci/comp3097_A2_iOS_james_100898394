//
//  AddProductViewController.swift
//  A2_iOS_james_100898394
//
//  Created by Tech on 2026-04-05.
//

import UIKit
import CoreData

class AddProductViewController: UIViewController {
    
    
    @IBOutlet weak var idTextField: UITextField!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    @IBOutlet weak var priceTextField: UITextField!
    
    
    @IBOutlet weak var providerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveTapped(_ sender: UIButton) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let product = Product(context: context)
            
            product.productID = Int64(idTextField.text ?? "0") ?? 0
            product.name = nameTextField.text
            product.productDescription = descriptionTextField.text
            product.price = Double(priceTextField.text ?? "0") ?? 0.0
            product.provider = providerTextField.text
            
            do {
                try context.save()
                print("Product saved!")
                
                navigationController?.popViewController(animated: true)
                
            } catch {
                print("Error saving product")
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
