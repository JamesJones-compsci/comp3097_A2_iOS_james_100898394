//
//  ViewController.swift
//  A2_iOS_james_100898394
//
//  Created by Tech on 2026-04-04.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    
    @IBAction func previousTapped(_ sender: UIButton) {
        if currentIndex > 0 {
                currentIndex -= 1
                displayProduct()
            }
    }
    
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if currentIndex < products.count - 1 {
                currentIndex += 1
                displayProduct()
            }
    }
    
    
    @IBAction func addTapped(_ sender: UIButton) {
    }
    
    
    
    @IBAction func searchTapped(_ sender: UIButton) {
    }
    
    
    
    @IBAction func listTapped(_ sender: UIButton) {
    }
    
    
    var products: [Product] = []
    var currentIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
            displayProduct()
    }
    
    func fetchProducts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            products = try context.fetch(request)
        } catch {
            print("Error fetching data")
        }
    }
    
    func displayProduct() {
        if products.count > 0 {
            let product = products[currentIndex]
            
            nameLabel.text = product.name
            descriptionLabel.text = product.productDescription
            priceLabel.text = "$\(product.price)"
            providerLabel.text = product.provider
            idLabel.text = "\(product.productID)"
        }
    }


}

