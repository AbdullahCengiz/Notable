//
//  Sound.swift
//  Notable
//
//  Created by abdullah cengiz on 12/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation
import QuartzCore

class Sound
{
    var audioPlayer = AVAudioPlayer()
    var soundLevelValue:Float = 0.0
    var confirmSound : SoundFile!
    
    
    init(){
        
        confirmSound = SoundFile(soundName: "howling", soundType: "mp3")
        
        
        var soundLevel: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("sound")
        // control initial sound value
        if(soundLevel==nil){
            
            println("No sound value !!!!!")
            NSUserDefaults.standardUserDefaults().setObject(0.5, forKey: "sound")
            NSUserDefaults.standardUserDefaults().synchronize()
            soundLevelValue = 0.5;
            
        }
        else{
            //initial sound value found
            soundLevelValue = soundLevel! as Float
            
        }

        
    }
    
    
    func playSound(soundFile:SoundFile){
        
        println("in playSound!!")
        
        var soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundFile.soundName, ofType: soundFile.soundType)!)
        
        
        
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
            self.audioPlayer.volume = self.soundLevelValue
            self.audioPlayer.prepareToPlay()
            println(self.audioPlayer.duration)
            self.audioPlayer.play()
            
            
            
            if(self.audioPlayer.playing){
                
                println("Playing....")
                
            } else {
                
                println("Not playing!!!!!!!!")
                
            }
            
            
        }

        
    }
    
    
}



