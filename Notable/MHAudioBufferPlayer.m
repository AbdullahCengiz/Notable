
#import "MHAudioBufferPlayer.h"
#import <Foundation/Foundation.h>
#import <Notable-Swift.h>
#import "Synth.h"

// The number of Audio Queue buffers we keep in rotation
#define NumberOfAudioDataBuffers 3

@interface MHAudioBufferPlayer ()



@property (nonatomic, assign, readwrite) BOOL playing;

- (void)setUpAudio;
- (void)tearDownAudio;
- (void)start;




@end




static void InterruptionListenerCallback(void *inUserData, UInt32 interruptionState)
{
	MHAudioBufferPlayer *player = (__bridge MHAudioBufferPlayer *)inUserData;


	if (interruptionState == kAudioSessionBeginInterruption)
	{
		[player tearDownAudio];
	}
	else if (interruptionState == kAudioSessionEndInterruption)
	{
		[player setUpAudio];
		[player start];
	}
}

static void PlayCallback(void *inUserData, AudioQueueRef inAudioQueue, AudioQueueBufferRef inBuffer)
{
	MHAudioBufferPlayer *player = (__bridge MHAudioBufferPlayer *)inUserData;
	if (player.playing && player.block != nil)
	{
		player.block(inBuffer, player.audioFormat);
		AudioQueueEnqueueBuffer(inAudioQueue, inBuffer, 0, NULL);
	}
}

@implementation MHAudioBufferPlayer
{

	// the audio queue object being used for playback
	AudioQueueRef _playQueue;
	
	// the audio queue buffers for the playback audio queue
	AudioQueueBufferRef _playQueueBuffers[NumberOfAudioDataBuffers];

	// the number of audio data packets to use in each audio queue buffer
	UInt32 _packetsPerBuffer;

	// the number of bytes to use in each audio queue buffer
	UInt32 _bytesPerBuffer;
}

- (id)initWithSampleRate:(Float64)sampleRate channels:(UInt32)channels bitsPerChannel:(UInt32)bitsPerChannel secondsPerBuffer:(Float64)secondsPerBuffer
{
	return [self initWithSampleRate:sampleRate channels:channels bitsPerChannel:bitsPerChannel packetsPerBuffer:(UInt32)(secondsPerBuffer * sampleRate)];
}

- (id)initWithSampleRate:(Float64)sampleRate channels:(UInt32)channels bitsPerChannel:(UInt32)bitsPerChannel packetsPerBuffer:(UInt32)packetsPerBuffer
{
	if ((self = [super init]))
	{
		_playing = NO;
		_playQueue = NULL;
		_gain = 1.0;
  
		_audioFormat.mFormatID         = kAudioFormatLinearPCM;
		_audioFormat.mSampleRate       = sampleRate;
		_audioFormat.mChannelsPerFrame = channels;
		_audioFormat.mBitsPerChannel   = bitsPerChannel;
		_audioFormat.mFramesPerPacket  = 1;  // uncompressed audio
		_audioFormat.mBytesPerFrame    = _audioFormat.mChannelsPerFrame * _audioFormat.mBitsPerChannel/8;
		_audioFormat.mBytesPerPacket   = _audioFormat.mBytesPerFrame * _audioFormat.mFramesPerPacket;
		_audioFormat.mFormatFlags      = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;

		_packetsPerBuffer = packetsPerBuffer;
		_bytesPerBuffer = _packetsPerBuffer * _audioFormat.mBytesPerPacket;

		[self setUpAudio];
	}
	return self;
}

- (void)dealloc
{
	[self tearDownAudio];
}

- (void)setUpAudio
{
	if (_playQueue == NULL)
	{
		[self setUpAudioSession];
		[self setUpPlayQueue];
		[self setUpPlayQueueBuffers];
	}
}

- (void)tearDownAudio
{
	if (_playQueue != NULL)
	{
		[self stop];
		[self tearDownPlayQueue];
		[self tearDownAudioSession];
	}
}

- (void)setUpAudioSession
{
	AudioSessionInitialize(
		NULL,
		NULL,
		InterruptionListenerCallback,
		(__bridge void *)self);

	UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
	AudioSessionSetProperty(
		kAudioSessionProperty_AudioCategory,
		sizeof(sessionCategory),
		&sessionCategory);

	AudioSessionSetActive(true);
}

- (void)tearDownAudioSession
{
	AudioSessionSetActive(false);
}

