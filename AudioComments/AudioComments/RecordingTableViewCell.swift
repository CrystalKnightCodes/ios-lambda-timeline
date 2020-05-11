//
//  RecordingTableViewCell.swift
//  AudioComments
//
//  Created by Christy Hicks on 5/10/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var timeSlider: UISlider!
    @IBOutlet var timeRemainingLabel: UILabel!
    @IBOutlet var playButtton: UIButton!
    
    // MARK: - Properties
    var isPlaying: Bool = false {
        didSet {
            updateViews()
        }
    }
    
    var audioPlayer: AVAudioPlayer? {
        didSet {
            guard let audioPlayer = audioPlayer else { return }
            audioPlayer.delegate = self
            updateViews()
        }
    }
    weak var timer: Timer?
    private lazy var timeIntervalFormatter: DateComponentsFormatter = {
        let formatting = DateComponentsFormatter()
        formatting.unitsStyle = .positional
        formatting.zeroFormattingBehavior = .pad
        formatting.allowedUnits = [.minute, .second]
        return formatting
    }()
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Actions
    @IBAction func togglePlayPause(_ sender: UIButton) {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    @IBAction func updateCurrentTime(_ sender: UISlider) {
        if isPlaying {
            pause()
        }
        
        audioPlayer?.currentTime = TimeInterval(sender.value)
        updateViews()
    }
    
    @IBAction func deleteRecording(_ sender: UIButton) {
        
    }
    
    // MARK: - Methods
    // View
    func updateViews() {
        playButtton.isSelected = isPlaying
        
        let elapsedTime = audioPlayer?.currentTime ?? 0
        let duration = audioPlayer?.duration ?? 0
        let timeRemaining = duration.rounded() - elapsedTime
        
        progressLabel.text = timeIntervalFormatter.string(from: elapsedTime)!
        timeRemainingLabel.text = "-" + timeIntervalFormatter.string(from: timeRemaining)!
        
        timeSlider.minimumValue = 0
        timeSlider.maximumValue = Float(duration)
        timeSlider.value = Float(elapsedTime)
    }
    
    // Timer
    func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.030, repeats: true, block: { [weak self] (_) in
            guard let self = self else { return }
            
            self.updateViews()
        })
    }
    
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // Audio Player
    func prepareAudioSession() throws {
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.playAndRecord, options: .defaultToSpeaker)
        try session.setActive(true, options: [])
    }
    
    func play() {
        do {
            try prepareAudioSession()
            audioPlayer?.play()
            updateViews()
            startTimer()
        } catch {
            print("Connot play audio: \(error)")
        }
        
        audioPlayer?.play()
    }
    
    func pause() {
        audioPlayer?.pause()
        updateViews()
        cancelTimer()
    }
}


extension RecordingTableViewCell: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        updateViews()
        cancelTimer()
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let error = error {
            print("Audio Recorder Error: \(error)")
        }
    }
}
