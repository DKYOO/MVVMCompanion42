//
//  ViewController.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 20/11/2022.
//

import UIKit

class SearchViewController: UIViewController, ProfileViewControllerProtocol {
	
	var userName: String?
	
	let searchTextField: UITextField = {
		let search = UITextField()
		search.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		search.textColor = .white
		search.placeholder = "Search ..."
		search.backgroundColor = .lightGray
		search.alpha = 0.85
		search.keyboardType = UIKeyboardType.default
		search.returnKeyType = UIReturnKeyType.done
		search.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		search.autocorrectionType = UITextAutocorrectionType.no
		search.borderStyle = UITextField.BorderStyle.roundedRect
		search.clearButtonMode = UITextField.ViewMode.whileEditing;
		search.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
		search.autocapitalizationType = .none
		search.returnKeyType = .go
		search.translatesAutoresizingMaskIntoConstraints = false
		return search
	}()
	
	let searchButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .purple
		button.setTitle("Find Companion42", for: .normal)
		button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		searchTextField.delegate = self
		setupView()
	}
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		searchButton.isOpaque = false
		searchButton.layer.cornerRadius = searchButton.frame.size.width / 2
	}
	
	//MARK: - Methods
	private func setupView() {
		view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
		view.addSubview(searchTextField)
		view.addSubview(searchButton)
		setupConstraints()
	}
	
	@objc func searchButtonPressed() {
		let profileViewController = ProfileViewController()
		userName = searchTextField.text?.lowercased()
		profileViewController.delegate = self
		userName == "" ? showAllert() : self.navigationController?.pushViewController(profileViewController, animated: true)
		print("Search Success")
		
	}
	
	private func showAllert() {
		
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			
			searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
			searchTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
			searchTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
			searchTextField.heightAnchor.constraint(equalToConstant: 50),
			
			searchButton.heightAnchor.constraint(equalToConstant: 200),
			searchButton.widthAnchor.constraint(equalToConstant: 200),
			searchButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			searchButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
			
		])
	}
	
}

extension SearchViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		searchTextField.endEditing(true)
		guard let text = searchTextField.text else {
			return false
		}
		print (text)
		return true
	}
	
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		//TODO: Use Guard 😎
		if textField.text != "" {
			return true
		} else {
			textField.placeholder = "Type something"
			return false
		}
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		
		if let user = searchTextField.text?.lowercased() {
			UserDefaults.standard.setValue(user, forKey: "user")
		}
		searchTextField.text = ""
	}
}
