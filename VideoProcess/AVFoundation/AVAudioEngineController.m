//
//  AVAudioEngineController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/12/31.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AVAudioEngineController.h"

@interface AVAudioEngineController ()

@end

@implementation AVAudioEngineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

#pragma mark -- Essentials
    
    /*
     AVAudioEngine
     
     A group of connected audio node objects used to generate and
     process audio signals and perform audio input and output.

     You create each audio node separately and attach it to the
     audio engine. You can perform all operations on audio nodes
     during runtime—connecting them, disconnecting them, and
     removing them—with only minor limitations:
     •  Reconnect audio nodes only when they’re upstream of a mixer.
     •  If you remove an audio node that has differing input and
        output channel counts, or that’s a mixer, the result is
        likely to be a broken graph.
     */
    
    
    /**
     Creating an Audio Engine Instance

     - init
     Initializes a newly allocated audio engine.
     */
    AVAudioEngine *audioEngine = [AVAudioEngine new];

    /**
     Attaching and Detaching Audio Nodes

     - attachNode:
     Attaches a new audio node to the audio engine.
     
     - detachNode:
     Detaches an audio node previously attached to the audio engine.
     
     attachedNodes
     */
    
    /**
     Getting the Input, Output, and Main Mixer Nodes
     
     inputNode
     The audio engine’s singleton input audio node.
     
     outputNode
     The audio engine’s singleton output audio node.
     
     mainMixerNode
     The audio engine’s optional singleton main mixer node.
     */
    AVAudioNode *audioInputNode = audioEngine.inputNode;
    NSLog(@"inputNode %@",audioInputNode);
    
    
    /**
     Managing Audio Nodes

     - connect:to:format:
     Establishes a connection between two audio nodes.
     
     - connect:to:fromBus:toBus:format:
     Establish a connection between two audio nodes, specifying the
     input and output busses.
     
     - disconnectNodeInput:
     Removes all input connections of the audio node.
     
     - disconnectNodeInput:bus:
     Removes the input connection of an audio node on the specified bus.
     
     - disconnectNodeOutput:
     Remove all output connections of an audio node.
     
     - disconnectNodeOutput:bus:
     Remove the output connection of an audio node on the specified bus.
     */
    
    /**
     Managing MIDI Nodes

     - connectMIDI:to:format:block:
     - connectMIDI:toNodes:format:block:
     - disconnectMIDI:from:
     - disconnectMIDI:fromNodes:
     - disconnectMIDIInput:
     - disconnectMIDIOutput:
     */

    /**
     Playing Audio

     musicSequence
     The music sequence that was previously attached to the audio engine.
     
     - prepare
     Prepares the audio engine for starting.
     
     - startAndReturnError:
     Starts the audio engine.
     
     running
     A Boolean value that indicates whether the audio engine is running.
     
     - pause
     Pauses the audio engine.
     
     - stop
     Stops the audio engine and releases any previously prepared resources.
     
     - reset
     Resets all of the audio nodes in the audio engine.
     */
    
    /**
     Manually Rendering an Audio Engine

     - enableManualRenderingMode:format:maximumFrameCount:error:
     Sets the engine to operate in manual rendering mode with the
     specified render format and maximum frame count.
     
     - disableManualRenderingMode
     Sets the engine to render to or from an audio device.
     
     - renderOffline:toBuffer:error:
     Makes a render call to the engine operating in the offline manual
     rendering mode.
     */
    
    /**
     Getting Manual Rendering Properties

     AVAudioEngineManualRenderingBlock
     A block to render the engine when operating in manual rendering mode.
     
     manualRenderingBlock
     A block to render the engine when operating in manual rendering mode.
     
     manualRenderingFormat
     The render format of the engine in manual rendering mode.
     
     manualRenderingMaximumFrameCount
     The maximum number of PCM sample frames the engine can produce in
     any single render call in manual rendering mode.
     
     manualRenderingMode
     The manual rendering mode configured on the engine.
     
     manualRenderingSampleTime
     An indication of where the engine is on its render timeline in
     manual rendering mode.
     
     autoShutdownEnabled
     A Boolean value that indicates when autoshutdown is enabled.
     
     isInManualRenderingMode
     A Boolean value that indicates whether the engine is operating
     in manual rendering mode.
     */
    
    /**
     Using Connection Points

     AVAudioConnectionPoint
     A representation of either a source or destination connection
     point in the audio engine.
     
     - connect:toConnectionPoints:fromBus:format:
     Establish connections between a source node and multiple destination nodes.
     */
    
    /**
     Notifications

     AVAudioEngineConfigurationChangeNotification
     A notification posted when the audio engine configuration changes.
     */
    
    /**
     Constants
     
     AVAudioEngineManualRenderingError
     Constants that describe error codes that could be returned from
     manual rendering mode methods.
     
     AVAudioEngineManualRenderingMode
     The two modes for manual rendering.
     
     AVAudioEngineManualRenderingStatus
     Status codes returned from the render call to the engine
     operating in manual rendering mode.
     */
    
    
    /*
     AVAudioNode
     
     An abstract class for an audio generation, processing, or I/O block.
     
     AVAudioEngine objects contain instances of various AVAudioNode
     subclasses. This base class provides certain common functionality.

     Nodes have input and output busses, which can be thought of as
     connection points. For example, an effect typically has one
     input bus and one output bus. A mixer typically has multiple
     input busses and one output bus.

     Busses have formats, expressed in terms of sample rate and
     channel count. When making connections between nodes, often
     the format must match exactly. However, there are exceptions
     such as the AVAudioMixerNode and AVAudioOutputNode classes.

     Nodes do not currently provide useful functionality until
     attached to an engine.
     */
    
    /**
     Configuring an Input Format Bus
     
     - inputFormatForBus:
     Returns the input format for the specified bus.
     
     - nameForInputBus:
     Returns the name of an input bus.
     
     numberOfInputs
     The number of input busses for the node.
     */
    
    /**
     Creating and Output Format Bus
     
     - outputFormatForBus:
     Returns the output format for the specified bus.
     
     - nameForOutputBus:
     Returns the name of the output bus.
     
     numberOfOutputs
     The number of output busses for the node.
     */
    
    /**
     Installing and Removing An Audio Tap
     
     - installTapOnBus:bufferSize:format:block:
     Installs an audio tap on the bus to record, monitor, and
     observe the output of the node.
     
     - removeTapOnBus:
     Removes an audio tap on a bus.
     */
    
    /**
     Getting the Audio Engine for the Node
     
     engine
     The audio engine of the node.
     */
    
    /**
     Getting the Latest Node Render Time
     
     lastRenderTime
     The time for which the node most recently rendered.
     */
    
    /**
     Getting Audio Node Properties
     
     AUAudioUnit
     An AUAudioUnit object wrapping or underlying the implementation's
     AudioUnit instance.
     
     latency
     The processing latency of the node, in seconds.
     
     outputPresentationLatency
     The maximum render pipeline latency downstream of the node, in seconds.
     */

    /**
     Resetting the Audio Node

     - reset
     Clear a unit's previous processing state.
     */
    
    /**
     Constants
     
     AVAudioNodeTapBlock
     The block that receives copies of the output of an AVAudioNode.
     
     AVAudioNodeCompletionHandler
     A general callback handler.
     
     AVAudioNodeBus
     The index of a bus on an AVAudioNode.
     */
    
    
    /*
     AVAudioIONode
     
     The base class for nodes that connect to the system's audio
     input or output.
     
     When the engine is configured to render to and from an audio
     device, on macOS, AVAudioInputNode and AVAudioOutputNode
     communicate with the system's default input and output devices.

     On iOS, they communicate with the devices appropriate to the
     app's AVAudioSession category, configurations, and user actions,
     such as connecting or disconnecting external devices.

     In the manual rendering mode, AVAudioInputNode and AVAudioOutputNode
     perform the input and output in the engine, in response to
     the client's request.
     */
    
    /**
     Getting the Audio Unit
     
     audioUnit
     The node's underlying audio unit, if any.
     */
    
    /**
     Getting the IO Latency

     presentationLatency
     The presentation, or hardware, latency.
     */
    
    /**
     Instance Properties
     
     voiceProcessingEnabled
     */
    
    
    /*
     AVAudioInputNode
     
     A node that connects to the system’s audio input.
     
     This node has one element. The format of the input scope reflects
     the audio hardware sample rate and channel count. The format
     of the output scope is initially the same as that of the input,
     but you may set it to a different format, which will convert
     the node. For more information, see AVAudioIONode.

     ⚠️ This class has no methods of its own. It implements the
     methods defined by the AVAudioMixing protocol as well as
     the AVAudio3DMixing protocol (which is adopted by the
     AVAudioMixing protocol). For more information, see
     AVAudioMixing and AVAudio3DMixing.
     */
    
    /**
     Manually Giving Data to an Audio Engine
     
     - setManualRenderingInputPCMFormat:inputBlock:
     Supplies the data through the input node to the engine while
     operating in the manual rendering mode.
     
     AVAudioIONodeInputBlock
     A block to get input data when called by a render operation
     in the manual rendering mode.
     */
    
    /**
     Instance Properties

     voiceProcessingAGCEnabled
     voiceProcessingBypassed
     voiceProcessingInputMuted
     */
    
    
    /*
     AVAudioOutputNode
     
     This class represents an audio node that connects to the
     system’s audio output.

     This audio node has one element. The format of the output scope
     reflects the audio hardware sample rate and channel count. The
     format of the input scope is initially the same as that of the
     output, but you may set it to a different format, in which case
     the audio node will convert.
     
     ⚠️ This class has no methods of its own. It overrides methods
     defined by its parent classes.
    */
    
    
    /*
     AVAudioMixerNode
     
     A node that mixes its inputs to a single output.
     
     Mixers may have any number of inputs. The mixer node accepts
     input at any sample rate and efficiently combines sample rate
     conversions. It also accepts any channel count and will
     correctly upmix or downmix to the output channel count.
     */
    
    /**
     Creating a Mixer Node
     
     - init
     Initializes a mixer node instance.
     */
    
    /**
     Getting and Setting the Mixer Volume
     
     outputVolume
     The mixer's output volume.
     */
    
    /**
     Getting an Input Bus

     nextAvailableInputBus
     An unused input bus.
     */
    
    
    /*
     AVAudioMixing
     
     Properties that are applicable to the input bus of a mixer node.
     
     Nodes that conform to the AVAudioMixing protocol can talk to a mixer
     node downstream, specifically of the classes AVAudioMixerNode and
     AVAudioEnvironmentNode. The properties defined by this protocol
     apply to the respective input bus of the mixer node that the source
     node is connected to. Note that effect nodes can't talk to their
     downstream mixer.

     The states of properties that are set through this protocol before
     the source node is connected to the mixer node are cached and
     then applied on the mixer once the physical connection is made.
     Similarly, after disconnection, the states of the properties
     are once again cached.

     Source nodes can be disconnected from one mixer and connected
     to another with their mixing settings intact. For example, an
     AVAudioPlayerNode instance that's being used in a gaming scenario
     can set up its 3D mixing settings and then move from one
     environment to another.
      
     ⚠️ The AVAudioMixing protocol is adopted by a number of
     classes. The protocol itself conforms to the AVAudio3DMixing
     and AVAudioStereoMixing protocols. Classes that conform to
     AVAudioMixing also conform to those protocols.
     */
    
    /**
     Defining Mixing Properties

     AVAudio3DMixing
     A protocol defining 3D mixing properties.
     
     AVAudioStereoMixing
     A protocol that defines stereo mixing properties used by mixers.
     */
    
    /**
     Getting and Setting the Destination
     
     AVAudioMixingDestination
     An object representing a connection to a mixer node from a
     node that conforms to the AVAudioMixing protocol.
     
     - destinationForMixer:bus:
     Returns the AVAudioMixingDestination object corresponding
     to the specified mixer node and its input bus.
     Required.
     */
    
    /**
     Getting and Setting the Buss Volume

     volume
     The bus's input volume.
     Required.
     */
    
    
