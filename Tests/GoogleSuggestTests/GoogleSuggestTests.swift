import XCTest
@testable import GoogleSuggest

final class GoogleSuggestTests: XCTestCase {
    func testExample() throws {
        let exp = XCTestExpectation(description: "\(#function)")
        let client = GoogleSuggest()
        client.getSuggestionsBy(query: "tenki") { result in
            print("result")
            switch result {
            case .success(let results):
                XCTAssertTrue(results.count > 0)
            case .failure(let error):
                print(error)
                XCTAssertTrue(false)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10.0)
    }
}