- (void)setUpPlayQueue
{
	AudioQueueNewOutput(
		&_audioFormat,
		PlayCallback,
		(__bridge void *)self, 
		NULL,                   // run loop
		kCFRunLoopCommonModes,  // run loop mode
		0,                      // flags
		&_playQueue);

	self.gain = 1.0;
}

- (void)tearDownPlayQueue
{
	AudioQueueDispose(_playQueue, YES);
	_playQueue = NULL;
}

- (void)setUpPlayQueueBuffers
{
	for (int t = 0; t < NumberOfAudioDataBuffers; ++t)
	{
		AudioQueueAllocateBuffer(
			_playQueue,
			_bytesPerBuffer,
			&_playQueueBuffers[t]);
	}
}

- (void)primePlayQueueBuffers
{
	for (int t = 0; t < NumberOfAudioDataBuffers; ++t)
	{
		PlayCallback((__bridge void *)self, _playQueue, _playQueueBuffers[t]);
	}
}

- (void)start
{
	if (!self.playing)
	{
		self.playing = YES;
		[self primePlayQueueBuffers];
		AudioQueueStart(_playQueue, NULL);
	}
}

- (void)stop
{
	if (self.playing)
	{
		AudioQueueStop(_playQueue, TRUE);
		self.playing = NO;
	}
}


- (MHAudioBufferPlayer*)prepare:(NSArray*)initArray
{


    MHAudioBufferPlayer* myPlayer = (MHAudioBufferPlayer*)([initArray objectAtIndex:5]);

    myPlayer = [[MHAudioBufferPlayer alloc] initWithSampleRate:16000
                                                      channels:1
                                                bitsPerChannel:16
                                              packetsPerBuffer:1024];


    NSLog(@"I called function!!!!!");






    //[myPlayer start];



   // [blockSelf.synth playNote:60];


    return myPlayer;

}

- (MHAudioBufferPlayer*)runBlock: (NSArray*)initArray
{

    MHAudioBufferPlayer* myPlayer = (MHAudioBufferPlayer*)([initArray objectAtIndex:5]);

    myPlayer = [[MHAudioBufferPlayer alloc] initWithSampleRate:16000
                                                      channels:1
                                                bitsPerChannel:16
                                              packetsPerBuffer:1024];


    NSLog(@"I called function!!!!!");

    //UInt32 sampleRate=0;

    __block __weak NewGameViewController *weakSelf = (NewGameViewController*)([initArray objectAtIndex:4]);
    NewGameViewController *blockSelf = weakSelf;
    blockSelf.synth = [[Synth alloc] initWithSampleRate:16000];


    myPlayer.block = ^(AudioQueueBufferRef buffer, AudioStreamBasicDescription audioFormat)
    {

        if (blockSelf != nil)
        {
            // Lock access to the synth. This callback runs on an internal
            // Audio Queue thread and we don't want to allow any other thread
            // to change the Synth's state while we're still filling up the
            // audio buffer.
            [blockSelf.synthLock lock];

            // Calculate how many packets fit into this buffer. Remember that a
            // packet equals one frame because we are dealing with uncompressed
            // audio; a frame is a set of left+right samples for stereo sound,
            // or a single sample for mono sound. Each sample consists of one
            // or more bytes. So for 16-bit mono sound, each packet is 2 bytes.
            // For stereo it would be 4 bytes.
            int packetsPerBuffer = buffer->mAudioDataBytesCapacity / audioFormat.mBytesPerPacket;

            // Let the Synth write into the buffer. The Synth just knows how to
            // fill up buffers in a particular format and does not care where
            // they come from.

            //NSLog(@" before packetsWritten");

            int packetsWritten = [blockSelf.synth fillBuffer:buffer->mAudioData frames:packetsPerBuffer];

            // NSLog(@"packetsWritten = %@",packetsWritten);

            // We have to tell the buffer how many bytes we wrote into it.
            buffer->mAudioDataByteSize = packetsWritten * audioFormat.mBytesPerPacket;

            [blockSelf.synthLock unlock];

            //NSLog(@" completed ");
        }
        else{
            
            
            NSLog(@" blockself = nil");
            
            
        }
    };


    
    myPlayer->_gain = 0.9f; // init gain value

    AudioQueueSetParameter(myPlayer->_playQueue, kAudioQueueParam_Volume,  [(NSString*)[initArray objectAtIndex:6] floatValue]); // set volume

    [myPlayer start];

    return myPlayer;

}

- (void)setGain:(Float32)gain
{
	if (_gain != gain)
	{
		_gain = gain;
		AudioQueueSetParameter(_playQueue, kAudioQueueParam_Volume, 0.1);
	}
}

@end
