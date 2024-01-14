//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 29.06.2023.
//

import UIKit

class GFAlertVC: UIViewController {

    let contianerView = GFAlertContainerView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }

    
    func configureContainerView() {
        view.addSubview(contianerView)
        
        NSLayoutConstraint.activate([
            contianerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contianerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contianerView.widthAnchor.constraint(equalToConstant: 280),
            contianerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        contianerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contianerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contianerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contianerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton() {
        contianerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: contianerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: contianerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: contianerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel() {
        contianerView.addSubview(messageLabel)
        messageLabel.text = message ?? "No message"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: contianerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: contianerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    
   @objc func dismissVC() {
        dismiss(animated: true)
    }
}
