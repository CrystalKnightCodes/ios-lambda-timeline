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
    
    var audioPlayer: AVAudioPlayer? {
        didSet {
            guard let audioPlayer = audioPlayer else { return }
            // audioPlayer.delegate = self
            audioPlayer.isMeteringEnabled = true
            // updateViews()
        }
    }
    
    var audioRecorder: AVAudioRecorder?
    var recordingURL: URL?
    
    weak var timer: Timer?
    private lazy var timeIntervalFormatter: DateComponentsFormatter = {
        let formatting = DateComponentsFormatter()
        formatting.unitsStyle = .positional
        formatting.zeroFormattingBehavior = .pad
        formatting.allowedUnits = [.minute, .second]
        return formatting
    }()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
