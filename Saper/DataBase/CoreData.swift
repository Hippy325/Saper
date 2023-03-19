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

final class DBCoreData: IDBForApp {
	// MARK: - Core Data stack
	private var matrix: DBMatrix = DBMatrix()
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

	func getCountCellAndBomb() -> (Int, Int) {
		let request: NSFetchRequest<DBMatrix> = DBMatrix.fetchRequest()
		do {
			matrix = try context.fetch(request)[0]
		} catch let error {
			print(error)
		}

		return (Int(matrix.countCell), Int(matrix.countBomb))
	}

	func saveCountCellAndBomb(cell: Int, bomb: Int) {
		do {
			context.delete(matrix)
			try context.save()
		} catch let error {
			print(error)
		}

		guard let entity = NSEntityDescription.entity(forEntityName: "DBMatrix", in: context) else { return }
		let matrix = DBMatrix(entity: entity, insertInto: context)
		matrix.countCell = Int32(cell)
		matrix.countBomb = Int32(bomb)

		do {
			try context.save()
			self.matrix = matrix
		} catch let error {
			print(error)
		}
	}

	func getField() -> [Int?] {
		return []
	}

	func saveField(field: [Int?]) {

	}
}
