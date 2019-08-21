//
//  infoView.swift
//  AugmentedCard
//
//  Created by Rahman, Sami M on 7/18/19.
//  Copyright © 2019 Prayash Thapa. All rights reserved.
//

import UIKit
import Foundation

class infoView: UIView {
    
    var infoView: UIView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var saveText: UILabel!
    var typeText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //bubbleView.clipsToBounds = true   // COMMENTED OUT TO STOP ERRORS FROM APP DELEGATE CHANGES
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //infoView.layer.cornerRadius = infoView.layer.bounds.height / 2  // COMMENTED OUT TO STOP ERRORS FROM APP DELEGATE CHANGES
    }
}