#pragma mark -- Playback
    
    /*
     AVAudioPlayerNode
     
     A class that plays buffers or segments of audio files.

     AVAudioPlayerNode supports scheduling the playback of AVAudioBuffer
     instances, or segments of audio files opened via AVAudioFile.
     Buffers and segments may be scheduled to play at specific points
     in time or to play immediately following preceding segments.

     Normally, you'll want to configure the node’s output format
     with the same number of channels as are in the files and buffers
     to be played. Otherwise, channels will be dropped or added as
     required. It's usually preferable to use an AVAudioMixerNode
     to do this configuration.

     Similarly, when playing file segments, the node will make
     sample rate conversions if necessary, but it's often preferable
     to configure the node’s output sample rate to match that of
     the files and use a mixer to perform the rate conversion.

     When playing buffers, there's an implicit assumption that
     the buffers are at the same sample rate as the node’s output
     format.

     This class overrides the AVAudioNode method reset, unschedules
     all previously scheduled buffers and file segments, and
     returns the player timeline to sample time 0.
     */
    
    /**
     Player Timeline

     The usual AVAudioNode sample times (as observed by lastRenderTime
     ) have an arbitrary zero point. AVAudioPlayerNode superimposes
     a second “player timeline” on top of this, to reflect when the
     player was started, and intervals during which it was paused.
     The methods nodeTimeForPlayerTime: and playerTimeForNodeTime:
     convert between the two.
     */
    
    /**
     Scheduling Playback Time
     
     The scheduleBuffer:atTime:options:completionHandler:,
     scheduleFile:atTime:completionHandler:, and
     scheduleSegment:startingFrame:frameCount:atTime:completionHandler:
     methods take an AVAudioTime when parameter. This parameter is
     interpreted as follows:
     •  If the when parameter is nil:
        ◦   If there have been previous commands, the new one is played
            immediately following the last one.
        ◦   Otherwise, if the node is playing, the event is played
            in the very near future.
        ◦   Otherwise, the command is played at sample time 0.
     •  If the when parameter is a sample time, the parameter is interpreted as such.
     •  If the when parameter is a host time, it's ignored unless the
        sample time is invalid. The scheduling methods fail if:
     •  A buffer's channel count doesn't match that of the node's output format.
     •  A file can't be accessed.
     •  An AVAudioTime specifies neither a valid sample time nor a host time.
     •  A segment's start frame or frame count is negative.
     */
    
    /**
     Creating a Player Node

     - init
     Initializes a player node instance.
     */
    
    /**
     Scheduling Playback
     
     - scheduleFile:atTime:completionHandler:
     Schedules playing of an entire audio file.
     
     - scheduleFile:atTime:completionCallbackType:completionHandler:
     Schedules playing of an entire audio file.
     
     - scheduleSegment:startingFrame:frameCount:atTime:completionHandler:
     Schedules playing a segment of an audio file.
     
     - scheduleSegment:startingFrame:frameCount:atTime:completionCallbackType:completionHandler:
     Schedules playing a segment of an audio file.
     
     - scheduleBuffer:atTime:options:completionHandler:
     Schedules playing samples from an audio buffer at the specified time and
     with the specified playback options.
     
     - scheduleBuffer:completionHandler:
     Schedules playing samples from an audio buffer.
     
     - scheduleBuffer:atTime:options:completionCallbackType:completionHandler:
     Schedules playing samples from an AVAudioBuffer.
     
     - scheduleBuffer:completionCallbackType:completionHandler:
     Schedules playing samples from AVAudioBuffer.
     
     AVAudioPlayerNodeCompletionCallbackType
     Constants that specify when the completion handler must be invoked.
     
     AVAudioPlayerNodeCompletionHandler
     The callback handler for buffer or file completion.
     */
    
    /**
     Converting Node and Player Times

     - nodeTimeForPlayerTime:
     Convert from player time to node time.
     
     - playerTimeForNodeTime:
     Convert from node time to player time.
     */
    
    /**
     Controlling Playback
     
     - prepareWithFrameCount:
     Prepares previously scheduled file regions or buffers for playback.
     
     - play
     Start or resume playback immediately.
     
     - playAtTime:
     Start or resume playback at a specific time.
     
     playing
     A Boolean value that indicates whether or not the player is playing.
     
     - pause
     Pause playback.
     
     - stop
     Clear all of the node's previously scheduled events and stop playback.
     */
    
    /**
     Constants

     AVAudioPlayerNodeBufferOptions
     Options controlling buffer scheduling.
     */
    
    
    /*
     AVAudioSequencer

     A collection of MIDI events organized into multiple music tracks,
     plus a player to play back the events.
     */
    
    /**
     Creating an Audio Sequencer

     - init
     Initializes a new sequencer that's not connected to an audio engine.
     
     - initWithAudioEngine:
     Initializes a new sequencer, handing it the audio engine.
     
     - writeToURL:SMPTEResolution:replaceExisting:error:
     Creates and writes a MIDI file from the events in the sequence.
     */
    
    /**
     Handling Music Tracks

     AVMusicTrack
     A collection of music events sent to a given destination, and
     which can be offset, muted, and manipulated independently from other track events.
     
     AVMusicTrackLoopCount
     Constants that define the number of times a track will loop.
     */
    
    /**
     Operating an Audio Sequencer

     - prepareToPlay
     Gets ready to play the sequence by prerolling all events.
     
     - startAndReturnError:
     Start the sequencer's player.
     
     - stop
     Stops the sequencer's player.
     */
    
    /**
     Managing Sequence Load Options
     
     - loadFromData:options:error:
     Parses the data and adds its events to the sequence.
     
     - loadFromURL:options:error:
     Loads the file referenced by the URL and adds the events to the sequence.
     
     AVMusicSequenceLoadOptions
     A structure that defines whether data on different MIDI channels
     is mapped to multiple tracks, or if the tracks are preserved as they are.
     */
    
    /**
     Managing Time Stamps
     
     AVMusicTimeStamp
     A fractional number of beats.
     
     - hostTimeForBeats:error:
     Returns the host time that will be (or was) played at the specified beat.
     
     - secondsForBeats:
     Gets the time, in seconds, for the given beat position
     (timestamp) in the track.
     */
    
    /**
     Handling Beat Range
     
     - beatsForHostTime:error:
     Returns the beat that will be (or was) played at the
     specified host time.
     
     - beatsForSeconds:
     Gets the beat position (timestamp) for the given time in the track.
     
     AVBeatRange
     A specific time range within a music track.
     */
    
    /**
     Getting Sequence Properties

     - dataWithSMPTEResolution:error:
     Returns a data object containing the events from the sequence.
     
     currentPositionInBeats
     The current playback position in beats.
     
     currentPositionInSeconds
     The current playback position, in seconds.
     
     playing
     A Boolean value that indicates whether or not the sequencer's
     player is playing.
     
     rate
     The playback rate of the sequencer's player.
     
     tempoTrack
     The tempo track.
     
     tracks
     An array containing all the tracks in the sequence.
     
     userInfo
     A dictionary containing metadata derived from a sequence.
     */
    
    
    /*
     AVAudioUnitSampler
     
     A class that encapsulates Apple's Sampler Audio Unit.

     You can configure the sampler audio unit by loading different
     types of instruments, such as an .aupreset file, a DLS or
     SF2 sound bank, an EXS24 instrument, a single audio file,
     or an array of audio files. The output is a single stereo bus.
     */
    
    /**
     Configuring the Sampler Audio Unit

     - loadAudioFilesAtURLs:error:
     Configures the sampler by loading the specified audio files.
     
     - loadInstrumentAtURL:error:
     Configures the sampler with the specified instrument file.
     
     - loadSoundBankInstrumentAtURL:program:bankMSB:bankLSB:error:
     Loads a specific instrument from the specified sound bank.
     */
    
    /**
     Getting and Setting Sampler Values

     globalTuning
     Adjustment for the tuning of all the notes played.
     
     masterGain
     Adjustment for the gain, in decibels, of all the notes played.
     
     stereoPan
     Adjustment for the stereo panning of all the notes played.
     */
    
    
    /*
     AVAudioUnitMIDIInstrument
     
     An abstract class representing music devices or remote instruments.
     
     An AVAudioUnitMIDIInstrument subclass can be used in a chain that
     processes real-time (live) input and has general concept of
     music events; for example, notes.
     */
    
    /**
     Creating a MIDI Instrument Audio Unit
     
     - initWithAudioComponentDescription:
     Initializes a MIDI instrument audio unit with the specified component description.
     */
    
    /**
     Sending Information to the MIDI Instrument
     
     - sendController:withValue:onChannel:
     Send a MIDI controller event to the instrument.
     
     - sendMIDIEvent:data1:
     Sends a MIDI event which contains one data byte to the instrument.
     
     - sendMIDIEvent:data1:data2:
     Sends a MIDI event which contains two data bytes to the instrument.
     
     - sendMIDISysExEvent:
     Sends a MIDI System Exclusive event to the instrument.
     
     - sendPitchBend:onChannel:
     Sends a MIDI Pitch Bend event to the instrument.
     
     - sendPressure:onChannel:
     Sends a MIDI channel pressure event to the instrument.
     
     - sendPressureForKey:withValue:onChannel:
     Sends a MIDI Polyphonic key pressure event to the instrument.
     
     - sendProgramChange:bankMSB:bankLSB:onChannel:
     Sends MIDI Program Change and Bank Select events to the instrument.
     
     - sendProgramChange:onChannel:
     Sends MIDI Program Change and Bank Select events to the instrument.
     */
    
    /**
     Starting and Stopping Play

     - startNote:withVelocity:onChannel:
     Sends a MIDI Note On event to the instrument.
     
     - stopNote:onChannel:
     Sends a MIDI Note Off event to the instrument
     */
    
    
