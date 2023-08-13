import AVFoundation

//class SpeechSynthesizer: ObservableObject {
//    private let synthesizer = AVSpeechSynthesizer()
//
//    func speak(_ text: String, language: String) {
//        let utterance = AVSpeechUtterance(string: text)
//        utterance.voice = AVSpeechSynthesisVoice(language: language)
//        synthesizer.speak(utterance)
//    }
//}


class SpeechSynthesizer: ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()

    func speak(_ text: String, language: String) {
        // 1. 現在の発話を停止する
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        // 2. 新しい発話を再生する
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        synthesizer.speak(utterance)
    }
}
