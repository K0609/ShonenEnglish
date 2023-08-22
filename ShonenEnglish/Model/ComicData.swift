import Foundation
import UIKit

struct ComicData: Identifiable {

    let id = UUID()
    let quoteID: Int
    let quoteJa: String
    let quoteJaHighlight: [String]
    let quoteJaHighlightSub: [String]
    let characterJa: String
    let titleJa: String
    let authorJa: String
    let publicationJa: String
    let publisherJa: String
    let volume: Int
    let episode: Int
    let quoteEn: String
    let quoteEnHighlight: [String]
    let quoteEnHighlightSub: [String]
    let wordID: Int
    let wordEn: String
    let wordJa: String
    let wordLevel: Int
    let pronUS: String
    let pronUK: String
    let POS1: String
    let conjugation1: String
    let meaningJa1_1: String
    let meaningJa1_2: String
    let meaningJa1_3: String
    let synonymEn1_1: String
    let synonymEn1_2: String
    let synonymEn1_3: String
    let POS2: String
    let conjugation2: String
    let meaningJa2_1: String
    let meaningJa2_2: String
    let meaningJa2_3: String
    let synonymEn2_1: String
    let synonymEn2_2: String
    let synonymEn2_3: String
    let POS1En: String
    let POS2En: String
    let characterEn: String
    let titleEn: String
    let authorEn: String
    let publicationEn: String
    let publisherEn: String
    var image: UIImage? = nil // Added to hold the loaded image

    enum CodingKeys: String, CodingKey {
        case quoteID
        case quoteJa
        case quoteJaHighlight
        case quoteJaHighlightSub
        case characterJa
        case titleJa
        case authorJa
        case publicationJa
        case publisherJa
        case volume
        case episode
        case quoteEn
        case quoteEnHighlight
        case quoteEnHighlightSub
        case wordID
        case wordEn
        case wordJa
        case wordLevel
        case pronUS
        case pronUK
        case POS1
        case conjugation1
        case meaningJa1_1
        case meaningJa1_2
        case meaningJa1_3
        case synonymEn1_1
        case synonymEn1_2
        case synonymEn1_3
        case POS2
        case conjugation2
        case meaningJa2_1
        case meaningJa2_2
        case meaningJa2_3
        case synonymEn2_1
        case synonymEn2_2
        case synonymEn2_3
        case POS1En
        case POS2En
        case characterEn
        case titleEn
        case authorEn
        case publicationEn
        case publisherEn
    }
}

extension ComicData: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        quoteID = try container.decode(Int.self, forKey: .quoteID)
        quoteJa = try container.decode(String.self, forKey: .quoteJa)
        let highlightStringJa = try container.decode(String.self, forKey: .quoteJaHighlight)
        quoteJaHighlight = highlightStringJa.components(separatedBy: ",")
        let highlightStringJaSub = try container.decode(String.self, forKey: .quoteJaHighlightSub)
        quoteJaHighlightSub = highlightStringJaSub.components(separatedBy: ",")
        characterJa = try container.decode(String.self, forKey: .characterJa)
        titleJa = try container.decode(String.self, forKey: .titleJa)
        authorJa = try container.decode(String.self, forKey: .authorJa)
        publicationJa = try container.decode(String.self, forKey: .publicationJa)
        publisherJa = try container.decode(String.self, forKey: .publisherJa)
        volume = try container.decode(Int.self, forKey: .volume)
        episode = try container.decode(Int.self, forKey: .episode)
        quoteEn = try container.decode(String.self, forKey: .quoteEn)
        let highlightStringEn = try container.decode(String.self, forKey: .quoteEnHighlight)
        quoteEnHighlight = highlightStringEn.components(separatedBy: ",")
        let highlightStringEnSub = try container.decode(String.self, forKey: .quoteEnHighlightSub)
        quoteEnHighlightSub = highlightStringEnSub.components(separatedBy: ",")
        wordID = try container.decode(Int.self, forKey: .wordID)
        wordEn = try container.decode(String.self, forKey: .wordEn)
        wordJa = try container.decode(String.self, forKey: .wordJa)
        wordLevel = try container.decode(Int.self, forKey: .wordLevel)
        pronUS = try container.decode(String.self, forKey: .pronUS)
        pronUK = try container.decode(String.self, forKey: .pronUK)
        POS1 = try container.decode(String.self, forKey: .POS1)
        conjugation1 = try container.decode(String.self, forKey: .conjugation1)
        meaningJa1_1 = try container.decode(String.self, forKey: .meaningJa1_1)
        meaningJa1_2 = try container.decode(String.self, forKey: .meaningJa1_2)
        meaningJa1_3 = try container.decode(String.self, forKey: .meaningJa1_3)
        synonymEn1_1 = try container.decode(String.self, forKey: .synonymEn1_1)
        synonymEn1_2 = try container.decode(String.self, forKey: .synonymEn1_2)
        synonymEn1_3 = try container.decode(String.self, forKey: .synonymEn1_3)
        POS2 = try container.decode(String.self, forKey: .POS2)
        conjugation2 = try container.decode(String.self, forKey: .conjugation2)
        meaningJa2_1 = try container.decode(String.self, forKey: .meaningJa2_1)
        meaningJa2_2 = try container.decode(String.self, forKey: .meaningJa2_2)
        meaningJa2_3 = try container.decode(String.self, forKey: .meaningJa2_3)
        synonymEn2_1 = try container.decode(String.self, forKey: .synonymEn2_1)
        synonymEn2_2 = try container.decode(String.self, forKey: .synonymEn2_2)
        synonymEn2_3 = try container.decode(String.self, forKey: .synonymEn2_3)
        POS1En = try container.decode(String.self, forKey: .POS1En)
        POS2En = try container.decode(String.self, forKey: .POS2En)
        characterEn = try container.decode(String.self, forKey: .characterEn)
        titleEn = try container.decode(String.self, forKey: .titleEn)
        authorEn = try container.decode(String.self, forKey: .authorEn)
        publicationEn = try container.decode(String.self, forKey: .publicationEn)
        publisherEn = try container.decode(String.self, forKey: .publisherEn)
        image = nil
    }
}

//ローカライズ
extension ComicData {
    var isJapanese: Bool {
        return Locale.current.identifier.hasPrefix("ja")
    }
    
    func localizedPOS1() -> String {
        return self.isJapanese ? self.POS1 : self.POS1En
    }
    
    func localizedPOS2() -> String {
        return self.isJapanese ? self.POS2 : self.POS2En
    }
    
    func localizedCharacter() -> String {
        return self.isJapanese ? self.characterJa : self.characterEn
    }

    func localizedTitle() -> String {
        return self.isJapanese ? self.titleJa : self.titleEn
    }
    
    func localizedAuthor() -> String {
        return self.isJapanese ? self.authorJa : self.authorEn
    }
    
    func localizedPublication() -> String {
        return self.isJapanese ? self.publicationJa : self.publicationEn
    }
    
    func localizedPublisher() -> String {
        return self.isJapanese ? self.publisherJa : self.publisherEn
    }
}
