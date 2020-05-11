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
    var isRecording: Bool = false {
        didSet {
            
        }
    }
    
    var audioRecorder: AVAudioRecorder?
    var recordingURL: URL?
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateViews() {
        recordButton.isSelected = isRecording
    }
    // MARK: - Actions
    @IBAction func toggleRecording(_ sender: UIButton) {
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
    
}
