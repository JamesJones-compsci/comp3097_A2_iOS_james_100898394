//
//  SearchViewController.swift
//  A2_iOS_james_100898394
//
//  Created by Tech on 2026-04-06.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    
    var results: [Product] = []
    var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Search screen loaded!")
    }

    @IBAction func searchTapped(_ sender: UIButton) {
        
        guard let searchText = searchTextField.text, !searchText.isEmpty else {
            nameLabel.text = "Enter search text"
            descriptionLabel.text = ""
            priceLabel.text = ""
            providerLabel.text = ""
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        request.predicate = NSPredicate(
            format: "name CONTAINS[c] %@ OR productDescription CONTAINS[c] %@",
            searchText,
            searchText
        )
        
        do {
            results = try context.fetch(request)
            
            if results.count > 0 {
                currentIndex = 0
                displayResult()
            } else {
                nameLabel.text = "No Results"
                descriptionLabel.text = ""
                priceLabel.text = ""
                providerLabel.text = ""
            }
            
        } catch {
            print("Search failed")
        }
    }
    
    func displayResult() {
        
        if results.count == 0 {
            return
        }
        
        let product = results[currentIndex]
        
        nameLabel.text = product.name ?? "N/A"
        descriptionLabel.text = product.productDescription ?? "N/A"
        priceLabel.text = "$\(product.price)"
        providerLabel.text = product.provider ?? "N/A"
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if currentIndex < results.count - 1 {
            currentIndex += 1
            displayResult()
        }
    }
    
    @IBAction func previousTapped(_ sender: UIButton) {
        if currentIndex > 0 {
            currentIndex -= 1
            displayResult()
        }
    }
}
