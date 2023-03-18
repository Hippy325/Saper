//
//  CoreData.swift
//  App
//
//  Created by User on 18.03.2023.
//

import Foundation
import CoreData

protocol IDBForApp {
	func getCountCellAndBomb() -> (Int, Int)
	func saveCountCellAndBomb(cell: Int, bomb: Int)
	func getField() -> [Int?]
	func saveField(field: [Int?])
}

protocol IDBForLiaison {
	func saveFieldSnapshot(snapsot: [TypePress])
	func getFieldSnapshot() -> [TypePress]
}

final class DBCoreData {
	// MARK: - Core Data stack
	private lazy var context = persistentContainer.viewContext
	private lazy var persistentContainer: NSPersistentContainer = {

		let container = NSPersistentContainer(name: "Saper")
		container.loadPersistentStores(completionHandler: { (_, error) in
			if let error = error as NSError? {

				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	// MARK: - Core Data Saving support

	private func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
}
