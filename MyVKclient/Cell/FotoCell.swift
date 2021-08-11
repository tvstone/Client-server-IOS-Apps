//
//  FotoCell.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit

class FotoCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var fotoImageView: UIImageView!
    
    func setupCell(){
        
    }
    
    func clearCell() {
        
        fotoImageView.image = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func config (image: UIImage){
        fotoImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setupCell()
       clearCell()
    }

}
