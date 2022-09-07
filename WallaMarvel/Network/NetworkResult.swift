//
//  NetworkResult.swift
//  WallaMarvel
//
//  Created by Alena's macbook on 7/9/22.
//

import Foundation


enum NetworkResult: Equatable {

    static func == (lhs: NetworkResult, rhs: NetworkResult) -> Bool {
        switch (lhs, rhs) {
        case let (.success(data), .success(data1)): return data == data1
        case let (.failure(err), .failure(err1)): return err?.localizedDescription == err1?.localizedDescription
        case (.success, _), (.failure, _): return false
        }
    }

    case success(Data)
    case failure(Error?)
}
