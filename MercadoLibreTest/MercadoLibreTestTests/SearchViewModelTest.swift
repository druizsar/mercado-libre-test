//
//  SearchViewModelTest.swift
//  MercadoLibreTest
//
//  Created by David Ruiz on 13/03/25.
//

import XCTest
import Combine
@testable import MercadoLibreTest

class SearchViewModelTests: XCTestCase {

    var viewModel: SearchViewModel!
    var mockNetworkProvider: MockNetworkProvider!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkProvider = MockNetworkProvider()
        viewModel = SearchViewModel(networkProvider: mockNetworkProvider)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkProvider = nil
        cancellables = nil
        super.tearDown()
    }

    func testSearchProducts_EmptyQuery_SetsNoInputError() {
        viewModel.searchProducts(query: "")
        XCTAssertEqual(viewModel.viewState, .error(.noInput))
    }

    func testSearchProducts_LoadingState() {
        viewModel.searchProducts(query: "test")
        XCTAssertEqual(viewModel.viewState, .loading)
    }

    func testSearchProducts_SuccessfulResponse_SetsLoadedStateAndProducts() {
        let expectedProducts = [
            SearchProductsResult(id: "1", title: "Product 1", currency_id: "USD", price: 10.0, thumbnail: "url1"),
            SearchProductsResult(id: "2", title: "Product 2", currency_id: "USD", price: 20.0, thumbnail: "url2")
        ]
        let response = SearchProductsResponse(site_id: "MCO", query: "test", results: expectedProducts)
        mockNetworkProvider.mockResponse = response
        let expectation = XCTestExpectation(description: "Search products loaded")

        viewModel.$viewState.dropFirst().sink { viewState in
            if viewState == .loaded {
                XCTAssertEqual(self.viewModel.products, expectedProducts)
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.searchProducts(query: "test")

        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchProducts_EmptyResults_SetsNoResultsState() {
        let emptyResponse = SearchProductsResponse(site_id: "MCO", query: "test", results: [])
        mockNetworkProvider.mockResponse = emptyResponse
        let expectation = XCTestExpectation(description: "No results found")

        viewModel.$viewState.dropFirst().sink { viewState in
            if viewState == .noResults {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.searchProducts(query: "test")

        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchProducts_NetworkError_SetsNetworkErrorState() {
        mockNetworkProvider.mockError = NetworkError.requestFailed(NSError(domain: "Test", code: 1, userInfo: nil))
        let expectation = XCTestExpectation(description: "Network error")

        viewModel.$viewState.dropFirst().sink { viewState in
            if case .error(.network) = viewState {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.searchProducts(query: "test")

        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchProducts_NoConnectionError_SetsNoInternetErrorState() {
        mockNetworkProvider.mockError = NetworkError.noConnection
        let expectation = XCTestExpectation(description: "No internet error")

        viewModel.$viewState.dropFirst().sink { viewState in
            if case .error(.noInternet) = viewState {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.searchProducts(query: "test")

        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchProducts_UnknownError_SetsNetworkErrorState() {
        mockNetworkProvider.mockError = NSError(domain: "Test", code: 2, userInfo: nil)
        let expectation = XCTestExpectation(description: "Unknown error")

        viewModel.$viewState.dropFirst().sink { viewState in
            if case .error(.network) = viewState {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.searchProducts(query: "test")

        wait(for: [expectation], timeout: 1.0)
    }
}


class MockNetworkProvider: NetworkProviderProtocol {
    var mockResponse: SearchProductsResponse?
    var mockError: Error?

    func request<T>(endpoint: Endpoint) async throws -> T where T : Decodable {
        if let error = mockError {
            throw error
        }
        if let response = mockResponse as? T {
            return response
        }
        throw NSError(domain: "MockError", code: 0, userInfo: nil)
    }

    var isConnected: Bool {
        return true
    }
}
