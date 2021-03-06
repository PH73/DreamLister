//
//  MaterialView.swift
//  DreamLister
//
//  Created by Paul on 27/06/2017.
//  Copyright © 2017 Technicae. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIView {
        
        @IBInspectable var materialDesign: Bool {
            
            get {
                
                
                return materialKey
            }
            
            set {
            
                materialKey = newValue
                
                // The if statement below is followed if TRUE - no need to specify true, it's the default!
                if materialKey {
                    self.layer.masksToBounds = false
                    self.layer.cornerRadius = 3.0
                    self.layer.shadowOpacity = 0.8
                    self.layer.shadowRadius = 3.0
                    self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                    self.layer.shadowColor = UIColor(colorLiteralRed: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
                } else {
                
                    self.layer.cornerRadius = 0
                    self.layer.shadowOpacity = 0
                    self.layer.shadowRadius = 0
                    self.layer.shadowColor = nil
                }
            }
        
        }

}
