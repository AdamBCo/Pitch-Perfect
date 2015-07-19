//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Adam Cooper on 7/17/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var recievedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
            player = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
            player.prepareToPlay()
            player.enableRate = true
            
            audioEngine = AVAudioEngine()
            audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onChipmunkAudioButtonPressed(sender: UIButton) {
       playAudioWithVariablePitch(1000)
    }
    @IBAction func onDarthVaderAudioButtonPressed(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    @IBAction func playSlowSound(sender: UIButton) {
            player.rate = 0.25
            player.play()
    }

    @IBAction func playFastAudio(sender: AnyObject) {
        player.rate = 2
        player.play()
    }

    @IBAction func stopAudio(sender: AnyObject) {
        player.pause()
        audioEngine.pause()
    }
    

}
