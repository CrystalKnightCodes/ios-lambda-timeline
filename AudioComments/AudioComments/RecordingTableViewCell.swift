//
//  RecordingTableViewCell.swift
//  AudioComments
//
//  Created by Christy Hicks on 5/10/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import UIKit

class RecordingTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var topDurationLabel: UILabel!
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var timeSlider: UISlider!
    @IBOutlet var bottomDurationLabel: UILabel!
    @IBOutlet var playButtton: UIButton!

    // MARK: - Properties
    var isPlaying: Bool = false {
        didSet {
            
        }
    }

    // MARK: - Actions
    @IBAction func togglePlayPause(_ sender: UIButton) {
    }
    
    @IBAction func deleteRecording(_ sender: UIButton) {
        
    }
    
}
