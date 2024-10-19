//
//  LoginViewModel.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 14.10.2024.
//

import Foundation


class LoginViewModel {
    
    enum ValidationType {
        case name
        case lastName
        case birthDate
        case password
        case confirmPassword
    }
    
    var onValidationResult: ((ValidationType, Bool, String?) -> Void)?
    var onAllFieldsValid: ((Bool) -> Void)?
    var navigateToNextScreen: (()-> Void)?
    
    private var originalPassword: String?
    private var userName: String = ""
    
    private var isNameValid = false
    private var isLastNameValid = false
    private var isDateValid = false
    private var isPasswordValid = false
    private var isConfirmPasswordValid = false
    
    func validateInput(_ input: String?, for type: ValidationType) {
        var isValid = false
        var errorMessage: String?
        
        switch type {
            
        case .name:
            isValid = validateName(input)
            errorMessage = isValid ? nil : "Имя должно содержать не менее двух символов и начинаться с заглавной буквы"
            isNameValid = isValid
            if isValid {
                userName = input!
            }
            
        case .lastName:
            isValid = validateName(input)
            errorMessage = isValid ? nil : "Фамилия должна содержать не менее двух символов и начинаться с заглавной буквы"
            isLastNameValid = isValid
            
        case .birthDate:
            isValid = validateDate(input)
            errorMessage = isValid ? nil : "Допустимый возраст от 18 до 52 лет"
            isDateValid = isValid
            
        case .password:
            isValid = validatePassword(input)
            errorMessage = isValid ? nil : "Пароль должен содержать минимум 8 симовлов где обязательно присутствует цифра и одна заглавная буква "
            isPasswordValid = isValid
            if isValid {
                originalPassword = input
            }
            
        case .confirmPassword:
            isValid = validateConfirmPassword(input)
            errorMessage = isValid ? nil : "Пароли не совпадают"
            isConfirmPasswordValid = isValid
        }
        onValidationResult?(type, isValid, errorMessage)
        
        checkAllFields()
    }
    
    func onButtonTapped() {
        navigateToNextScreen?()
        let user = User(context: CoreDataManager.shared.context)
        user.name = userName
        CoreDataManager.shared.saveContext()
    }
    
    private func validateName(_ name: String?) -> Bool {
        guard let name = name, name.count >= 2, name.first?.isUppercase == true else { return false }
        return true
    }
    
    private func validateDate(_ dateString: String?) -> Bool {
        
        guard let dateString = dateString else { return false }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        guard let selectedDate = dateFormatter.date(from: dateString) else { return false }
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        let ageComponents = calendar.dateComponents([.year], from: selectedDate, to: currentDate)
        guard let age = ageComponents.year else { return false }
        
        return age >= 18 && age < 53
    }
    
    private func validatePassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        return password.count >= 8 && password.rangeOfCharacter(from: .uppercaseLetters) != nil && password.rangeOfCharacter(from: .decimalDigits) != nil
        
    }
    
    private func validateConfirmPassword(_ confirmPassword: String?) -> Bool {
        guard let confirmPassword = confirmPassword else { return false }
        return confirmPassword == originalPassword
    }
    
    private func checkAllFields() {
        let allFieldsValid = isNameValid && isLastNameValid && isDateValid && isPasswordValid && isPasswordValid && isConfirmPasswordValid
        onAllFieldsValid?(allFieldsValid)
    }
}
