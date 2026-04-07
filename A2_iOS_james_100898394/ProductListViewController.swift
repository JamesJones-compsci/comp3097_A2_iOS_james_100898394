//
//  ProductListViewController.swift
//  A2_iOS_james_100898394
//
//  Created by Tech on 2026-04-07.
//

import UIKit
import CoreData

// MARK: - Main Class
class ProductListViewController: UIViewController {
    
    // Connect your TableView from Storyboard
    @IBOutlet weak var tableView: UITableView!
    
    // Array to store fetched products
    var products: [Product] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // Fetch products from Core Data
        fetchProducts()
        
        // Optional: set the screen title (also possible in Storyboard)
        self.title = "Product List"
    }
    
    // MARK: - Core Data Fetch
    func fetchProducts() {
        // Get the Core Data context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Create a fetch request for Product entities
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            // Fetch products and reload the table view
            products = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print("Error fetching products: \(error)")
        }
    }
}

// MARK: - UITableView DataSource & Delegate
extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Return number of rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    // Configure each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Dequeue reusable cell or create a new one
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "ProductCell")

        // Get product for this row
        let product = products[indexPath.row]

        // Set main text and subtitle
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.productDescription

        return cell
    }
    
    // Optional: handle row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO: Add action when product is tapped
        print("Tapped product: \(products[indexPath.row].name ?? "Unknown")")
    }
}

