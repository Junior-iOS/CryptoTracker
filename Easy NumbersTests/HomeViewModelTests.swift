////
////  Easy_NumbersTests.swift
////  Easy NumbersTests
////
////  Created by NJ Development on 23/11/23.
////
//
//import XCTest
//@testable import Easy_Numbers
//
//class HomeViewModelTests: XCTestCase {
//
//    var homeViewModel: HomeViewModel!
//
//    override func setUp() {
//        super.setUp()
//        homeViewModel = HomeViewModel()
//    }
//
//    override func tearDown() {
//        homeViewModel = nil
//        super.tearDown()
//    }
//
//    // Teste para verificar se a geração de números está funcionando corretamente
//    func testGenerateNumbers() {
//        let generatedNumbers = homeViewModel.generateNumbers(total: 5, universe: 10)
//        XCTAssertEqual(generatedNumbers.count, 5, "A quantidade de números gerados deve ser 5")
//        // Teste adicional para verificar se os números gerados estão dentro do intervalo correto
//        XCTAssertTrue(Set(1...10).isSuperset(of: Set(generatedNumbers)), "Os números gerados devem estar dentro do intervalo de 1 a 10")
//    }
//
//    // Teste para verificar se a geração de números para um tipo específico de jogo está correta
//    func testGenerateForGameType() {
//        let megaSenaNumbers = homeViewModel.generate(.megasena)
//        XCTAssertEqual(megaSenaNumbers.count, 6, "A quantidade de números gerados para a Mega Sena deve ser 6")
//        // Adicione mais testes similares para outros tipos de jogos, como Lotofácil, Quina, etc.
//    }
//
//    // Teste para verificar se a configuração remota está sendo verificada corretamente
//    func testCheckRemoteConfig() {
//        // Mock para simular o comportamento da configuração remota
//        class MockDelegate: HomeViewModelDelegate {
//            var remoteConfigValue: Bool = false
//
//            func handleRemoteConfig(with value: Bool) {
//                remoteConfigValue = value
//            }
//
//            // Implemente os métodos restantes conforme necessário para simular o comportamento do delegate
//        }
//
//        let mockDelegate = MockDelegate()
//        homeViewModel.delegate = mockDelegate
//        homeViewModel.checkRemoteConfig()
//
//        // Verificação se o valor da configuração remota foi atualizado corretamente
//        XCTAssertTrue(mockDelegate.remoteConfigValue, "O valor da configuração remota deve ser verdadeiro")
//        // Adicione mais testes conforme necessário para verificar outros aspectos da configuração remota
//    }
//}
