//
//  PortfolioDataService.swift
//  Crypto
//
//  Created by Kareem on 27/08/2026.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("error core data \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: public section
    func updatePortfolio(coin: CoinModel, amount: Double) {
        
        if let entity = savedEntities.first(where: { savedEntity in
            return savedEntity.coinID == coin.id
        }) {
            if amount > 0 {
                updateEntity(entity: entity, amount: amount)
            } else {
                deleteEntity(entity: entity)
            }
        } else {
            addEntity(coin: coin, amount: amount)
        }
    }
    
    // MARK: private section
    
    private func getPortfolio() {
     
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("error fetching protfolio entities \(error)")
        }
    }
    
    private func addEntity(coin: CoinModel,amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
        
    }
    
    private func updateEntity(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func deleteEntity(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("error saving to core data \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
