//
//  APIClient.swift
//  Networking
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import RxSwift

public class TestClient {

    public init() {}

    public func test() {
        print("Hello from networking")
    }

    public func getData() {
        let defaultSession = URLSession(configuration: .default)
        let components = URLComponents(string: "https://thebigachallenge.appspot.com/_ah/api/myApi/v1/goals")
        guard let url = components?.url else { return }

        let dataTask = defaultSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to request")
                print(error)
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("Success")
                    print(data)
                    do {
                        let movieData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                        print(movieData)
                    } catch {
                        print("error")
                    }

                }
            }
        }
        dataTask.resume()
    }
}
