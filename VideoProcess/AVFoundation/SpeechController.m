//
//  SpeechController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "SpeechController.h"

@interface SpeechController ()

@end

@implementation SpeechController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /*
     Convert text to spoken audio.

     The Speech Synthesis framework manages voice and speech synthesis,
     and requires two primary tasks:
     Create an AVSpeechUtterance instance that contains the text to
     speak. Optionally, configure speech parameters, such as voice
     and rate, for each utterance.
     
     // Create an utterance.
     let utterance = AVSpeechUtterance(string: "The quick brown fox jumped over the lazy dog.")

     // Configure the utterance.
     utterance.rate = 0.57
     utterance.pitchMultiplier = 0.8
     utterance.postUtteranceDelay = 0.2
     utterance.volume = 0.8

     // Retrieve the British English voice.
     let voice = AVSpeechSynthesisVoice(language: "en-GB")

     // Assign the voice to the utterance.
     utterance.voice = voice
     
     Pass the utterance to an AVSpeechSynthesizer instance to produce
     spoken audio.

     // Create a speech synthesizer.
     let synthesizer = AVSpeechSynthesizer()

     // Tell the synthesizer to speak the utterance.
     synthesizer.speak(utterance)
     
     Optionally, use the speech synthesizer instance to control or
     respond to ongoing speech; for example, assign its delegate to
     receive speech event notifications.
     */
    
    
#pragma mark --      Spoken Text Attributes

    /*
     AVSpeechUtterance
     
     An object that encapsulates the text for speech synthesis
     and parameters that affect the speech.

     An AVSpeechUtterance is the basic unit of speech synthesis.
     To synthesize speech, create an AVSpeechUtterance instance with
     text you want a speech synthesizer to speak. Optionally, change
     the voice, pitchMultiplier, volume, rate, preUtteranceDelay, or
     postUtteranceDelay parameters for the utterance. Pass the utterance
     to an instance of AVSpeechSynthesizer to begin speech, or enqueue
     the utterance to speak later if the synthesizer is already speaking.
     
     Split a body of text into multiple utterances if you want to apply
     different speech parameters. For example, you can emphasize a
     sentence by increasing the pitch and decreasing the rate of that
     utterance relative to others, or you can introduce pauses between
     sentences by putting each into an utterance with a leading or
     trailing delay.
     
     Set and use the AVSpeechSynthesizerDelegate to receive notifications
     when the synthesizer starts or finishes speaking an utterance.
     Create an utterance for each meaningful unit in a body of text
     if you want to receive notifications as its speech progresses.
     */
    
    /**
     Creating an Utterance

     - initWithString:
     Creates an utterance with the text string that you specify for
     the speech synthesizer to speak.
     
     + speechUtteranceWithString:
     Creates an utterance with the text string that you specify
     for the speech synthesizer to speak.
     
     - initWithAttributedString:
     Creates an utterance with the attributed text string that you
     specify for the speech synthesizer to speak.
     
     + speechUtteranceWithAttributedString:
     Creates an utterance with the attributed text string that you
     specify for the speech synthesizer to speak.
     
     AVSpeechSynthesisIPANotationAttribute
     A string that contains International Phonetic Alphabet (IPA)
     symbols the speech synthesizer uses to control pronunciation
     of certain words or phrases.
     */
    
    /**
     Configuring an Utterance

     voice
     The voice the speech synthesizer uses when speaking the utterance.
     
     pitchMultiplier
     The baseline pitch the speech synthesizer uses when speaking the utterance.
     
     volume
     The volume the speech synthesizer uses when speaking the utterance.
     
     prefersAssistiveTechnologySettings
     A Boolean that specifies whether assistive technology settings
     take precedence over the property values of this utterance.
     */

    
    /**
     Configuring Utterance Timing

     rate
     The rate the speech synthesizer uses when speaking the utterance.
     
     AVSpeechUtteranceMinimumSpeechRate
     The minimum rate the speech synthesizer uses when speaking an utterance.
     
     AVSpeechUtteranceMaximumSpeechRate
     The maximum rate the speech synthesizer uses when speaking an utterance.
     
     AVSpeechUtteranceDefaultSpeechRate
     The default rate the speech synthesizer uses when speaking an utterance.
     
     preUtteranceDelay
     The amount of time the speech synthesizer pauses before speaking the
     utterance.
     
     postUtteranceDelay
     The amount of time the speech synthesizer pauses after speaking an utterance
     before handling the next utterance in the queue.
     */
    
    
    /**
     Inspecting Utterance Text

     speechString
     A string that contains the text for speech synthesis.
     
     attributedSpeechString
     An attributed string that contains the text for speech
     synthesis.
     */
    
    
    