#pragma mark -- Audio Units

    /**
     Perform realtime signal processing of audio files and streams.
     */
    
    
#pragma mark -- Spatial Audio

    /*
     AVAudioEnvironmentNode
     
     A mixer node that simulates a 3D audio environment.
     
     Any node that conforms to the AVAudioMixing protocol (for example,
     AVAudioPlayerNode) can act as a source in this environment.

     The environment has an implicit “listener.” By controlling the
     listener’s position and orientation, the application controls
     the way the user experiences the virtual world. This node also
     defines properties for distance attenuation and reverberation
     that help characterize the environment.
     
     Only inputs with a mono channel connection format to the
     environment node are spatialized. If the input is stereo, the
     audio is passed through without being spatialized. Inputs
     with connection formats of more than two channels aren't
     supported.

     To set the environment node’s output to a multichannel
     format, use an AVAudioFormat that has one of the following
     Audio Channel Layout Tags:
     •kAudioChannelLayoutTag_AudioUnit_4
     •kAudioChannelLayoutTag_AudioUnit_5_0
     •kAudioChannelLayoutTag_AudioUnit_6_0
     •kAudioChannelLayoutTag_AudioUnit_7_0
     •kAudioChannelLayoutTag_AudioUnit_7_0_Front
     •kAudioChannelLayoutTag_AudioUnit_8
     */
    
    /**
     Creating an Environment Node
     
     - init
     Initializes a new environment node.
     */
    
    /**
     Getting and Setting Environment Parameters
     
     distanceAttenuationParameters
     The distance attenuation parameters for the environment.
     
     listenerAngularOrientation
     The listener's angular orientation in the environment.
     
     listenerVectorOrientation
     The listener's vector orientation in the environment.
     
     listenerPosition
     The listener's position in the 3D environment.
     
     reverbParameters
     The reverb parameters for the environment.
     
     outputVolume
     The mixer's output volume.
     */
    
    /**
     Getting the Available Rendering Algorithms
     
     applicableRenderingAlgorithms
     An array of rendering algorithms applicable to the environment node.
     */
    
    /**
     Getting the Input Bus

     nextAvailableInputBus
     An unused input bus.
     */
    
    /**
     Instance Properties

     outputType
     The type of output hardware.
     */

    
    /*
     AVAudioEnvironmentReverbParameters
     
     A class that encapsulates the parameters that you use to
     control the reverb of the environment node class.

     Reverberation can be used to simulate the acoustic characteristics
     of an environment. The AVAudioEnvironmentNode class has a
     built-in reverb that describes the space that the listener is in.

     The reverb also has a single filter that sits at the end of the
     chain. You can use this filter to shape the overall sound of
     the reverb. For instance, select one of the reverb presets to
     simulate the general space and then use the filter to brighten
     or darken the overall sound.

     You can't create a standalone instance of
     AVAudioEnvironmentReverbParameters. Only an instance vended
     by a source object, such as an AVAudioEnvironmentNode
     instance, is valid.
     */
    
    /**
     Enabling and Disabling Reverb
     
     enable
     Enables the reverberation.
     */
    
    /**
     Getting and Setting Reverb Values
     
     filterParameters
     The filter that applies to the output of the reverb.
     
     level
     The primary level, in decibels, of the reverb.
     
     - loadFactoryReverbPreset:
     Loads one of the reverbs factory presets.
     */
    
    
    /*
     AVAudioEnvironmentDistanceAttenuationParameters
     
     A class that specifies the attenuation distance, the gradual
     loss in audio intensity, and other characteristics.
     */
    
    /**
     Getting and Setting the Attenuation Model
     
     distanceAttenuationModel
     The distance attenuation model describing the drop-off in
     gain as the source moves away from the listener.
     */
    
    /**
     Getting and Setting the Attenuation Values
     
     maximumDistance
     The distance, in meters, beyond which no further attenuation is applied.
     
     referenceDistance
     The minimum distance, in meters, at which attenuation is applied.
     
     rolloffFactor
     A factor that determines the attenuation curve.
     */
    
    /**
     Constants
     
     AVAudioEnvironmentDistanceAttenuationModel
     Types of distance attenuation models.
     */
    
    
    /*
     AVAudioEnvironmentOutputType
     
     The output hardware types to use with an automatically selected
     rendering algorithm.

     The output type determines the rendering method for any input
     bus using AVAudio3DMixingRenderingAlgorithmAuto. Set the output
     type of an AVAudioEnvironmentNode object by setting its outputType
     property.
     */
    
    
    /*
     AVAudio3DMixing
     
     A protocol defining 3D mixing properties.
     These properties are only implemented by the AVAudioEnvironmentNode mixer.
     
     ⚠️ This protocol is adopted by the AVAudioMixing protocol.
     As a result, a number of classes inherit this protocol by
     adopting AVAudioMixing.
     */
    
    /**
     Getting the 3D Mixing Parameters
     
     obstruction
     This value simulates filtering of the direct path of sound due
     to an obstacle.
     Required.
     
     occlusion
     A value that simulates filtering of the direct and reverb paths
     of sound due to an obstacle.
     Required.
     
     position
     The location of the source in the 3D environment.
     Required.
     
     rate
     A value that changes the playback rate of the input signal.
     Required.
     
     renderingAlgorithm
     The type of rendering algorithm used.
     Required.
     
     reverbBlend
     A value that controls the blend of dry and reverb processed audio.
     Required.
     */

    /**
     Constants

     AVAudio3DMixingRenderingAlgorithm
     The types of rendering algorithms available per input bus of
     the environment node.
     */
    
    /**
     Instance Properties

     pointSourceInHeadMode
     The in-head mode for a point source.
     Required.
     
     sourceMode
     The source mode for the input bus of the audio environment node.
     Required.
     */

    
    /*
     AVAudio3DMixingSourceMode
     
     The source modes for the input bus of the audio environment node.
     The source mode determines how the individual channels of an input bus
     are distributed in space.
     
     AVAudio3DMixingSourceModeSpatializeIfMono
     A mono input bus is rendered as a point source at the location
     of the source node.
     
     AVAudio3DMixingSourceModeBypass
     No spatial rendering.
     
     AVAudio3DMixingSourceModePointSource
     All channels of the bus are rendered as a single source at the
     location of the source node.
     
     AVAudio3DMixingSourceModeAmbienceBed
     The input channels are spatialized around the listener as
     far-field sources anchored to global space.
     */
    
    
    /*
     AVAudio3DMixingPointSourceInHeadMode
     
     The in-head modes for a point source.

     The in-head mode determines what happens when a point source
     (AVAudio3DMixingSourceModePointSource) moves inside the
     head of the listener. The in-head mode applies if you’re
     using the AVAudio3DMixingRenderingAlgorithmAuto rendering algorithm.
     */
    
    /**
     Point Source In-Head Modes
        
     AVAudio3DMixingPointSourceInHeadModeMono
     The point source remains a single mono source inside the head
     of the listener regardless of the channels it consists of.
     
     AVAudio3DMixingPointSourceInHeadModeBypass
     The point source splits into bypass inside the head of the listener.
     */

    
    /*
     AVAudio3DPoint
     
     A structure representing a point in 3D space.
     
     This structure is used by classes dealing with 3D audio,
     such as those that adopt the AVAudioMixing protocol and
     the AVAudioEnvironmentNode class. The structure represents
     a point in 3D space, in meters.
     */
    
    /**
     Defining a Point
     
     AVAudioMake3DPoint
     Creates and returns an AVAudio3DPoint object.
     */
    
    /**
     Getting Point Properties
     
     x
     The location on the x-axis, in meters.
     
     y
     The location on the y-axis, in meters.
     
     z
     The location on the z-axis, in meters.
     */
    
    
    /*
     AVAudio3DVector
     
     A structure representing a vector in 3D space.
     
     This structure is used by classes dealing with 3D audio
     such as those that adopt the AVAudioMixing protocol
     and the AVAudioEnvironmentNode class. The structure
     represents a vector in 3D space, in degrees.
     */
    
    
    /*
     AVAudio3DAngularOrientation
        
     A structure representing the angular orientation of the
     listener in 3D space.
     */
    
    /**
     Defining an Angular Orientation
     
     AVAudioMake3DAngularOrientation
     Creates and returns an AVAudio3DAngularOrientation object.
     */
    
    /**
     Getting Angular Orientation Properties
     
     pitch
     The up-down movement of the listener’s head.
     
     roll
     The tilt of the listener’s head.
     
     yaw
     The side-to-side movement of the listener’s head.
     */
    
    
    /*
     AVAudio3DVectorOrientation
     
     A structure representing two orthogonal vectors that describe
     the orientation of the listener in 3D space.
     */

    /**
     Defining a Vector Orientation

     AVAudioMake3DVectorOrientation
     Creates and returns an AVAudio3DVectorOrientation object.
     */
    
    /**
     Getting Vector Orientation Properties
     
     forward
     The forward vector points in the direction that the listener is facing.
     
     up
     The up vector is orthogonal to the forward vector and points
     upwards from the listener’s head.
     */
    
    
