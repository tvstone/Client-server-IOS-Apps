
import UIKit
import Kingfisher

class FotoCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var fotoImageView: UIImageView!


    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeButtom: UIButton!
    @IBOutlet weak var likeCounter: UILabel!



    var isLiked = false
    var likeCounterInt = 0

    func animateLike() {

        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 100
        animation.mass = 1
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        likeImageView.layer.add(animation, forKey: nil)

    }




    func setupCell(){

    }

    func clearCell() {

        fotoImageView.image = nil
    }

    override func prepareForReuse() {
        clearCell()
    }




    override func awakeFromNib() {
        super.awakeFromNib()
       setupCell()
       clearCell()
        likeImageView.image = UIImage(systemName: "heart")

        likeCounter.text = String(likeCounterInt)
        likeCounter.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    }

    @IBAction func likeClikButtom(_ sender: UIButton) {

        if isLiked {

            likeImageView.image = UIImage(systemName: "heart")
            likeCounterInt -= 1
            likeCounter.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        }
        else {

            likeImageView.image = UIImage(systemName: "heart.fill")
            likeCounterInt += 1
            likeCounter.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            animateLike()


        }

  //      likeCounter.text = String(likeCounterInt)

        isLiked = !isLiked

    }

}


