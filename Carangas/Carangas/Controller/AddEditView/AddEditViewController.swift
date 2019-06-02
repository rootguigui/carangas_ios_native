//
//  AddEditViewController.swift
//  Carangas
//
//  Created by Eric Brito.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    // MARK: ~ Properties
    let fipeURL = "https://fipeapi.appspot.com/api/1/carros/marcas.json"
    var car: Car!
    var brands: [Brands]? = []
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if car != nil {
            tfBrand.text = car.brand
            tfName.text = car.name
            tfPrice.text = String(car.price)
            scGasType.selectedSegmentIndex = car.gasType
            btAddEdit.setTitle("Alterar Carro", for: .normal)
        }
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.items = [btCancel, btSpace, btDone]
        tfBrand.inputAccessoryView = toolbar
        tfBrand.inputView = pickerView
        
        loadBrands()
    }
    
    // MARK: - IBActions
    @IBAction func addEdit(_ sender: UIButton) {
        
        sender.isEnabled = false
        sender.backgroundColor = .gray
        sender.alpha = 0.5
        loading.startAnimating()
        
        
        if car == nil {
            car = Car()
        }
        
        car.name = tfName.text!
        car.brand = tfBrand.text!
        car.price = Double(tfPrice.text ?? "0")!
        car.gasType = scGasType.selectedSegmentIndex
        
        if car._id == nil {
            REST.save(car: car) { (success) in
                self.goBack()
            }
        } else {
            REST.update(car: car) { (success) in
                self.goBack()
            }
        }
        

    }
    
    // MARK: ~ Methods
    func loadBrands() {
        FIPE.loadBrands(basePath: fipeURL) { (brands) in
            if let brands = brands {
                self.brands = brands.sorted(by: {$0.fipe_name < $1.fipe_name})
                DispatchQueue.main.async {
                    self.pickerView.reloadAllComponents()
                }
            }
        }
    }
    
    func goBack() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }

    @objc func cancel() {
        tfBrand.resignFirstResponder()
    }
    @objc func done() {
        tfBrand.text = brands![pickerView.selectedRow(inComponent: 0)].fipe_name
        cancel()
    }
}


