//
//  ViewController.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 14.10.2024.
//

import UIKit

class LoginViewController: UIViewController {

    private let contentView : LoginView = .init()
    private let viewModel = LoginViewModel()
    private let navigator : AppNavigator
    
    init(navigator: AppNavigator) {
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
        view.backgroundColor = .lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.delegate = self
        setupValidation()
        
        navigateToMainScreen()
    }
    
    private func setupValidation() {
        viewModel.onAllFieldsValid = { [weak self] allFieldsValid in
            DispatchQueue.main.async {
                self?.contentView.registerButton.isHidden = !allFieldsValid
                self?.contentView.registerButton.isEnabled = allFieldsValid
            }
        }
        
        viewModel.onValidationResult = { [weak self] type, isValid, errorMessage in
            
            guard let self = self else { return }
            
            switch type {
            case .name:
                self.contentView.nameCheck.isHidden = !isValid
                self.contentView.nameLabel.text = errorMessage
                self.contentView.nameLabel.isHidden = errorMessage == nil
                
            case .lastName:
                self.contentView.lastNameCheck.isHidden = !isValid
                self.contentView.lastNameLabel.text = errorMessage
                self.contentView.lastNameLabel.isHidden = errorMessage == nil
                
            case .birthDate:
                self.contentView.dateCheck.isHidden = !isValid
                self.contentView.dateLabel.text = errorMessage
                self.contentView.dateLabel.isHidden = errorMessage == nil
                
            case .password:
                self.contentView.passwordCheck.isHidden = !isValid
                self.contentView.passwordLabel.text = errorMessage
                self.contentView.passwordLabel.isHidden = errorMessage == nil
                self.contentView.confirmPasswordTextField.isEnabled = isValid
                self.contentView.confirmPasswordTextField.isHidden = !isValid
                
            case .confirmPassword:
                self.contentView.confirmPasswordCheck.isHidden = !isValid
                self.contentView.confirmPasswordLabel.text = errorMessage
                self.contentView.confirmPasswordLabel.isHidden = errorMessage == nil
                
            }
        }
    }
    
    private func navigateToMainScreen() {
        viewModel.navigateToNextScreen = { [weak self] in
            self?.navigator.navigateToTableScreen()
        }
    }
}

extension LoginViewController: LoginViewDelegate {
    func nameEdited(with name: String?) {
        viewModel.validateInput(name, for: .name)
    }
    func lastNameEdited(with lastName: String?) {
        viewModel.validateInput(lastName, for: .lastName)
    }
    
    func dateOfBirthEdited(with date: String?) {
        viewModel.validateInput(date, for: .birthDate)
    }
    func passwordEdited(with password: String?) {
        viewModel.validateInput(password, for: .password)
    }
    func confirmPasswordEdited(with confirmPassword: String?) {
        viewModel.validateInput(confirmPassword, for: .confirmPassword)
    }
    
    func didTapRegister() {
        viewModel.onButtonTapped()
    }
}


