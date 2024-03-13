import Foundation

struct Post: Codable {
    let id: String
    let description: String?
    let urls: PostUrls
}
struct PostUrls: Codable {
    let regular: String
}

