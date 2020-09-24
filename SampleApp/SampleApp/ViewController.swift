import UIKit
import LocusSDKFramework

extension Task {
    
    static func from(clientId: String, taskId: String) -> Task {
        
        return Task(clientId: clientId, taskId: taskId, status: nil, sourceOrderId: nil, orderDetail: nil, assignedUser: nil, creationTime: nil, completionTime: nil, checklists: nil, statusUpdates: nil, customFields: nil, taskGraph: nil, carrierTeams: nil, taskAppConfig: nil)
    }
}

class ViewController: UIViewController {
    
    var currentFilename: String?
    @IBOutlet var console: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func initializeClicked(_: Any) {
        
        let alert = UIAlertController(title: "Initialize", message: "Enter Client User Id and Password", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.tag = 1
            textField.placeholder = "Client ID"
            textField.text = "test"
        }
        alert.addTextField { textField in
            textField.tag = 2
            textField.placeholder = "User ID"
            textField.text = "driver1"
        }
        alert.addTextField { textField in
            textField.tag = 3
            textField.isSecureTextEntry = true
            textField.placeholder = "Password"
            textField.text = "Testing1"
        }
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
            
            let client = alert.textFields?.first { $0.tag == 1 }?.text ?? "test"
            let userId = alert.textFields?.first { $0.tag == 2 }?.text ?? "driver1"
            let password = alert.textFields?.first { $0.tag == 3 }?.text ?? "Testing1"
            let param = AuthParams.forUser(clientId: client, userId: userId, password: password)
            LocusSDK.initialize(params: param, delegate: self, successBlock: {
                self.print("initializeSuccess")
            }, failureBlock: { error in
                self.print(error.message)
            })
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        self.present(alert, animated: true) {}
    }
    
    @IBAction func reinitializeClicked(_: Any) {
        
        LocusSDK.reinitialize(delegate: self, successBlock: {
            //            self.print("reinitializeSuccess")
        }, failureBlock: { error in
            self.print(error.message)
        })
    }
    
    @IBAction func startTracking(_: Any) {
        
        LocusSDK.startTracking(successBlock: {}) { error in
            self.print("Start tracking error - \(LocusSDKError.error(error).message)")
        }
    }
    
    @IBAction func stopTracking(_: Any) {
        
        LocusSDK.stopTracking(successBlock: {}) { error in
            self.print("Stop tracking error - \(LocusSDKError.error(error).message)")
        }
    }
    
    @IBAction func triggerSync(_: Any) {
        LocusSDK.sync(forceTransmit: true, successBlock: {
            self.print("sync success")
        }, failureBlock: { error in
            self.print(error.message)
        })
    }
    
    @IBAction func imageUpload(_: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func logout(_: Any) {
        LocusSDK.logout(forceLogout: false, successBlock: {
            self.print("Logout success")
        }) { error in
            self.print("Logout failure - \(error.message)")
        }
    }
    
    @IBAction func forceLogout(_: Any) {
        LocusSDK.logout(forceLogout: true, successBlock: {
            self.print("Logout success")
        }) { error in
            self.print("Logout failure - \(error.message)")
        }
    }
    
    @IBAction func displayChecklist(_: Any) {
        let checlistitems: [ChecklistItem] = [
            ChecklistItem(key: "cancellation-reason", item: "Select a reason", format: ChecklistItem.Format(rawValue: "SINGLE_CHOICE"), possibleValues: ["Customer not available", "Quality issue", "Cash unavailable", "Late delivery", "Partial order delivered"], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "signature-1", item: "Customer signature", format: ChecklistItem.Format(rawValue: "SIGNATURE"), possibleValues: [], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "bool", item: "bill", format: ChecklistItem.Format(rawValue: "BOOLEAN"), possibleValues: [], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "photo", item: "Item", format: ChecklistItem.Format(rawValue: "PHOTO"), possibleValues: [], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "url", item: "Terms and condition", format: ChecklistItem.Format(rawValue: "URL"), possibleValues: ["https://locus.sh/privacy-policy/"], allowedValues: [], _optional: true, additionalOptions: [:]),
            ChecklistItem(key: "text", item: "comments", format: ChecklistItem.Format(rawValue: "TEXT_FIELD"), possibleValues: [], allowedValues: [], _optional: false, additionalOptions: [:]),
            ChecklistItem(key: "pin", item: "Order Pin", format: ChecklistItem.Format(rawValue: "PIN"), possibleValues: ["1234"], allowedValues: [], _optional: true, additionalOptions: [:]),
            ChecklistItem(key: "rating", item: "Drop rating", format: ChecklistItem.Format(rawValue: "RATING"), possibleValues: ["5"], allowedValues: [], _optional: false, additionalOptions: [:]),
        ]
        let checklist: Checklist = Checklist(status: "Completed", items: checlistitems)
        LocusSDK.tintColour = UIColor.red
        //        LocusSDK.displayChecklistView(task: Task.from(clientId: "test", taskId: "1-test-300519"), checklist: checklist, initialValues: ["text": "hbfhjebfsdbck bewfkj", "rating": "4", "pin": "1234", "url": "true", "bool": "true", "cancellation-reason": "Quality issue"], successBlock: {
        //            value in self.print("\(value)")
        //        }) { _ in
        //        }
        let display = LocusSDKChecklistDisplayConfig(title: "Checklist", subtitle: "enter details and click submit", buttonTitle: "Submit", attributedTitle: NSAttributedString(string: "CHECKLIST"), attributedSubtitle: nil, type: .bottomView)
        LocusSDK.displayChecklistView(checklist: checklist, displayConfig: display, initialValues: nil, successBlock: { result in self.print(result.getDictionaryAfterUploadingFilesFor(task: Task.from(clientId: "test", taskId: "1-test-300519")).description) }) { error in
            self.print(error.message)
        }
    }
    
    func print(_ message: String) {
        console.text = message
    }
}

extension ViewController: LocusSDKDelegate {
    func logEvent(tag: String, message: String, logLevel: LocusSDKLogLevel) {
        print("logEvent---\(tag)\(message)\(logLevel.rawValue)----")
    }
    
    func isOfflineStatusChanged(isOffline: Bool) {
        print("isOfflineStatusChanged-----\(isOffline)----")
    }
    
    func onLocationUpdated(location: Location) {
        print("onLocationUpdated---\(location)----")
    }
    
    func onLocationError(error: LocusSDKError) {
        print("onLocationError---\(error.message)----")
    }
    
    func onLocationUploaded(location: Location) {
        print("onLocationUploaded---\(location)----")
    }
    
    func locusSDKStatusChanged(status: LocusSDKStatus) {
        print("locusSDKStatusChanged---\(status)----")
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage else {
            return
        }
        self.saveAndPreviewImage(image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func saveAndPreviewImage(_ image: UIImage) {
        
        let filename = UUID().uuidString
        
        let imageCompressed = ImageScaler.resize(image, toFit: 800)
        // delete the old file if a new one is taken
        if let currentFilename = currentFilename {
            FileUtil.deleteFile(named: currentFilename)
        }
        
        if let imageData = imageCompressed.jpegData(compressionQuality: 0.7) {
            
            let success = FileUtil.saveData(data: imageData, to: filename)
            if success {
                currentFilename = filename
                do {
                    try LocusSDK.uploadFile(task: Task.from(clientId: "test", taskId: "1-test-300519"), fileName: currentFilename!, data: imageData)
                } catch {
                    self.print("Error - \(LocusSDKError.error(error).message)")
                }
                return
            }
        }
    }
}
