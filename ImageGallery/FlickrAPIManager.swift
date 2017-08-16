//
//  FlickrAPIManager.swift
//  ImageGallery
//
//  Created by Jonas Simkus on 15/08/2017.
//  Copyright © 2017 Jonas Simkus. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper
import Moya_ObjectMapper

enum FlickrAPI {
    case photos(String?)
}

extension FlickrAPI: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.flickr.com")! }
    
    var path: String {
        switch self {
        case .photos:
            return "/services/feeds/photos_public.gne"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .photos:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .photos(let tags):
            var params = baseParameters()
            if let tags = tags {
                params["tags"] = tags
            }
            return params
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .photos:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    var task: Task {
        return .request
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    //var validate: Bool { get }
    
    // The headers to be used in the request.
    var headers: [String: String]? {
        return nil
    }
    
    private func baseParameters() -> [String: String] {
        return ["format": Key.json, "nojsoncallback": "1"]
    }
}

struct FlickrAPIManager {
    
    let provider: RxMoyaProvider<FlickrAPI>
    let disposeBag = DisposeBag()
    
    init() {
        provider = RxMoyaProvider<FlickrAPI>()
    }
    
}

extension FlickrAPIManager {
    
    func requestObject<T: Mappable>(_ token: FlickrAPI, type: T.Type, completion: @escaping (T?) -> Void, additionalSteps: JSVoidClosure? = nil) {
        provider.request(token)
            .debug()
            .mapObject(T.self)
            .subscribe { (event) in
                switch event {
                case .next(let parsedObject):
                    completion(parsedObject)
                    additionalSteps?()
                case .error(let error):
                    print(error)
                    completion(nil)
                default:
                    break
                }
            }.addDisposableTo(disposeBag)
    }
    
    func requestArray<T: Mappable>(_ token: FlickrAPI, type: T.Type, completion: @escaping ([T]?) -> Void, additionalSteps: JSVoidClosure? = nil) {
        provider.request(token)
            .debug()
            .map { response -> Response in
                return response.removeAPIWrappers()
            }
            .mapArray(T.self)
            .subscribe { (event) in
                switch event {
                case .next(let parsedObject):
                    completion(parsedObject)
                    additionalSteps?()
                case .error(let error):
                    print(error)
                    completion(nil)
                default:
                    break
                }
            }.addDisposableTo(disposeBag)
    }
    
}

protocol FlickrAPICalls {
    
    func galleryPhotos(query: String?, completion: @escaping ([GalleryPhoto]?) -> Void)
    
}

extension FlickrAPIManager: FlickrAPICalls {
    
    func galleryPhotos(query: String? = nil, completion: @escaping ([GalleryPhoto]?) -> Void) {
        requestArray(.photos(query), type: GalleryPhoto.self, completion: completion)
    }
    
}

extension Response {
    
    func removeAPIWrappers() -> Response {
        guard let json = try? self.mapJSON() as? Dictionary<String, Any>, let results = json?["items"],
            let newData = try? JSONSerialization.data(withJSONObject: results, options: .prettyPrinted) else {
                return self
        }
        let newResponse = Response(statusCode: self.statusCode, data: newData, response: self.response)
        return newResponse
    }
    
}
