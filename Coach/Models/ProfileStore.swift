//
//  ProfileStore.swift
//  Coach
//
//  Created by Sudha Ravi Kumar Javvadi on 2/21/22.
//

import Foundation
import SwiftUI

class ProfileStore: ObservableObject {
    @Published var profiles: [Profile] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("profiles.data")
    }
    
    static func load() async throws -> [Profile] {
        try await withCheckedThrowingContinuation {continuation in
            load {result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let profiles):
                    continuation.resume(returning: profiles)
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<[Profile], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileUrl = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileUrl) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let profiles = try JSONDecoder().decode([Profile].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(profiles))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(profiles: [Profile]) async throws -> Int {
        try await withCheckedThrowingContinuation {continuation in
            save(profiles: profiles) {result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let profilesSaved):
                    continuation.resume(returning: profilesSaved)
                }
            }
        }
    }
    
    static func save(profiles: [Profile], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(profiles)
                let outFile = try fileURL()
                try data.write(to: outFile)
                DispatchQueue.main.async {
                    completion(.success(profiles.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
