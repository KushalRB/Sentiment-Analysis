import CreateML
import Cocoa

guard let trainingDataFileURL = Bundle.main.url(forResource: "amazon-reviews", withExtension: "json"),
      let testingDataFileURL = Bundle.main.url(forResource: "testing-reviews", withExtension: "json")else {
          fatalError("Error! Could not load resource files")
      }
