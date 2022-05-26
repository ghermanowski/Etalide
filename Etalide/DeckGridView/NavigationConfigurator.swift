//
//  NavigationConfigurator.swift
//  Etalide
//
//  Created by Diego Castro on 26/05/22.
//
import Foundation
import SwiftUI

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configuration: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let newColor = uiViewController.navigationController {
            self.configuration(newColor)
        }
    }

}
