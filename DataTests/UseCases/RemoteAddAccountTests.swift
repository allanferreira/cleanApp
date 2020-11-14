import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "http://new-any-url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccount: makeAddAccount())
        XCTAssertEqual(httpClientSpy.url, url)
    }

    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let addAccount = makeAddAccount()
        sut.add(addAccount: addAccount)
        XCTAssertEqual(httpClientSpy.data, addAccount.toData())
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
        var url: URL?
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
