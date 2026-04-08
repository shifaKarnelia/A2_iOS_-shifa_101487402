//
//  ProductListViewController.swift
//  A2_iOS_-shifa_101487402
//
//  Created by Shifa Karnelia on 2026-04-08.
//

import CoreData
import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!

       var products: [Product] = []

       override func viewDidLoad() {
           super.viewDidLoad()
           title = "Product List"
           tableView.dataSource = self
           tableView.delegate = self
           tableView.isScrollEnabled = true
           fetchProducts()
       }

       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           fetchProducts()
       }

       func fetchProducts() {
           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           let request: NSFetchRequest<Product> = Product.fetchRequest()

           do {
               products = try context.fetch(request)
               tableView.reloadData()
           } catch {
               print("Fetch list error: \\(error)")
           }
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return products.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

           let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")

           let product = products[indexPath.row]
           cell.textLabel?.text = product.productName ?? ""
           cell.detailTextLabel?.text = product.productDescription ?? ""

           return cell
       }

    
}