#pragma mark -- Audio Rendering
    
    /*
     AVAudioSourceNode
     
     A node that supplies audio data.

     Use an audio source node to supply audio data for rendering
     through an AVAudioSourceNodeRenderBlock block. This approach
     is similar to setting the input callback on an audio unit by
     using the kAudioUnitProperty_SetRenderCallback property.
     */
    
    /**
     Creating an Audio Source Node
     
     - initWithRenderBlock:
     Creates an audio source node with a block that supplies audio data.
     
     - initWithFormat:renderBlock:
     Creates an audio source node with the specified audio format and
     a block that supplies audio data.
     
     AVAudioSourceNodeRenderBlock
     A block that supplies audio data to an audio source node.
     */
    
    
    /*
     AVAudioSinkNode
     A node that receives audio data.
     
     Use an audio sink node to receive audio data input through an
     AVAudioSinkNodeReceiverBlock block.

     An audio sink node is restricted to use in the input chain,
     so it doesn’t support format conversion. When you connect
     to an audio sink node, the format for the connection should
     be the output scope format of the input node.

     An audio sink node is only supported when the engine is
     rendering to the audio device. It isn’t supported in manual
     rendering mode.

     An audio sink node doesn’t have an output bus, so it doesn’t
     support tapping.
     */
    
    /**
     Creating an Audio Sink Node
     
     - initWithReceiverBlock:
     Creates an audio sink node with a block that receives audio data.
     
     AVAudioSinkNodeReceiverBlock
     A block that receives audio data from an audio sink node.
     */
    
    
