import SwiftUI

struct TextHighlighter {
    let quote: String
    let highlightWords: [String]
    let highlightWordsSub: [String]

    func highlightedText() -> [Text] {
        var remainingText = quote
        var textViews: [Text] = []
        
        while !remainingText.isEmpty {
            var foundHighlight = false
            
            for word in highlightWords + highlightWordsSub {
                if let range = remainingText.range(of: word, options: .caseInsensitive) {
                    let textBeforeHighlight = String(remainingText[..<range.lowerBound])
                    if !textBeforeHighlight.isEmpty {
                        textViews.append(Text(textBeforeHighlight))
                    }
                    
                    let color = highlightWords.contains(word) ? Color(UIColor.systemBlue) : Color(UIColor.systemGreen)
                    textViews.append(Text(remainingText[range]).foregroundColor(color))
                    
                    remainingText.removeSubrange(..<range.upperBound)
                    foundHighlight = true
                    break
                }
            }
            
            if !foundHighlight {
                textViews.append(Text(String(remainingText.removeFirst())))
            }
        }

        return textViews
    }
}

