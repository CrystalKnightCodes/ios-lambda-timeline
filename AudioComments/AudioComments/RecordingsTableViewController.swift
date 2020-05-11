//
//  RecordingsTableViewController.swift
//  AudioComments
//
//  Created by Christy Hicks on 5/10/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingsTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet var recordButton: UIButton!
    
    // MARK: - Properties
    var isRecording: Bool {
            audioRecorder?.isRecording ?? false
    }
    
    var audioRecorder: AVAudioRecorder?
    var recordingURL: URL?
    
    var audioPlayer: AVAudioPlayer? {
        didSet {
            guard let audioPlayer = audioPlayer else { return }
            audioPlayer.delegate = self
            audioPlayer.isMeteringEnabled = true
            updateViews()
        }
    }
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateViews() {
        recordButton.isSelected = isRecording
    }
    // MARK: - Actions
    @IBAction func toggleRecording(_ sender: UIButton) {
        if isRecording {
            stopRecording()
        } else {
            requestPermissionOrStartRecording()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordingCell", for: indexPath)

        // Configure the cell...

        return cell
    }

    // MARK: - Methods
        func prepareAudioSession() throws {
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.playAndRecord, options: [.defaultToSpeaker])
        try session.setActive(true, options: [])
    }
    
    func createNewRecordingURL() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let name = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: .withInternetDateTime)
        let file = documents.appendingPathComponent(name, isDirectory: false).appendingPathExtension("caf")
        
        print("recording URL: \(file)")
        
        return file
    }
    
    func requestPermissionOrStartRecording() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                guard granted == true else {
                    print("We need microphone access")
                    return
                }
                
                print("Recording permission has been granted!")

            }
        case .denied:
            print("Microphone access has been blocked.")
            
            let alertController = UIAlertController(title: "Microphone Access Denied", message: "Please allow this app to access your Microphone.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Open Settings", style: .default) { (_) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            })
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
        case .granted:
            startRecording()
        @unknown default:
            break
        }
    }
    
    
    func startRecording() {
        do {
            try prepareAudioSession()
        } catch {
            print("Cannot record audio: \(error)")
            return
        }
        
        recordingURL = createNewRecordingURL()
        
        let format = AVAudioFormat(standardFormatWithSampleRate: 44_100, channels: 1)!
        do {
            audioRecorder = try AVAudioRecorder(url: recordingURL!, format: format)
            audioRecorder?.delegate = self
            audioRecorder?.record()
        } catch {
            preconditionFailure("The audio recorder could not be created with \(recordingURL!) and \(format)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
    }
}

extension RecordingsTableViewController: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
        func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
            if let recordingURL = recordingURL {
                audioPlayer = try? AVAudioPlayer(contentsOf: recordingURL)
                audioRecorder = nil
            }
            
            func audioPlayerDecodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
            if let error = error {
                print("Audio Recorder Error: \(error)")
            }
        }
    }
}
