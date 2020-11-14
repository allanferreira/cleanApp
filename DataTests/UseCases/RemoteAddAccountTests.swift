import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "http://new-any-url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccount: makeAddAccount()) {_ in}
        XCTAssertEqual(httpClientSpy.urls, [url])
    }

    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let addAccount = makeAddAccount()
        sut.add(addAccount: addAccount) {_ in}
        XCTAssertEqual(httpClientSpy.data, addAccount.toData())
    }
    
    func test_add_should_complete_with_error_if_httpClient_fails() {
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        sut.add(addAccount: makeAddAccount()) { error in
            XCTAssertEqual(error, .unexpected)
            exp.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }

}

extension RemoteAddAccountTests {
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    func makeAddAccount() -> AddAccountModel {
        return AddAccountModel(name: "any_name", email: "any@any.com", password: "any123", passwordConfirmation: "any123")
    }
    
    class HttpClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        var completion: ((HttpError) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (HttpError) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError) {
            completion?(error)
        }
    }
}