#pragma mark -- AVSpeechSynthesisVoice
    
    /*
     A distinct voice for use in speech synthesis.

     The primary factors that distinguish a voice in speech synthesis
     are language, locale, and quality. Create an instance of
     AVSpeechSynthesisVoice to select a voice that’s appropriate for
     the text and the language, and set it as the value of the voice
     property on an AVSpeechUtterance instance. The voice may optionally
     reflect a local variant of the language, such as Australian or South
     African English. For a complete list of supported languages, see
     Languages Supported by VoiceOver.
     */

    /**
     Obtaining Voices

     + voiceWithIdentifier:
     Retrieves a voice for the identifier you specify.
     
     + voiceWithLanguage:
     Retrieves a voice for the BCP 47 code language code you specify.
     
     + speechVoices
     Retrieves all available voices on the device.
     
     AVSpeechSynthesisVoiceIdentifierAlex
     The voice that the system identifies as Alex.
     Inspecting
     */
    
    /**
     Inspecting Voices

     identifier
     The unique identifier of a voice.
     
     name
     The name of a voice.
     
     quality
     The speech quality of a voice.
     
     AVSpeechSynthesisVoiceQuality
     The speech quality of a voice.
     
     gender
     The gender for a voice.
     
     AVSpeechSynthesisVoiceGender
     The gender for a voice.
     
     audioFileSettings
     A dictionary that contains audio file settings.
     */
    
    /**
     Working with Language Codes

     + currentLanguageCode
     Returns the language and locale code for the user’s current locale.
     
     language
     A BCP 47 code that contains the voice’s language and locale.
     */
    
    
#pragma mark  -- Speech Synthesis Controls

    /*
     AVSpeechSynthesizer
     
     An object that produces synthesized speech from text utterances
     and enables monitoring or controlling of ongoing speech.

     To speak some text, create an AVSpeechUtterance instance that
     contains the text and pass it to speakUtterance: on a speech
     synthesizer instance. You can optionally also retrieve an
     AVSpeechSynthesisVoice and set it on the utterance’s voice
     property to have the speech synthesizer use that voice when
     speaking the utterance’s text.
     
     The speech synthesizer maintains a queue of utterances that
     it speaks. If the synthesizer isn’t speaking, calling
     speakUtterance: begins speaking that utterance either immediately
     or after pausing for its preUtteranceDelay, if necessary. If
     the synthesizer is speaking, the synthesizer adds utterances
     to a queue and speaks them in the order it receives them.
     
     After speech begins, you can use the synthesizer object to
     pause or stop speech. After pausing, you can resume the
     speech from its paused point or stop the speech entirely
     and remove all remaining utterances in the queue.
     
     You can monitor the speech synthesizer by examining its
     speaking and paused properties, or by setting a delegate
     that conforms to AVSpeechSynthesizerDelegate. The delegate
     receives significant events as they occur during speech
     synthesis.
     
     An AVSpeechSynthesizer also controls the route where the
     speech plays. See Directing Speech Output for more information.
     
     ⚠️ The system doesn’t automatically retain the speech synthesizer
     so you need to manually retain it until speech concludes.
     */
    
    /**
     Controlling Speech

     - speakUtterance:
     Adds the utterance you specify to the speech synthesizer’s queue.
     
     - continueSpeaking
     Resumes speech from its paused point.
     
     - pauseSpeakingAtBoundary:
     Pauses speech at the boundary you specify.
     
     - stopSpeakingAtBoundary:
     Stops speech at the boundary you specify.
     
     AVSpeechBoundary
     Specifies when to pause or stop speech.
     */
    
    /**
     Inspecting a Speech Synthesizer

     speaking
     A Boolean value that indicates whether the speech synthesizer
     is speaking or is in a paused state and has utterances to speak.
     
     paused
     A Boolean value that indicates whether a speech synthesizer is
     in a paused state.
     */
    
    /**
     Managing the Delegate

     delegate
     The delegate object for the speech synthesizer.
     
     AVSpeechSynthesizerDelegate
     A delegate protocol that contains optional methods you can
     implement to respond to events that occur during speech synthesis.
     */
    
    /**
     Directing Speech Output

     usesApplicationAudioSession
     A Boolean value that specifies whether the app manages the audio
     session.
     
     mixToTelephonyUplink
     A Boolean value that specifies whether to send synthesized speech
     to an active call.
     
     outputChannels
     An array of audio session channels to route generated speech.
     
     - writeUtterance:toBufferCallback:
     Generates speech for the utterance and invokes the callback with
     the audio buffer.
     
     AVSpeechSynthesizerBufferCallback
     A type that defines a callback that receives a buffer of generated speech.
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
