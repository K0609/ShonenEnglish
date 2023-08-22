import SwiftUI
import AVFoundation

struct View1: View {
    let comicData: ComicData
    var selectedModeLa: Int // 日本語->EngかEng->日本語か
    var selectedModeWorS: Int //単語か文章か
    @StateObject private var speechSynthesizer = SpeechSynthesizer()
    
    private func contentText() -> String {
        switch (selectedModeLa, selectedModeWorS) {
        case (0, 0): return comicData.wordEn
        case (0, 1): return comicData.quoteEn
        case (1, 0): return comicData.wordJa
        case (1, 1): return comicData.quoteJa
        default: return comicData.wordEn
        }
    }
    
    private func languageCode() -> String {
        switch (selectedModeLa, selectedModeWorS) {
        case (0, _): return "en-US"
        case (1, _): return "ja-Ja"
        default: return "en-US"
        }
    }
    
    var body: some View {
        VStack {
            Text(contentText())
                .font(.largeTitle)
                .bold()
                .padding()
            
            SpeakerButton(text: contentText(), language: languageCode())
        }
        .analyticsScreen(name: "main_content")
    }
}

struct SpeakerButton: View {
    let text: String
    let language: String
    @StateObject private var speechSynthesizer = SpeechSynthesizer()

    var body: some View {
        Button(action: {
            BarVisibilityPublisher.shared.ChangeBarVisibility()
            speechSynthesizer.speak(text, language: language)
        }) {
            Image(systemName: "speaker.wave.3.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
    }
}
