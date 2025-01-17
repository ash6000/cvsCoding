//
//  cvsCodingTests.swift
//  cvsCodingTests
//
//  Created by Ashton Watson on 01/16/25.
//

import XCTest
@testable import cvsCoding

class cvsCodingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testPhotoDecoding() throws {
     
        let sampleJSON = """
        {
            "title": "Sample Photo",
            "tags": "This is a sample description.",
            "author": "Sample Author",
            "media": { "m": "https://example.com/sample.jpg" },
            "published": "2024-11-19T10:00:00Z"
        }
        """
        
      
        let jsonData = sampleJSON.data(using: .utf8)!
        
       
        let decoder = JSONDecoder()
        let photo = try decoder.decode(Photo.self, from: jsonData)
        
        XCTAssertEqual(photo.title, "Sample Photo")
        XCTAssertEqual(photo.tags, "This is a sample description.")
        XCTAssertEqual(photo.author, "Sample Author")
        XCTAssertEqual(photo.imageURL, "https://example.com/sample.jpg")
        XCTAssertEqual(photo.formattedDate, "Nov 19, 2024")
    }

}
