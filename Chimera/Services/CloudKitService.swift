//
//  CloudKitService.swift
//  Chimera
//
//  Created by Nicola Rigoni on 25/01/23.
//

import Foundation
import CloudKit

final class CloudKitService {
    
    func checkAccountStatus() async throws -> Result<Bool, Error> {
        let accountStatus = try await CKContainer.default().accountStatus()
        switch accountStatus {
        case .available:
            return .success(true)
        case .restricted:
            return .failure(CloudKitError.iCloudAccountRestricted)
        case .noAccount:
            return .failure(CloudKitError.iCLoudAccountNotFound)
        case .couldNotDetermine:
            return .failure(CloudKitError.iCloudAccountNotDetermined)
        default:
            return .failure(CloudKitError.icloudAccountUnknown)
        }
    }
    
    enum CloudKitError: LocalizedError {
        case iCLoudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case icloudAccountUnknown
        case iCloudApplicationPermissionNotGranted
        case iCloudCouldNotFetchUserID
        case iCloudCouldNotDiscoverUser
        case iCloudRecordNotFound
    }
    
    func fetch<T: CloudKitableProtocol>(predicate: NSPredicate, recordType: CKRecord.RecordType, fields: [CKRecord.FieldKey]? = nil, sortDescriptor: [NSSortDescriptor]? = nil, resultLimits: Int? = nil) async throws -> [T] {
        
        let query = createOperation(predicate: predicate, recordType: recordType, sortDescriptor: sortDescriptor)
        
        let result = try await CKContainer.default().privateCloudDatabase.records(matching: query, desiredKeys: fields)
        let records = result.matchResults.compactMap { try? $0.1.get() }
        return records.compactMap(T.init)
    }
    
    private func createOperation(predicate: NSPredicate, recordType: CKRecord.RecordType, sortDescriptor: [NSSortDescriptor]? = nil) -> CKQuery {
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        query.sortDescriptors = sortDescriptor

        return query
    }
    
    @discardableResult
    func add<T: CloudKitableProtocol>(item: T) async throws -> CKRecord {
        //save to iCloudKit.
        guard let record = item.record else { throw CloudKitError.iCloudRecordNotFound }
        
        do {
            return try await save(record: record)
        } catch {
            debugPrint("error add \(error.localizedDescription)")
            throw error
        }
    }
    
    
    private func save(record: CKRecord) async throws -> CKRecord {
        try await CKContainer.default().privateCloudDatabase.save(record)
    }
    
    func delete(recordID: CKRecord.ID) async throws {
        let _ = try await CKContainer.default().privateCloudDatabase.deleteRecord(withID: recordID)
    }
    
}
