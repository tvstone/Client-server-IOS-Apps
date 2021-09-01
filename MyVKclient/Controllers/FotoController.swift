//
//  FotoController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class FotoController: UICollectionViewController {

    var fotoArray = [String]()
    var likeFoto = [String]()

    var FullSizeViewControllerID = "FullSizeViewControllerID"
    var countCells = 3
    var offSetCell = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(fotoArray)
        print(likeFoto)
        self.collectionView.register(UINib(nibName: "FotoCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return fotoArray.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? FotoCell
                                                            else { return UICollectionViewCell()}

        cell.fotoImageView.kf.setImage(with: URL(string: fotoArray[indexPath.item] ))
        cell.likeCounter.text = likeFoto[indexPath.item]
      


        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: FullSizeViewControllerID) as! FullSizeViewController

        vc.friendsArray = fotoArray
        vc.indexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FotoController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let speacing = ((countCells + 1) * offSetCell) / countCells
        let widthCell = frameCV.width / CGFloat(countCells)-CGFloat(speacing)
        let heightCell = widthCell
        
        return CGSize(width: widthCell, height: heightCell)
    }
}
