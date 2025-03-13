//
//  ProductDetailViewModelTest.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 13/03/25.
//

import XCTest
import Combine
@testable import MercadoLibreTest

class ProductDetailViewModelTests: XCTestCase {

    var viewModel: ProductDetailViewModel!
    var mockNetworkProvider: MockNetworkProviderProductDetail!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkProvider = MockNetworkProviderProductDetail()
        viewModel = ProductDetailViewModel(networkProvider: mockNetworkProvider)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkProvider = nil
        cancellables = nil
        super.tearDown()
    }

    func testGetProductDetails_LoadingState() {
        viewModel.getProductDetails(id: "testId")
        XCTAssertEqual(viewModel.viewState, .loading)
    }
    
    func testGetProductDetails_SuccessfulResponse_SetsLoadedStateAndProductDetails() {
        let expectedDetails = ProductDetailResponse(
            id: "testId",
            title: "Test Product",
            price: 10.0,
            original_price: 12.0,
            currency_id: "USD",
            initial_quantity: 100.0,
            condition: "new",
            pictures: [
                ProductDetailImages(id: "img1", secure_url: "url1"),
                ProductDetailImages(id: "img2", secure_url: "url2")
            ]
        )
        mockNetworkProvider.mockProductDetailResponse = expectedDetails
        let expectation = XCTestExpectation(description: "Product details loaded")

        viewModel.$viewState.dropFirst().sink { viewState in
            if viewState == .loaded {
                XCTAssertEqual(self.viewModel.productDetails, expectedDetails)
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.getProductDetails(id: "testId")

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetProductDetails_NetworkError_SetsNetworkErrorState() {
        mockNetworkProvider.mockError = NetworkError.requestFailed(NSError(domain: "Test", code: 1, userInfo: nil))
        let expectation = XCTestExpectation(description: "Network error")

        viewModel.$viewState.dropFirst().sink { viewState in
            if case .error(.network) = viewState {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.getProductDetails(id: "testId")

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetProductDetails_NoConnectionError_SetsNoInternetErrorState() {
        mockNetworkProvider.mockError = NetworkError.noConnection
        let expectation = XCTestExpectation(description: "No internet error")

        viewModel.$viewState.dropFirst().sink { viewState in
            if case .error(.noInternet) = viewState {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.getProductDetails(id: "testId")

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetProductDetails_UnknownError_SetsNetworkErrorState() {
        mockNetworkProvider.mockError = NSError(domain: "Test", code: 2, userInfo: nil)
        let expectation = XCTestExpectation(description: "Unknown error")

        viewModel.$viewState.dropFirst().sink { viewState in
            if case .error(.network) = viewState {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.getProductDetails(id: "testId")

        wait(for: [expectation], timeout: 1.0)
    }
}

class MockNetworkProviderProductDetail: NetworkProviderProtocol {
    var mockProductDetailResponse: ProductDetailResponse?
    var mockError: Error?

    func request<T>(endpoint: Endpoint) async throws -> T where T : Decodable {
        if let error = mockError {
            throw error
        }
        if let response = mockProductDetailResponse as? T {
            return response
        }
        throw NSError(domain: "MockError", code: 0, userInfo: nil)
    }

    var isConnected: Bool {
        return true
    }
}
