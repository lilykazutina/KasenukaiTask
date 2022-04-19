//
//  Alert.swift
//  KeskoSenukaiDigitalTask

import UIKit

class Alert {

    func showAlert(title:String, errorMessage: String, presenter: UIViewController) {
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        presenter.present(alert, animated: true)
    }
}