#pragma mark -- Audio Conversion
    
    /*
     AVAudioConverter
     
     A class that converts streams of audio between various formats.
     */
    
    /**
     Creating an Audio Converter
     
     - initFromFormat:toFormat:
     Initializes an audio converter from input and output formats.
     */
    
    /**
     Converting Audio Formats
     
     - convertToBuffer:error:withInputFromBlock:
     Performs any supported conversion.
     
     - convertToBuffer:fromBuffer:error:
     Performs a simple conversion that doesn't involve codecs or
     sample rate conversion.
     */
    
    /**
     Resetting an Audio Converter
     
     - reset
     Resets the converter so that a new stream can be converted.
     */
    
    /**
     Getting Audio Converter Properties
     
     channelMap
     An array of integers indicating from which input to derive each output.
     
     dither
     A Boolean value that indicates whether dither is on.
     
     downmix
     A Boolean value that indicates whether the channels will be mixed
     instead of remapped.
     
     inputFormat
     The format of the input audio stream.
     
     outputFormat
     The format of the output audio stream.
     
     magicCookie
     An object that contains metadata required by encoders and decoders.
     
     maximumOutputPacketSize
     The maximum size of an output packet, in bytes.
     */
        
    /**
     Getting Bit Rate Properties
     
     applicableEncodeBitRates
     When encoding, an array of bit rates that can be applied based
     on the current formats and settings.
     
     availableEncodeBitRates
     When encoding, an array of all bit rates provided by the codec.
     
     availableEncodeChannelLayoutTags
     When encoding, an array of all output channel layout tags provided
     by the codec.
     
     bitRate
     The bit rate, in bits per second.
     
     bitRateStrategy
     An AVEncoderBitRateStrategyKey value constant used during encoding.
     */
    
    /**
     Getting Sample Rate Properties

     sampleRateConverterQuality
     An AVSampleRateConverterAlgorithmKey value.
     
     sampleRateConverterAlgorithm
     The priming method to be used by the sample rate converter
     or decoder.
     
     applicableEncodeSampleRates
     When encoding, an array of output sample rates that can be
     applied based on the current formats and settings.
     
     availableEncodeSampleRates
     When encoding, an array of all output sample rates provided by the codec.
     */
    
    /**
     Getting Priming Information
     
     primeInfo
     The number of priming frames.
     
     primeMethod
     The priming method to be used by the sample rate converter or decoder.
     
     AVAudioConverterPrimeInfo
     Priming information for audio conversion.
     */
    
    /**
     Constants
        
     AVAudioConverterInputStatus
     Status codes returned by AVAudioConverterInputBlock.
     
     AVAudioConverterOutputStatus
     Status codes returned by convertToBuffer:error:withInputFromBlock:.
     
     AVAudioConverterPrimeMethod
     Values for the primeMethod property.
     */
    
    
