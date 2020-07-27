//
//  ParserManager.swift
//  Vesti
//
//  Created by Туйаара Оконешникова on 02/07/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

struct RSSItem {
    
       var title: String
       var fullText: String
       var pubDate: String
       var category: String
    var images: [String : String]
    
       
   enum CodingKeys: String, CodingKey {
    
       case title = "title"
       case fullText = "yandex:full-text"
       case pubDate = "pubDate"
       case category = "category"
       case images = "enclosure url="
         }
   }

class ParserManager: NSObject, XMLParserDelegate {

    // MARK: - Parser completion handler
       
    private var rssItems: [RSSItem] = []
    private var element = NSString()
    private var parser = XMLParser()
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    private var currentElement = ""
    
    var images: [String : String] = [:]
    
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentTPubDate: String = "" {
        didSet {
            currentTPubDate = currentTPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
           }
       }
    private var currentCategory: String = "" {
        didSet {
            currentCategory = currentCategory.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
           }
       }
    private var currentFullText: String = "" {
        didSet {
            currentFullText = currentFullText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
        
    // initilise parser
    func initWithURL(_ url :URL) -> AnyObject {
        
        parser = XMLParser(contentsOf: url)!
        return self
    }

    func parseFeed(url: String, completionHandler: (([RSSItem]) -> Void)?) {
        
        self.parserCompletionHandler = completionHandler
        
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            // parse our xml data
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    // MARK: - XML Parser Delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
       currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentTPubDate = ""
            currentCategory = ""
            currentFullText = ""

        }
        // separately create an dict for images
        element = elementName as NSString
    if (element as NSString).isEqual(to: "enclosure") {
                   if let urlString = attributeDict["url"] {
                    images["image"] = urlString
                   }
               }
           }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title":
            currentTitle += string
        case "pubDate":
            currentTPubDate += string
        case "category":
            currentCategory += string
        case "yandex:full-text":
            currentFullText += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
         
            let rssItem = RSSItem(title: currentTitle, fullText: currentFullText, pubDate: currentTPubDate, category: currentCategory, images: images)
            self.rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        
        parserCompletionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        
        print(parseError.localizedDescription)
    }
}
