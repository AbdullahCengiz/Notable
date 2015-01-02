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
    var correctSound : SoundFile!
    var incorrectSound : SoundFile!
    var drumrollSound: SoundFile
    var endDrumrollSound: SoundFile
    
    
    init(){
        
        confirmSound = SoundFile(soundName: "confirm", soundType: "mp3")
        correctSound = SoundFile(soundName: "correct", soundType: "mp3")
        incorrectSound = SoundFile(soundName: "incorrect", soundType: "mp3")
        drumrollSound = SoundFile(soundName: "drumroll", soundType: "wav")
        endDrumrollSound = SoundFile(soundName: "endDrumroll", soundType: "mp3")

        var soundLevel: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("sound")
        // control initial sound value
        if(soundLevel==nil){
            
            //println("No sound value !!!!!")
            NSUserDefaults.standardUserDefaults().setObject(0.5, forKey: "sound")
            NSUserDefaults.standardUserDefaults().synchronize()
            soundLevelValue = 0.5;
            
        }else{
            //initial sound value found
            soundLevelValue = soundLevel! as Float
            
        }

        
    }


    func setSoundVolume(volume:Float){

        self.soundLevelValue = volume

    }



    
    
    func playSound(soundFile:SoundFile){
        
        //println("in playSound!!")

        //println("soundFileName = \(soundFile.soundName) soundType:\(soundFile.soundType)")
        
        var soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundFile.soundName, ofType: soundFile.soundType)!)
        
        
        
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
            self.audioPlayer.volume = self.soundLevelValue
            self.audioPlayer.prepareToPlay()
            println(self.audioPlayer.duration)
            self.audioPlayer.play()
            
            
            if(self.audioPlayer.playing){
                
                //println("Playing....")
                
            } else {
                
                //println("Not playing!!!!!!!!")
                
            }
            
            
        }

        
    }


    func playSound(soundFile:SoundFile,repeat:Bool){

        //println("in playSound!!")

        //println("soundFileName = \(soundFile.soundName) soundType:\(soundFile.soundType)")

        var soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundFile.soundName, ofType: soundFile.soundType)!)







        dispatch_async(dispatch_get_main_queue()) {

            self.audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)


            if(repeat){
                self.audioPlayer.numberOfLoops = 5
            }


            self.audioPlayer.volume = self.soundLevelValue
            self.audioPlayer.prepareToPlay()
            println(self.audioPlayer.duration)
            self.audioPlayer.play()



            if(self.audioPlayer.playing){

                //println("Playing....")

            } else {

                //println("Not playing!!!!!!!!")

            }


        }

        
    }

    
    
}



