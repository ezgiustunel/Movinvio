//
//  MovieDetailVC.swift
//  Movinvio
//
//  Created by Ezgi Üstünel on 4.06.2022.
//

import UIKit
import Kingfisher
import GoogleMobileAds

final class MovieDetailVC: UIViewController, GADBannerViewDelegate {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var bannerV: UIView!
    
    var bannerView: GADBannerView!
    var movie: MovieVM?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.systemOrange
        self.navigationItem.title = movie?.title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemOrange]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        genreLabel.text = movie?.genre
        detailLabel.text = movie?.detail
    
        if let posterUrl = movie?.posterURL {
            mainImage.kf.setImage(with: URL(string: posterUrl))
        }
        setupAd()
    }
    
    private func setupAd() {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerV.addSubview(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    // MARK: - GADBannerViewDelegate
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("bannerViewDidReceiveAd")
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillPresentScreen")
    }
    
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillDIsmissScreen")
    }
    
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewDidDismissScreen")
    }
}
