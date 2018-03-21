//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
let filePath = Bundle.main.path(forResource: "airport_sample", ofType: "csv")!
typealias Airport = [String: String]
typealias Airports = [Airport]

func parseCSV(contentsOf filePath: String, encoding: String.Encoding, error: NSErrorPointer) -> Airports? {
    // Load the CSV file and parse it
    let delimiter = ","
    var airports: Airports = []
    
    if let contents = try? String(contentsOfFile: filePath) {
        let lines:[String] = contents.components(separatedBy: .newlines) as [String]
        
        for line in lines {
            var values:[String] = []
            if line != "" {
                // For a line with double quotes
                // we use NSScanner to perform the parsing
                
                if line.range(of: "\"") != nil {
                    var textToScan:String = line
                    var value: NSString?
                    var textScanner:Scanner = Scanner(string: textToScan)
                    while textScanner.string != "" && textToScan.characters.count > 0 {
                        if (textScanner.string as NSString).substring(to: 1) == "\"" {
                            textScanner.scanLocation += 1
                            textScanner.scanUpTo("\"", into: &value)
                            textScanner.scanLocation += 1
                        } else {
                            textScanner.scanUpTo(delimiter, into: &value)
                        }
                        
                        // Store the value into the values array
                        values.append(value! as String)
                        
                        // Retrieve the unscanned remainder of the string
                        if textScanner.scanLocation < textScanner.string.characters.count {
                            textToScan = (textScanner.string as NSString).substring(from: textScanner.scanLocation + 1)
                        } else {
                            textToScan = ""
                        }
                        textScanner = Scanner(string: textToScan)
                    }
                    
                    // For a line without double quotes, we can simply separate the string
                    // by using the delimiter (e.g. comma)
                } else  {
                    values = line.components(separatedBy: delimiter)
                }
                
                // Put the values into the tuple and add it to the items array
                let airport = ["ident": values[0],
                            "type": values[1],
                            "name": values[2],
                            "latitude_deg": values[3],
                            "longitude_deg": values[4],
                            "elevation_ft": values[5],
                            "continent": values[6],
                            "iso_country": values[7],
                            "iso_region": values[8],
                            "municipality": values[9],
                            "scheduled_service": values[10],
                            "gps_code": values[11],
                            "iata_code": values[12],
                            "local_code": values[13],
                            "home_link": values[14],
                            "wikipedia_link": values[15],
                            "keywords": values[16]]
                airports.append(airport)
            }
        }
    }
    return airports
}
func storeAirdrome(){
    
}

var error: NSErrorPointer
let airportDict: Airports? = parseCSV(contentsOf: filePath, encoding: .unicode, error: error)



//////////////////////// DICT to JSON //////////////////////////
let dic = airportDict as Airports?

do {
    let jsonData = try JSONSerialization.data(withJSONObject: dic!, options: .prettyPrinted)
    let documentsDir = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    let jsonFilePath = documentsDir.appendingPathComponent("airports.json")!
    print("jsonFilePath : \(jsonFilePath)")
    try jsonData.write(to: jsonFilePath)
    
//  Reverse: Decodeing
//    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
//    // here "decoded" is of type `Any`, decoded from JSON data
//    print("decode: \(decoded)")
//    
//    // you can now cast it with the right type
//    if let dictFromJSON = decoded as? [String:String] {
//        // use dictFromJSON
//    }
} catch {
    print(error.localizedDescription)
}

