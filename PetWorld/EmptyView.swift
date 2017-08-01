//
//  EmptyView.swift
//  PetWorld
//
//  Created by my mac on 8/1/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

@IBDesignable
class EmptyView: UIView {
    
    
    
    @IBOutlet var backgroundView: UIView!
    
    var onSuggestionTapped: ((UIButton)->(Void))?
    
    @IBInspectable
    var displayImage: UIImage?{
        didSet{
            imageDisplayImageView.image = displayImage
        }
    }
    
    @IBInspectable
    var titleText: String?{
        didSet{
            titleTextLabel.text = titleText
        }
    }
    
    
    @IBInspectable
    var informationText: String?{
        didSet{
            informationTextLabel.text = informationText
        }
    
    }
    
    
    @IBInspectable
    var suggestionText: String?{
        didSet{
            suggestionButton.setTitle(suggestionText, for: UIControlState.normal)
        }
    }
    
    
    
    @IBOutlet weak var imageDisplayImageView: UIImageView!

    @IBOutlet weak var titleTextLabel: UILabel!
    
    @IBOutlet weak var informationTextLabel: UILabel!
    
    
    @IBOutlet weak var suggestionButton: UIButton!
    
    
    
    
    @IBAction func onSuggestionButtonTapped(_ sender: AnyObject) {
        
        let button  = sender as! UIButton
        onSuggestionTapped?(button)
    }
    
    
    func setupView(){
        UINib(nibName: "EmptyView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil)
        addSubview(backgroundView)
        backgroundView.frame = self.bounds
    }

}
