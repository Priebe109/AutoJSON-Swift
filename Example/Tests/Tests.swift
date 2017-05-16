import UIKit
import XCTest
import AutoJSON

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        AutoJSON.default.deserializer.readingOptions = .allowFragments
        AutoJSON.default.serializer.writingOptions = .prettyPrinted
    }
    
    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Serialization
    
    func testDataSerialization_validObject_dataIsNotNil() {
        
        // Create the object for testing.
        let user = BlogUser()
        user.age = nil
        user.username = "Priebe109"
        
        // Serialize the object.
        let data = AutoJSON.default.serialize(user)
        
        // Assert the data isn't nil (serialization was successful).
        XCTAssert(data != nil)
    }
    
    func testStringSerialization_validObject_stringIsNotNil() {
        
        // Create the object for testing.
        let user = BlogUser()
        user.age = nil
        user.username = "Priebe109"
        
        // Serialize the object.
        let string = AutoJSON.default.serializeToString(user)
        
        // Assert the data isn't nil (serialization was successful).
        XCTAssert(string != nil)
    }
    
    // MARK: - Deserialization
    
    func testConversion_blogUserObject_identicalwOutput() {
        
        let testAge = 24
        let testUsername = "Priebe109"
        
        // Create the object for testing.
        let user = BlogUser()
        user.age = testAge
        user.username = testUsername
        
        // Serialize the object.
        let data = AutoJSON.default.serialize(user)!
        
        // Deserialize the object.
        let deserializedUser: BlogUser = AutoJSON.default.deserialize(data)!
        
        // This is an example of a functional test case.
        XCTAssert(deserializedUser.age == testAge)
        XCTAssert(deserializedUser.username == testUsername)
    }
}
