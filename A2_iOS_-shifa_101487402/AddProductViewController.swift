//
//  AddProductViewController.swift
//  A2_iOS_-shifa_101487402
//
//  Created by Shifa Karnelia on 2026-04-07.
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
    title = "Add Product"
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
    guard let idText = idTextField.text, !idText.isEmpty,
    let id = Int64(idText),
    let name = nameTextField.text, !name.isEmpty,
    let description = descriptionTextField.text, !description.isEmpty,
    let priceText = priceTextField.text, !priceText.isEmpty,
    let price = Double(priceText),
    let provider = providerTextField.text, !provider.isEmpty else {
    showAlert(message: "Please fill all fields correctly.")
    return
    }

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let product = Product(context: context)

    product.productID = id
    product.productName = name
    product.productDescription = description
    product.productPrice = price
    product.productProvider = provider

    do {
    try context.save()
    navigationController?.popViewController(animated: true)
    } catch {
    print("Save error: \(error)")
    showAlert(message: "Failed to save product.")
    }
    }

    func showAlert(message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
    }

 
}
