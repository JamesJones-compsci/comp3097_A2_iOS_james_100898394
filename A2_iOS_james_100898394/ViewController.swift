//
//  ViewController.swift
//  A2_iOS_james_100898394
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var products: [Product] = []
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchProducts()
        
        // Insert default data ONLY if empty
        if products.count == 0 {
            insertDefaultProducts()
            fetchProducts()
        }
        
        displayProduct()
    }
    
    // CRITICAL: Refresh data when returning from Add screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchProducts()
        displayProduct()
    }
    
    // MARK: - Button Actions
    
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
        // Navigation handled via storyboard (Push segue)
    }
    
    @IBAction func searchTapped(_ sender: UIButton) {
        // Will implement later
    }
    
    @IBAction func listTapped(_ sender: UIButton) {
        // Will implement later
    }
    
    // MARK: - Core Data Functions
    
    func fetchProducts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            products = try context.fetch(request)
            print("Fetched \(products.count) products")
        } catch {
            print("Error fetching data")
        }
    }
    
    func displayProduct() {
        // Handle empty case
        if products.count == 0 {
            nameLabel.text = "No Products Found"
            descriptionLabel.text = ""
            priceLabel.text = ""
            providerLabel.text = ""
            idLabel.text = ""
            return
        }
        
        // Prevent index crash
        if currentIndex >= products.count {
            currentIndex = 0
        }
        
        let product = products[currentIndex]
        
        nameLabel.text = product.name ?? "N/A"
        descriptionLabel.text = product.productDescription ?? "N/A"
        priceLabel.text = "$\(product.price)"
        providerLabel.text = product.provider ?? "N/A"
        idLabel.text = "\(product.productID)"
        
        print("Displaying: \(product.name ?? "Unknown") at index \(currentIndex)")
    }
    
    func insertDefaultProducts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Prevent duplicate inserts
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        let count = (try? context.count(for: request)) ?? 0
        
        if count > 0 {
            return
        }
        
        let defaultProducts = [
            (1, "iPhone 15", "Latest Apple smartphone", 1299.99, "Apple"),
            (2, "Galaxy S23", "Samsung flagship phone", 1199.99, "Samsung"),
            (3, "MacBook Air", "Lightweight Apple laptop", 1499.99, "Apple"),
            (4, "Dell XPS 13", "Powerful ultrabook", 1399.99, "Dell"),
            (5, "iPad Pro", "High-performance tablet", 1099.99, "Apple"),
            (6, "Sony WH-1000XM5", "Noise-cancelling headphones", 499.99, "Sony"),
            (7, "Apple Watch", "Smart wearable device", 599.99, "Apple"),
            (8, "Google Pixel 8", "Google smartphone", 999.99, "Google"),
            (9, "HP Spectre x360", "Convertible laptop", 1599.99, "HP"),
            (10, "Amazon Echo", "Smart home speaker", 199.99, "Amazon")
        ]
        
        for item in defaultProducts {
            let product = Product(context: context)
            product.productID = Int64(item.0)
            product.name = item.1
            product.productDescription = item.2
            product.price = item.3
            product.provider = item.4
        }
        
        do {
            try context.save()
            print("Default products inserted!")
        } catch {
            print("Error saving default products")
        }
    }
}
