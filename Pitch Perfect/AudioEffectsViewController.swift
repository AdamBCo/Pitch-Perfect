//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Adam Cooper on 7/17/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

import UIKit
import AVFoundation

class AudioEffectsViewController: UIViewController {

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
        stopAll()
        
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
    
    func playAudioWithVariableRate(rate: Float){
        stopAll()
        
        player.rate = rate
        player.play()
        
    }

    @IBAction func playSlowSound(sender: UIButton) {
        
        playAudioWithVariableRate(0.25)
    }

    @IBAction func playFastAudio(sender: AnyObject) {
        playAudioWithVariableRate(2.0)
 
    }

    @IBAction func stopAudio(sender: AnyObject) {
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func stopAll() {
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
        player.currentTime = 0.0
    }
    

}
