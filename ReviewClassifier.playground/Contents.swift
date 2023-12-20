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
=============================================================
"""
    print(stats)
    let sentimentClassifier = try MLTextClassifier(trainingData: trainingDataTable, textColumn: "text", labelColumn: "label")
    let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100
    let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100
    
    let message = """
=============================================================
    Training Accuracy = \(trainingAccuracy)
    Validation Accuracy = \(validationAccuracy)
=============================================================
"""
    print(message)
}catch{
    print(error.localizedDescription)
}
