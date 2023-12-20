import CreateML
import Cocoa

guard let trainingDataFileURL = Bundle.main.url(forResource: "amazon-reviews", withExtension: "json"),
      let testingDataFileURL = Bundle.main.url(forResource: "testing-reviews", withExtension: "json")else {
          fatalError("Error! Could not load resource files")
      }
do{
    let trainingDataTable = try MLDataTable(contentsOf: trainingDataFileURL)
    let testingDataTable = try MLDataTable(contentsOf: testingDataFileURL)
    let stats = """
=============================================================
Entries used for training : \(trainingDataTable.size)
Entries used for training : \(testingDataTable.size)
"""
    print(stats)
}catch{
    print(error.localizedDescription)
}
