//
//  ViewController.swift
//  A2_iOS_-shifa_101487402
//
//  Created by Shifa Karnelia on 2026-04-05.
//
import UIKit
import CoreData

class ViewController: UIViewController ,UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var productIDValueLabel: UILabel!
    @IBOutlet  weak var productNameValueLabel: UILabel!

    @IBOutlet weak var productDescriptionValueLabel: UILabel!
    @IBOutlet weak var productPriceValueLabel: UILabel!
    @IBOutlet weak var productProviderValueLabel: UILabel!
   
    var products: [Product] = []
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        insertSampleProductsIfNeeded()
        fetchProducts()
        showCurrentProduct()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
        if currentIndex >= products.count {
            currentIndex = 0
        }
        showCurrentProduct()
    }

    func fetchProducts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Product> = Product.fetchRequest()

        do {
            products = try context.fetch(request)
            print("Products count: \(products.count)")
        } catch {
            print("Fetch error: \(error)")
        }
    }

    func showCurrentProduct() {
        guard !products.isEmpty else {
            productIDValueLabel.text = "-"
            productNameValueLabel.text = "No products"
            productDescriptionValueLabel.text = "-"
            productPriceValueLabel.text = "-"
            productProviderValueLabel.text = "-"
            return
        }

        let product = products[currentIndex]
        productIDValueLabel.text = "\(product.productID)"
        productNameValueLabel.text = product.productName ?? ""
        productDescriptionValueLabel.text = product.productDescription ?? ""
        productPriceValueLabel.text = "$\(product.productPrice)"
        productProviderValueLabel.text = product.productProvider ?? ""
    }

    func insertSampleProductsIfNeeded() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Product> = Product.fetchRequest()

        do {
            let count = try context.count(for: request)
            if count == 0 {
                let sampleProducts: [(Int64, String, String, Double, String)] = [
                    (1, "Laptop", "15-inch laptop", 1200.00, "Dell"),
                    (2, "Mouse", "Wireless mouse", 25.00, "Logitech"),
                    (3, "Keyboard", "Mechanical keyboard", 80.00, "HP"),
                    (4, "Monitor", "24-inch monitor", 220.00, "Samsung"),
                    (5, "Printer", "Inkjet printer", 150.00, "Canon"),
                    (6, "Phone", "128GB smartphone", 799.00, "Apple"),
                    (7, "Tablet", "10-inch tablet", 450.00, "Samsung"),
                    (8, "Speaker", "Bluetooth speaker", 65.00, "JBL"),
                    (9, "Headphones", "Noise-cancelling", 199.00, "Sony"),
                    (10, "Webcam", "HD webcam", 55.00, "Logitech")
                ]

                for item in sampleProducts {
                    let product = Product(context: context)
                    product.productID = item.0
                    product.productName = item.1
                    product.productDescription = item.2
                    product.productPrice = item.3
                    product.productProvider = item.4
                }

                try context.save()
            }
        } catch {
            print("Insert sample error: \(error)")
        }
    }

    @IBAction func previousButtonTapped(_ sender: UIButton) {
        if currentIndex > 0 {
            currentIndex -= 1
            showCurrentProduct()
        }
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentIndex < products.count - 1 {
            currentIndex += 1
            showCurrentProduct()
        }
    }
}


    

