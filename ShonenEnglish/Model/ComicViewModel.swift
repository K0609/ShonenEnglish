import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

class ComicViewModel: ObservableObject {
    @Published var comicDataList: [ComicData] = []
    private var allComicDataList: [ComicData] = []
    private let db = Firestore.firestore()  // Firestoreへの参照を作成
    private let storage = Storage.storage()  // Cloud Storageへの参照を作成
    
    // イニシャライザ
    init() {
        loadFirestoreData()
    }
    
    // Firestoreからデータのロードとデータモデルへの変換
    func loadFirestoreData() {
        db.collection("comicData").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let decoder = JSONDecoder()
                self.allComicDataList = querySnapshot!.documents.compactMap { queryDocumentSnapshot -> ComicData? in
                    try? decoder.decode(ComicData.self, fromJSONObject: queryDocumentSnapshot.data())
                }
                print("comicData loaded successfully!")
            }
        }
    }
    
    // Cloud Storageから画像をロードするメソッド
    func loadImageFromStorage(imageID: Int, completion: @escaping (UIImage?) -> Void) {
        let imageName = String(format: "%05d.png", imageID)  // 整数を5桁の文字列に変換して.pngを追加
        let imageRef = storage.reference(withPath: "images_quote/\(imageName)") //Storageパスを記入
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
            } else {
                let image = UIImage(data: data!)
                completion(image)
                print("images loaded successfully!")
            }
        }
    }

    // ランダムに選択
    func loadRandomComics() {
        self.comicDataList = Array(allComicDataList.shuffled().prefix(10))
        // After loading the comic data, load the images
        for (index, comicData) in comicDataList.enumerated() {
            loadImageFromStorage(imageID: comicData.quoteID) { image in
                if let image = image {
                    self.comicDataList[index].image = image
                } else {
                    print("Failed to load image")
                }
            }
        }
    }

    // 指定されたwordLevelでデータをフィルタリングするメソッドを追加
    func loadComicsWithWordLevel(level: Int) {
        let filteredComicDataList = allComicDataList.filter { $0.wordLevel == level }
        self.comicDataList = Array(filteredComicDataList.shuffled().prefix(10))
        // After loading the comic data, load the images
        for (index, comicData) in comicDataList.enumerated() {
            loadImageFromStorage(imageID: comicData.quoteID) { image in
                if let image = image {
                    self.comicDataList[index].image = image
                } else {
                    print("Failed to load image")
                }
            }
        }
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, fromJSONObject object: Any) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        return try self.decode(type, from: data)
    }
}
