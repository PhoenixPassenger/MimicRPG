//
//  CharacterAttributesT20.swift
//  MimicRPG
//
//  Created by Gustavo Lemos on 23/09/21.
//

import UIKit

class CharacterAttributesT20: UIView {

    let attributeFORT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "FOR", value: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    init(){
        super.init(frame: .zero)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configureLayout(){
        self.addSubview(attributeFORT20)
        
        NSLayoutConstraint.activate([
            
            //attributeFORT20.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            attributeFORT20.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            attributeFORT20.topAnchor.constraint(equalTo: super.topAnchor, constant: 9),
            ])

    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
