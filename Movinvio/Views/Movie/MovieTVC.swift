//
//  MovieTVC.swift
//  Movinvio
//
//  Created by Ezgi Üstünel on 4.06.2022.
//

import UIKit
import Kingfisher

class MovieTVC: UITableViewCell {
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Data
    func setData(_ movieVM: MovieVM) {
        titleLabel.text = movieVM.title
        genreLabel.text = movieVM.genre
        detailLabel.text = movieVM.detail
        imageLogo.kf.setImage(with: URL(string: movieVM.posterURL))
    }
}
