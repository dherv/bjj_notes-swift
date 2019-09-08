//
//  Api.swift
//  bjj_ios
//
//  Created by Damien Hervieux on 2019/09/08.
//  Copyright © 2019 Damien Hervieux. All rights reserved.
//

import Foundation


struct GetData: Decodable {
    var id: Int
        var title: String
        var teacher: String
        var category: String
        var sub_category: String
        var comment: String
    var created_at: String
        
        init(
            id: Int,
            title: String,
                teacher: String,
                category: String,
                sub_category: String,
                comment: String,
                created_at: String
              ) {
            self.id = id
            self.title = title
            self.teacher = teacher
            self.category = category
            self.sub_category = sub_category
            self.comment = comment
            self.created_at = created_at
        }
    
}

class Api {
    static let shared = Api(baseUrl: String("http://localhost:3000"))
    
    var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func get(path: String, completion: @escaping (Result<[GetData], Error>) -> ()) {
        guard let endpoint = URL(string: (baseUrl + path) ) else {return}
        
        let task = URLSession.shared.dataTask(with: endpoint) { data, response, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                // top level array need [GetData] instead of GetData
                let data = try JSONDecoder().decode([GetData].self, from : data)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return
            }
        }
        return task.resume()
    }
    
    func post(path: String, post_data: PostData, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let endpoint = URL(string: (baseUrl + path) ) else {return}
        print("post_data", post_data)
        
        let jsonData = try?
            JSONEncoder().encode(post_data)
        
        print("json_data", jsonData as Any)
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        print(request)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
    }
}
