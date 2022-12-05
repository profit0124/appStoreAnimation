//
//  PresentViewController.swift
//  AppStoreAnimation
//
//  Created by Sooik Kim on 2022/12/06.
//

import UIKit

class PresentViewController: UIViewController {

    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    } ()
    
    let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let dismissButton: UIButton = {
        let button = UIButton()
//        button.backgroundColor = .white
        button.setTitle("Dismiss", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 3
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dismissButton)
        view.addSubview(textView)
        view.addSubview(imageView)
        setupImageView()
        setuptextView()
        setupButton()
    }
    
    private func setupImageView() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.width * 1.2)
        ])
    }
    
    private func setuptextView() {
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -66)
        ])
    }
    
    private func setupButton() {
        dismissButton.addTarget(self, action: #selector(dismissButtonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: textView.bottomAnchor),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    func setupData(text: String, image: UIImage) {
        textView.text = text
        imageView.image = image
    }
    
    @objc private func dismissButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension PresentViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimator(animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimator(animationType: .dismiss)
    }
}
