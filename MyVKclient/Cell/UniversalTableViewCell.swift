//
//  UniversalTableViewCell.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit

class UniversalTableViewCell: UITableViewCell {

    
    @IBOutlet weak var universalImage: UIImageView!
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var universalTitleLabel: UILabel!
    
    var saveObject : Any?
    
    
    func setupCell(){
        backview.layer.cornerRadius = 25
        universalImage.layer.cornerRadius = 25
        
        backview.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        backview.layer.shadowOffset = CGSize(width: 5, height: 5)
        backview.layer.shadowRadius = 5
        backview.layer.shadowOpacity = 0.5
        
    }
    func clearCell(){
        self.universalImage.image = nil
        self.universalTitleLabel.text = nil
        self.saveObject = nil
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        clearCell()
      
    }

    func configureCell (title : String?, image : UIImage?) {
        universalTitleLabel.text = title
        universalImage.image = image
        
    }

    func configureCell (user : friend) {
        saveObject = user
        universalTitleLabel.text = user.nameFriend
        universalImage.image = user.avaFriend
    }
    
    func configureCell (group : groupFriends) {
        saveObject = group
        universalTitleLabel.text = group.titleGroup
        universalImage.image = group.avaGroup
    }
    
    
    
    
    
}


