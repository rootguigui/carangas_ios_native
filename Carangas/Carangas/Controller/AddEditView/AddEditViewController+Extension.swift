//
//  AddEditViewExtension.swift
//  Carangas
//
//  Created by gui on 01/06/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import UIKit

extension AddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return brands?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let brand = brands?[row]
        return brand?.fipe_name
    }
}
