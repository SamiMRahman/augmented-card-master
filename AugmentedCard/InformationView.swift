//
//  InformationView.swift
//  AugmentedCard
//
//  Created by Avi Arora on 8/21/19.
//  Copyright © 2019 Prayash Thapa. All rights reserved.
//

import UIKit

class InformationView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    var whatLabel: UILabel!
    var nameLabel: UILabel!
    var savingLabel: UILabel!
    var typeLabel: UILabel!
    var exitImage: UIImageView!
    var exitButton: UIButton!
    
    
    func setupView() {
        
        self.layer.cornerRadius = 8
        self.layer.backgroundColor = UIColor.white.cgColor
        
        whatLabel = UILabel(frame: CGRect(x: 12 , y: 12, width: self.frame.width - 24, height: 40))
        whatLabel.textColor = UIColor.black
        whatLabel.text = "What is this?"
        whatLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        whatLabel.textAlignment = .center

        self.addSubview(whatLabel)
        

        
    }
    
    
    
    func setName(name: String) {
        nameLabel = UILabel(frame: CGRect(x: 12 , y: self.whatLabel.frame.origin.y + self.whatLabel.frame.height + 8, width: self.frame.width - 24, height: 40))
        nameLabel.textColor = UIColor.black
        nameLabel.text = name
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        nameLabel.textAlignment = .center
        self.addSubview(nameLabel)
    }
    
    func setSaving(saving: String) {
        var cellWidth = (self.frame.width - 36) / 2
        savingLabel = UILabel(frame: CGRect(x: 12 , y: self.nameLabel.frame.origin.y + self.nameLabel.frame.height + 8, width: cellWidth, height: 40))
        savingLabel.textColor = UIColor.black
        savingLabel.text = saving
        savingLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        savingLabel.textAlignment = .center
        self.addSubview(savingLabel)
    }
    
    func setType(type: String) {
        var cellWidth = (self.frame.width - 36) / 2
        typeLabel = UILabel(frame: CGRect(x: self.savingLabel.frame.origin.x + self.savingLabel.frame.width + 12 , y: self.nameLabel.frame.origin.y + self.nameLabel.frame.height + 8, width: cellWidth, height: 40))
        typeLabel.textColor = UIColor.black
        typeLabel.text = type
        typeLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        typeLabel.textAlignment = .center
        self.addSubview(typeLabel)
    }
    
    
    
    
    
    
    
    
    
    
    
}
