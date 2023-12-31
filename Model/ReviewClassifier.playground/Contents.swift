import CreateML
import Cocoa

///This is an older complex way of generating mlmodels. You can also generate mlmodel using CreateML from within Developer Tools
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
    
    let modelFileURL = URL(fileURLWithPath: "/Users/fusemachines/Documents/iOS/Practice/Github Projects/Sentiment Analysis/ReviewClassifier.mlmodel")
    
    let metadata = MLModelMetadata(author: "Kushal Rajbhandari", shortDescription: "A model ttrained to classify product review sentiment", version: "0.1")
    
    try sentimentClassifier.write(to: modelFileURL, metadata: metadata)
}catch{
    print(error.localizedDescription)
}
