//
//  SearchViewControllerTest.swift
//  SAPTests
//
//  Created by Hamza Ahmed on 02/02/2022.
//

import XCTest
@testable import SAP

class SearchViewControllerTest: XCTestCase {
    var sut: SearchViewController!
    var mockSearchService : MockSearchService!
    var viewModel : SearchViewModel!
    
    override func setUpWithError() throws {
        setupViewController()
        setupViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        sut = nil
    }
    private func setupViewController(){
        let storyboard = UIStoryboard(name: Constant.storyboardIdentifier, bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        guard let vc : SearchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else{
            return XCTFail("Could not instantiate SearchViewController")
        }
        sut = vc
        UIApplication.shared.windows.first{ $0.isKeyWindow }!.rootViewController = UINavigationController.init(rootViewController: vc)
        sut.loadViewIfNeeded()
    }
    private func setupViewModel(){
        mockSearchService = MockSearchService()
        guard let mockSearchService = mockSearchService else {
            XCTFail("ViewModel cannot be instantiated.")
            return }
        viewModel = SearchViewModelImplementation(service: mockSearchService)
    }

}

extension SearchViewControllerTest{
    func testCollectionViewExist(){
        XCTAssertNotNil(sut.collectionView, "Controller should have a collection view")
    }
    func testCollectionViewDelegateSetUpCorrectly() {
        XCTAssertTrue(sut.collectionView.delegate is SearchViewController , "SearchViewController does not conform to UICollectionView delegate protocol")
        
    }
}
