//
//  CloudKitUserVM.swift
//  Chimera
//
//  Created by Nicola Rigoni on 25/01/23.
//

import Foundation

class CloudKitUserVM: ObservableObject {
    @Published var isSignedInToiCloud: Bool = false
    private let service: CloudKitService
    
    init(service: CloudKitService) {
        self.service = service
        checkAccoutStatus()
    }
    
    func checkAccoutStatus() {
        Task {
            let result = try await service.checkAccountStatus()
            switch result {
            case let .success(success):
                print("CLOUD SUCCESS: \(success.description)")
            case let .failure(error):
                print("CLIUD ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    
    
}
