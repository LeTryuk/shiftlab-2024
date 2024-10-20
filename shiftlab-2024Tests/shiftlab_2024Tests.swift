//
//  shiftlab_2024Tests.swift
//  shiftlab-2024Tests
//
//  Created by Тимур Осокин on 14.10.2024.
//

import XCTest
@testable import shiftlab_2024


final class shiftlab_2024Tests: XCTestCase {

    var viewModel: LoginViewModel!

        override func setUp() {
            super.setUp()
            viewModel = LoginViewModel()
        }

        override func tearDown() {
            viewModel = nil
            super.tearDown()
        }

        func testValidateName_Valid() {
            let expectation = self.expectation(description: "Validation result for valid name")
            viewModel.onValidationResult = { fieldType, isValid, errorMessage in
                XCTAssertEqual(fieldType, .name)
                XCTAssertTrue(isValid)
                XCTAssertNil(errorMessage)
                expectation.fulfill()
            }
            viewModel.validateInput("Имя", for: .name)
            waitForExpectations(timeout: 1, handler: nil)
        }

        func testValidateName_Invalid() {
            let expectation = self.expectation(description: "Validation result for invalid name")
            viewModel.onValidationResult = { fieldType, isValid, errorMessage in
                XCTAssertEqual(fieldType, .name)
                XCTAssertFalse(isValid)
                XCTAssertEqual(errorMessage, "Имя должно содержать не менее двух символов и начинаться с заглавной буквы")
                expectation.fulfill()
            }
            viewModel.validateInput("и", for: .name)
            waitForExpectations(timeout: 1, handler: nil)
        }

        func testValidatePassword_Valid() {
            let expectation = self.expectation(description: "Validation result for valid password")
            viewModel.onValidationResult = { fieldType, isValid, errorMessage in
                XCTAssertEqual(fieldType, .password)
                XCTAssertTrue(isValid)
                XCTAssertNil(errorMessage)
                expectation.fulfill()
            }
            viewModel.validateInput("Password1", for: .password)
            waitForExpectations(timeout: 1, handler: nil)
        }

        func testValidatePassword_Invalid() {
            let expectation = self.expectation(description: "Validation result for invalid password")
            viewModel.onValidationResult = { fieldType, isValid, errorMessage in
                XCTAssertEqual(fieldType, .password)
                XCTAssertFalse(isValid)
                XCTAssertEqual(errorMessage, "Пароль должен содержать минимум 8 симовлов где обязательно присутствует цифра и одна заглавная буква ")
                expectation.fulfill()
            }
            viewModel.validateInput("pass", for: .password)
            waitForExpectations(timeout: 1, handler: nil)
        }

        func testValidateConfirmPassword_Valid() {
            viewModel.validateInput("Password1", for: .password)
            
            let expectation = self.expectation(description: "Validation result for valid confirm password")
            viewModel.onValidationResult = { fieldType, isValid, errorMessage in
                XCTAssertEqual(fieldType, .confirmPassword)
                XCTAssertTrue(isValid)
                XCTAssertNil(errorMessage)
                expectation.fulfill()
            }
            viewModel.validateInput("Password1", for: .confirmPassword)
            waitForExpectations(timeout: 1, handler: nil)
        }

        func testValidateConfirmPassword_Invalid() {
            viewModel.validateInput("Password1", for: .password)
            
            let expectation = self.expectation(description: "Validation result for invalid confirm password")
            viewModel.onValidationResult = { fieldType, isValid, errorMessage in
                XCTAssertEqual(fieldType, .confirmPassword)
                XCTAssertFalse(isValid)
                XCTAssertEqual(errorMessage, "Пароли не совпадают")
                expectation.fulfill()
            }
            viewModel.validateInput("Password2", for: .confirmPassword)
            waitForExpectations(timeout: 1, handler: nil)
        }

        func testCheckAllFields_Valid() {
            var allFieldsValid: Bool?
            viewModel.onAllFieldsValid = { isValid in
                allFieldsValid = isValid
            }
            
            viewModel.validateInput("Имя", for: .name)
            viewModel.validateInput("Фамилия", for: .lastName)
            viewModel.validateInput("Jan 01, 2000", for: .birthDate)
            viewModel.validateInput("Password1", for: .password)
            viewModel.validateInput("Password1", for: .confirmPassword)
            
            XCTAssertTrue(allFieldsValid ?? false)
        }

        func testOnButtonTapped_SavesUser() {
            viewModel.validateInput("Имя", for: .name)
            viewModel.validateInput("Фамилия", for: .lastName)
            viewModel.validateInput("Jan 01, 2000", for: .birthDate)
            viewModel.validateInput("Password1", for: .password)
            viewModel.validateInput("Password1", for: .confirmPassword)
            
            let expectation = self.expectation(description: "Navigate to next screen")
            
            viewModel.onButtonTapped()
            waitForExpectations(timeout: 1, handler: nil)
        }
}

