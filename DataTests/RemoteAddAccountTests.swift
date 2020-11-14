import XCTest
import Domain

class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient

    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(addAccount: AddAccountModel) {
        let data = try? JSONEncoder().encode(addAccount)
        httpClient.post(to: url, with: data)
    }
}

protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add(addAccount: makeAddAccount())
        XCTAssertEqual(httpClientSpy.url, url)
    }

    func test_add_should_call_httpClient_with_correct_data() {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: URL(string: "http://any-url.com")!, httpClient: httpClientSpy)
        let addAccount = makeAddAccount()
        sut.add(addAccount: addAccount)
        let data = try? JSONEncoder().encode(addAccount)
        XCTAssertEqual(httpClientSpy.data, data)
    }

}

extension RemoteAddAccountTests {
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