#pragma mark -- Supporting Data Types
    
    /*
     AVAudioFile
     An audio file that can be opened for reading or writing.
     
     Regardless of the file’s actual format, you read and write it
     using AVAudioPCMBuffer objects that contain samples using
     AVAudioCommonFormat. This format is referred to as the file’s
     processing format. Conversions are performed to and from the
     file’s actual format.

     Reads and writes are always sequential, but random access
     is possible by setting the framePosition property.
     */
    
    /**
     Creating an Audio File

     - initForReading:commonFormat:interleaved:error:
     Open a file for reading using a specified processing format.
     
     - initForReading:error:
     Opens a file for reading.
     
     - initForWriting:settings:commonFormat:interleaved:error:
     Open a file for writing using a specified processing format.
     
     - initForWriting:settings:error:
     Open a file for writing.
     */
    
    /**
     Reading and Writing the Audio Buffer

     - readIntoBuffer:error:
     Read an entire buffer.
     
     - readIntoBuffer:frameCount:error:
     Read a portion of a buffer.
     
     - writeFromBuffer:error:
     Write a buffer.
     */
    
    /**
     Getting Audio File Properties

     fileFormat
     The on-disk format of the file.
     
     processingFormat
     The processing format of the file.
     
     framePosition
     The position in the file at which the next read or write
     operation will occur.
     
     AVAudioFramePosition
     A position in an audio file or stream.
     
     length
     The number of sample frames in the file.
     
     AVAudioFrameCount
     A number of audio sample frames.
     
     url
     The URL the file is reading or writing.
     
     AVAudioFileTypeKey
     A string indicating the audio file type.
     */
    
    
    /*
     AVAudioTime
     A class used by the audio engine to represent time.
     
     Instances of this class are immutable.
     
     A single moment in time may be represented in two different ways:
     •  Using mach_absolute_time(), the system's basic clock. Referred
        to as “host time.”
     •  Audio samples at a particular sample rate.

     A single AVAudioTime instance may contain either or
     both representations; it might represent only a sample time,
     only a host time, or both.
     */
    
    /**
     Creating an Audio Time Instance
     
     - initWithAudioTimeStamp:sampleRate:
     Initializes a new audio time object with the AudioTimeStamp
     struct and sample rate.
     
     - initWithHostTime:
     Initializes a new audio time object with the specified host time.
     
     - initWithHostTime:sampleTime:atRate:
     Initializes a new audio time object with the specified host time,
     sample time, and sample rate.
     
     - initWithSampleTime:atRate:
     Initializes a new audio time object with the specified
     AudioTimeStamp struct and sample rate.
     
     + timeWithAudioTimeStamp:sampleRate:
     Creates an audio time object with the specified AudioTimeStamp
     struct and sample rate.
     
     + timeWithHostTime:sampleTime:atRate:
     Creates an audio time object with the specified host time, sample
     time, and sample rate.
     
     + timeWithSampleTime:atRate:
     Creates an audio time object with the specified sample time and
     sample rate.
     
     + timeWithHostTime:
     Creates an audio time object with the specified host time.
     
     - extrapolateTimeFromAnchor:
     Creates an audio time object by converting between host and sample time.
     */
    
    /**
     Manipulating Host Time

     hostTime
     The host time.
     
     hostTimeValid
     A Boolean value that indicates whether the host time value is valid.
     
     + hostTimeForSeconds:
     Converts seconds to host time.
     
     + secondsForHostTime:
     Converts host time to seconds.
     */
    
    /**
     Getting Sample Rate Information
     
     sampleRate
     The sample rate at which the sample time is being expressed.
     
     sampleTime
     The time as a number of audio samples, as tracked by the
     current audio device.
     
     sampleTimeValid
     A Boolean value that indicates whether the sample time and
     sample rate properties are valid.
     */
    
    /**
     Getting the CoreAudio Time Stamp

     audioTimeStamp
     The time expressed as an AudioTimeStamp structure.
     */
    
    
    /*
     Audio Settings and Formats
     Define audio data with these constants and classes.

     == Formats
     AVAudioFormat
     A class that represents a buffer of audio data with a format.
     
     AVAudioChannelLayout
     The roles of a set of audio channels.
     
     AVChannelLayoutKey
     The corresponding value is an NSData object containing an
     AudioChannelLayout structure.
     */
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
