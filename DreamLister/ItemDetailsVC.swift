//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Paul on 25/07/2017.
//  Copyright © 2017 Technicae. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var thumbImg: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item? //the ? signified an optional variable
    var imagePicker: UIImagePickerController!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //the custom code below removes the "DreamLister" text on the Add/Edit details screen 'back' item to just an arrow
        //don't forget to set the custom class as this 'ItemDetailsVC' otherwise the code below won't work!
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
//        let store = Store(context: context)
//        store.name = "Best Buy"
//        let store2 = Store(context: context)
//        store2.name = "Tesla Dealership"
//        let store3 = Store(context: context)
//        store3.name = "Amazon"
//        let store4 = Store(context: context)
//        store4.name = "MobileFun"
//        let store5 = Store(context: context)
//        store5.name = "Apple"
//        let store6 = Store(context: context)
//        store6.name = "Ebay"
//        
//        ad.saveContext()
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // this is how many columns
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // update when selected
    }

    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            // handle the error
            
        }
        
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        //here is where we will take the user entered new item (including photo and store) and save to core data
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImg.image
        

        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            item.title = title
        }
        
        //remember price is stated as a double in the core data store so we us NSString to convert string to double
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
    
        if let details = detailsField.text {
            item.details = details
        }
        // the .tostore text below references the relationship we created in coredata
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            
            thumbImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while (index < stores.count)
            }
        }
    }
    
    
    @IBAction func deletePressed(_ sender: Any) {
        
        // check there is an item to delete, then delete it
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addImage(_ sender: UIButton) {
        
        
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImg.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
}
