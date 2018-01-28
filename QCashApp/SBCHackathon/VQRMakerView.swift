//
//  VQRMakerView.swift
//  SBCHackathon
//
//  Created by Carlos Uribe on 27/01/18.
//  Copyright © 2018 QCash. All rights reserved.
//

import UIKit

class VQRMakerView:UIView, UITextFieldDelegate{

    weak var controller:CQRMakerController!
    weak var qrView:UIImageView!
    weak var priceField:UITextField!
    weak var generateButton:UIButton!
    weak var cancelButton:UIButton!
    private weak var tapGesture:UITapGestureRecognizer!
    private var qrcodeImage:CIImage!

    init(controller:CQRMakerController){
        super.init(frame:.zero)
        self.controller = controller

        let qrView:UIImageView = UIImageView()
        qrView.clipsToBounds = true
        qrView.translatesAutoresizingMaskIntoConstraints = false
        self.qrView = qrView

        let textLabel:UILabel = UILabel()
        textLabel.clipsToBounds = true
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.boldSystemFont(ofSize: 18)
        textLabel.backgroundColor = .white
        textLabel.textAlignment = .center
        textLabel.text = "Escribe la cantidad a cobrar"

        let priceField:UITextField = UITextField()
        priceField.clipsToBounds = true
        priceField.translatesAutoresizingMaskIntoConstraints = false
        priceField.font = UIFont.boldSystemFont(ofSize: 18)
        priceField.keyboardType = .decimalPad
        priceField.layer.cornerRadius = 8.0
        priceField.textAlignment = .center
        priceField.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        self.priceField = priceField

        let generateButton:UIButton = UIButton()
        generateButton.clipsToBounds = true
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        generateButton.setTitle("Generar", for: .normal)
        generateButton.layer.cornerRadius = 8.0
        generateButton.backgroundColor = UIColor(red:0.13, green:0.71, blue:0.12, alpha:1.0)
        generateButton.addTarget(self,
                                action: #selector(generateQR(sender:)),
                                for: .touchUpInside)
        self.generateButton = generateButton

        let cancelButton:UIButton = UIButton()
        cancelButton.clipsToBounds = true
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Salir", for: .normal)
        cancelButton.layer.cornerRadius = 8.0
        cancelButton.backgroundColor = UIColor(red:0.71, green:0.12, blue:0.36, alpha:1.0)
        cancelButton.addTarget(self,
                                 action: #selector(cancelTransaction(sender:)),
                                 for: .touchUpInside)
        self.cancelButton = cancelButton

        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target:self,
            action:#selector(resignField))
        self.tapGesture = tapGesture

        addGestureRecognizer(tapGesture)

        addSubview(qrView)
        addSubview(textLabel)
        addSubview(priceField)
        addSubview(generateButton)
        addSubview(cancelButton)

        let views:[String : UIView] = [
            "qrView":qrView,
            "textLabel":textLabel,
            "priceField":priceField,
            "generateButton":generateButton,
            "cancelButton":cancelButton]

        let metrics:[String : CGFloat] = [:]

        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-80-[qrView]-80-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-40-[qrView(140)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-20-[textLabel]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[qrView]-10-[textLabel(30)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-40-[priceField]-40-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[textLabel]-20-[priceField(50)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-40-[cancelButton(80)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[generateButton(80)]-40-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[priceField]-20-[generateButton(40)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[priceField]-20-[cancelButton(40)]",
            options:[],
            metrics:metrics,
            views:views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)

        return allowedCharacters.isSuperset(of: characterSet)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        priceField.resignFirstResponder()

        return true
    }

    @objc func generateQR(sender: UIButton){
        if qrcodeImage == nil {
            if priceField.text == "" {
                return
            }

            let data = priceField.text?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)

            let filter = CIFilter(name: "CIQRCodeGenerator")

            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")

            qrcodeImage = filter?.outputImage

            priceField.resignFirstResponder()

            displayQRCodeImage()
        }
        else {
            qrView.image = nil
            qrcodeImage = nil
        }

        priceField.isEnabled = !priceField.isEnabled
    }

    @objc func resignField(){
        if priceField.isFirstResponder{
            priceField.resignFirstResponder()
        }
    }

    func displayQRCodeImage() {
        let scaleX = qrView.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = qrView.frame.size.height / qrcodeImage.extent.size.height

        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

        qrView.image = UIImage.init(ciImage: transformedImage)
    }

    @objc func cancelTransaction(sender: UIButton){
        controller.parentController.setMainMenu()
    }
}
