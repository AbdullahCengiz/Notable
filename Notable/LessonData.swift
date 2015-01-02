//
//  LessonData.swift
//  Notable
//
//  Created by abdullah cengiz on 10/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation

class LessonData
{

    var lessons : [Lesson]?
    init(){
        self.lessons = []
    }


    func createLessons()->[Lesson]{

        // create 1st lesson and add its' questions  ************************************************************************************
        var lesson1 = Lesson(lessonId: 0, lessonName: "Basic music theory", lessonHint: "Note names and clefs")


        var l1q1 = LessonQuestion(questionId:1,lessonId: 0, questionType: "Text", questionText: "We are happy to see that you've decided to learn how to read some sheet music, in this lesson we will go through the most basic parts of it. We will show you the staff and how different placements of the notes on the staff affects the sound. We will also go through the two most common clefs as well as ledger lines!", questionTitle: "Welcome!", noteText: "", clefType: "",imageName:"")

        lesson1.lessonQuestions!.append(l1q1)

        var l1q2 = LessonQuestion(questionId:2,lessonId: 0, questionType: "Image", questionText: "This is what an empty note sheet looks like, it is called a staff and the placement of the note on this decide the pitch of the tone", questionTitle: "", noteText: "", clefType: "",imageName:"")

        lesson1.lessonQuestions!.append(l1q2)

        var l1q3 = LessonQuestion(questionId:3,lessonId: 0, questionType: "Image", questionText: "We've now added a G-clef, this indicates where the note G is", questionTitle: "", noteText: "", clefType: "gclef",imageName:"")

        lesson1.lessonQuestions!.append(l1q3)

        var l1q4 = LessonQuestion(questionId:4,lessonId: 0, questionType: "Image", questionText: "Voila! Now we added the note for G, this might make it easier to understand why the clef is called a G-clef", questionTitle: "", noteText: "G4", clefType: "gclef",imageName:"")

        lesson1.lessonQuestions!.append(l1q4)

        var l1q5 = LessonQuestion(questionId:5,lessonId: 0, questionType: "Image", questionText: "If we go down a couple of notes we hit the note C, this note is usually in the middle of the piano and a good note to start out from when learning!", questionTitle: "", noteText: "C4", clefType: "gclef",imageName:"")

        lesson1.lessonQuestions?.append(l1q5)

        var l1q6 = LessonQuestion(questionId:6,lessonId: 0, questionType: "Image", questionText: "Let's add even more notes!", questionTitle: "", noteText: "C4|D4|E4|F4|G4|A4|H4", clefType: "gclef",imageName:"")

        lesson1.lessonQuestions?.append(l1q6)

        var l1q7 = LessonQuestion(questionId:7,lessonId: 0, questionType: "Image", questionText: "But what happens if we go on to the next note? We get to another C! It has the exact same sound as the last C, with the difference that it is a bit more high", questionTitle: "", noteText: "C5", clefType: "gclef",imageName:"")

        lesson1.lessonQuestions?.append(l1q7)

        var l1q8 = LessonQuestion(questionId:8,lessonId: 0, questionType: "Image", questionText: "To make sure I'm not lying, play these notes and try to hear the resemblance", questionTitle: "", noteText: "C4|C5", clefType: "gclef",imageName:"")

        lesson1.lessonQuestions?.append(l1q8)

        var l1q9 = LessonQuestion(questionId:9,lessonId: 0, questionType: "Image", questionText: "Well, this is fun and all but what happen if we go further? We continue with C D E F G", questionTitle: "", noteText: "C5|D5|E5|F5|G5", clefType: "gclef",imageName:"")

        lesson1.lessonQuestions?.append(l1q9)

        var l1q10 = LessonQuestion(questionId:10,lessonId: 0, questionType: "Image", questionText: "Oops, we've run out of lines! What to do?", questionTitle: "", noteText: "G5", clefType: "gclef",imageName:"")

        lesson1.lessonQuestions?.append(l1q10)

        var l1q11 = LessonQuestion(questionId:11,lessonId: 0, questionType: "Image", questionText: "Just add something called a ledger line and continue!", questionTitle: "", noteText: "G5|A5|H5|C6|D6|E6", clefType: "gclef",imageName:"")

        lesson1.lessonQuestions?.append(l1q11)

        var l1q12 = LessonQuestion(questionId:12,lessonId: 0, questionType: "Text", questionText: "But adding too many ledger lines will make it look messy. If you're a man and always sing in a lower pitch it can be hard to identify the note if there are a lot of ledger lines. How do we solve this?",questionTitle: "A mess...", noteText: "", clefType: "",imageName:"")

        lesson1.lessonQuestions?.append(l1q12)

        var l1q13 = LessonQuestion(questionId:13,lessonId: 0, questionType: "Text", questionText: "We do it by changing clef! There are a lot of different clefs, but we are going to look at the most common one after G-clef called the F-clef.",questionTitle: "The F-clef", noteText: "", clefType: "",imageName:"")

        lesson1.lessonQuestions?.append(l1q13)

        var l1q14 = LessonQuestion(questionId:14,lessonId: 0, questionType: "Image", questionText: "This is what the f-clef looks like",questionTitle: "", noteText: "", clefType: "",imageName:"fclef.png")

        lesson1.lessonQuestions?.append(l1q14)

        var l1q15 = LessonQuestion(questionId:15,lessonId: 0, questionType: "Image", questionText: "In the same fashion as for the G-clef, the F-clef has gotten its name from the note out of which it is drawn", questionTitle: "", noteText: "F3", clefType: "fclef",imageName:"")

        lesson1.lessonQuestions?.append(l1q15)

        var l1q16 = LessonQuestion(questionId:16,lessonId: 0, questionType: "Image", questionText: "From this we can draw the rest of the notes as before", questionTitle: "", noteText: "F3|E3|D3|C3|H2|A2", clefType: "fclef",imageName:"")

        lesson1.lessonQuestions?.append(l1q16)

        var l1q17 = LessonQuestion(questionId:17,lessonId: 0, questionType: "Image", questionText: "But what is the correlation between the different clefs? Well an easy way to think is that this note on the first top ledger line in F-clef", questionTitle: "", noteText: "C4", clefType: "fclef",imageName:"")

        lesson1.lessonQuestions?.append(l1q17)

        var l1q18 = LessonQuestion(questionId:18,lessonId: 0, questionType: "Image", questionText: "Is the same as this note on the first lower ledger line in F-clef", questionTitle: "", noteText: "C4", clefType: "gclef",imageName:"")

        lesson1.lessonQuestions?.append(l1q18)

        var l1q19 = LessonQuestion(questionId:19,lessonId: 0, questionType: "Text", questionText: "Using what you've learnt so far you are now ready to start practicing the basic and intermediate lessons of both G-clef and F-clef, so what are you waiting for! Get back here for the next lesson once you've gotten the hang of it!", questionTitle: "Go practice!", noteText: "", clefType: "",imageName:"")

        lesson1.lessonQuestions?.append(l1q19)



        // create 2nd lesson and add its' questions  ************************************************************************************
        var lesson2 = Lesson(lessonId: 1, lessonName: "Advanced music theory", lessonHint: "Accidentals and chords")


        var l2q1 = LessonQuestion(questionId:101,lessonId: 1, questionType: "Text", questionText: "Nice to see that you're back and ready for more! In this lesson we are going to talk about something called accidentals as well as taking a look at how some basic chords are built up!", questionTitle: "Let's go!", noteText: "", clefType: "",imageName:"")

        lesson2.lessonQuestions!.append(l2q1)

        var l2q2 = LessonQuestion(questionId:102,lessonId: 1, questionType: "Text", questionText: "So far we've only looked at whole note steps, when we've moved the note from a line to the next space. Accidentals affect the pitch of the note as well, but it doesn't neccessarily move the tone a full step. The accidentals we are going through in this lesson moves the note a half note step", questionTitle: "Accidentals", noteText: "", clefType: "",imageName:"")

        lesson2.lessonQuestions!.append(l2q2)

        var l2q3 = LessonQuestion(questionId:103,lessonId: 1, questionType: "Image", questionText: "We start off with the accidental called sharp, it is in written form usually denoted with a #, and raises the note by half a tone step", questionTitle: "", noteText: "", clefType: "",imageName:"sharp.png")

        lesson2.lessonQuestions!.append(l2q3)

        var l2q4 = LessonQuestion(questionId:104,lessonId: 1, questionType: "Image", questionText: "Listen to the difference in pitch between the notes", questionTitle: "", noteText: "G4|A4|G4|A#4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q4)

        var l2q5 = LessonQuestion(questionId:105,lessonId: 1, questionType: "Image", questionText: "The next accidental we are going to look at is called flat, in written form denoted with a lower case b. This accidental lowers the note by half a tone step", questionTitle: "", noteText: "", clefType: "",imageName:"flat.png")

        lesson2.lessonQuestions!.append(l2q5)

        var l2q6 = LessonQuestion(questionId:106,lessonId: 1, questionType: "Image", questionText: "Listen to the difference in pitch between the notes", questionTitle: "", noteText: "G4|A4|G4|Ab4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q6)

        var l2q7 = LessonQuestion(questionId:107,lessonId: 1, questionType: "Image", questionText: "This leads to these notes actually sounding the same, whilst they actually have different names. Don't let this confuse you!", questionTitle: "", noteText: "G#4|Ab4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q7)

        var l2q8 = LessonQuestion(questionId:108,lessonId: 1, questionType: "Text", questionText: "Now that we know a little about the accidentals we can start looking at some basic chords and how they are built!", questionTitle: "Basic chords", noteText: "", clefType: "",imageName:"")

        lesson2.lessonQuestions!.append(l2q8)

        var l2q9 = LessonQuestion(questionId:109,lessonId: 1, questionType: "Image", questionText: "An important thing to know is that between these notes there is only a half step between the notes. Everywhere else there is a whole step.", questionTitle: "", noteText: "E4|F4|H4|C5", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q9)

        var l2q10 = LessonQuestion(questionId:110,lessonId: 1, questionType: "Text", questionText: "When creating a major chord there should be 4 half tone steps between the origin note and the second note and seven half steps between the origin and the third. Let's start out by creating a C-major chord", questionTitle: "Major chords", noteText: "", clefType: "",imageName:"")

        lesson2.lessonQuestions!.append(l2q10)

        var l2q11 = LessonQuestion(questionId:111,lessonId: 1, questionType: "Image", questionText: "Between the origin note and the second note there is now 4 half note steps. ", questionTitle: "", noteText: "C4|E4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q11)

        var l2q12 = LessonQuestion(questionId:112,lessonId: 1, questionType: "Image", questionText: "If we count up 7 half note steps from the origin note we now have these notes. Remember that there only is a half note step between the notes E and F", questionTitle: "", noteText: "C4|G4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q12)

        var l2q13 = LessonQuestion(questionId:113,lessonId: 1, questionType: "Image", questionText: "If we put these together we end up with a C-major", questionTitle: "", noteText: "C4|E4|G4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q13)

        var l2q14 = LessonQuestion(questionId:114,lessonId: 1, questionType: "Text", questionText: "In this case it was very easy, since there was the right amount of steps between the notes to correctly make the chord. If you start out from another note however you might not be so lucky. Let us illustrate by trying to make an E-major chord!", questionTitle: "Major chords", noteText: "", clefType: "",imageName:"")

        lesson2.lessonQuestions!.append(l2q14)

        var l2q15 = LessonQuestion(questionId:115,lessonId: 1, questionType: "Image", questionText: "If we try to go 4 half steps from E we are unable to get there without doing something..", questionTitle: "", noteText: "E4|G4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q15)

        var l2q16 = LessonQuestion(questionId:116,lessonId: 1, questionType: "Image", questionText: "Remember the sharp accidental? Let's add one of those and we are back on track!", questionTitle: "", noteText: "E4|G#4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q16)

        var l2q17 = LessonQuestion(questionId:117,lessonId: 1, questionType: "Image", questionText: "Go 7 half steps from the origin tone and you end up at this tone", questionTitle: "", noteText: "E4|H4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q17)

        var l2q18 = LessonQuestion(questionId:118,lessonId: 1, questionType: "Image", questionText: "And here is the full chord!", questionTitle: "", noteText: "E4|G#4|H4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q18)

        var l2q19 = LessonQuestion(questionId:119,lessonId: 1, questionType: "Text", questionText: "Now you know how they are built up, but how can you distinguish them? Well, major chords usually have more of a happy sound to them. Let's compare them to the next type of chords, the minor chords!", questionTitle: "Minor chords", noteText: "", clefType: "",imageName:"")

        lesson2.lessonQuestions!.append(l2q19)

        var l2q20 = LessonQuestion(questionId:120,lessonId: 1, questionType: "Text", questionText: "Minor chords are very similar to the major chords, the only difference is that it is only 3 half tone steps between the origin tone and the second tone. This will make the chord sound a bit more sad than the major chord. Let's try it out by making a C-minor!", questionTitle: "Minor chords", noteText: "", clefType: "",imageName:"")

        lesson2.lessonQuestions!.append(l2q20)

        var l2q21 = LessonQuestion(questionId:121,lessonId: 1, questionType: "Image", questionText: "Count up three half steps for the second note", questionTitle: "", noteText: "C4|Eb4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q21)

        var l2q22 = LessonQuestion(questionId:122,lessonId: 1, questionType: "Image", questionText: "Count up seven half steps for the third", questionTitle: "", noteText: "C4|G4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q22)

        var l2q23 = LessonQuestion(questionId:123,lessonId: 1, questionType: "Image", questionText: "Put them together and voila! A C-minor.", questionTitle: "", noteText: "C4|Eb4|G4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q23)

        var l2q24 = LessonQuestion(questionId:124,lessonId: 1, questionType: "Text", questionText: "Now you know how they are built up as well, so now you can play around with them.. But to make sure everything is perfectly clear we'll do one more example! Let's create Ab-minor", questionTitle: "One more!", noteText: "", clefType: "",imageName:"")

        lesson2.lessonQuestions!.append(l2q24)

        var l2q25 = LessonQuestion(questionId:125,lessonId: 1, questionType: "Image", questionText: "Count up three half steps for the second note", questionTitle: "", noteText: "Ab4|H4", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q25)

        var l2q26 = LessonQuestion(questionId:126,lessonId: 1, questionType: "Image", questionText: "Count up seven half steps for the third", questionTitle: "", noteText: "Ab4|Eb5", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q26)

        var l2q27 = LessonQuestion(questionId:127,lessonId: 1, questionType: "Image", questionText: "Put them together and we've got the entire chord!", questionTitle: "", noteText: "Ab4|H4|Eb5", clefType: "gclef",imageName:"")

        lesson2.lessonQuestions!.append(l2q27)

        var l2q28 = LessonQuestion(questionId:128,lessonId: 1, questionType: "Text", questionText: "Great! Now you know how this works as well. Why don't you go practice the advanced F and G clef lessons, as well as the basic and intermediate chords.", questionTitle: "Go practice!", noteText: "", clefType: "",imageName:"")

        lesson2.lessonQuestions!.append(l2q28)


        // create 3rd lesson and add its' questions  ************************************************************************************
        var lesson3 = Lesson(lessonId: 2, lessonName: "Measures and note lengths", lessonHint: "Notes and rests")


        var l3q1 = LessonQuestion(questionId:201,lessonId: 2, questionType: "Text", questionText: "Welcome back! This time we are going to tell you a little about the difference in note lengths, because when you play or sing all notes are obviously not going to be of the same length", questionTitle: "Lets go!", noteText: "", clefType: "",imageName:"")

        lesson3.lessonQuestions!.append(l3q1)

        var l3q2 = LessonQuestion(questionId:202,lessonId: 2, questionType: "Text", questionText: "Sheet music is divided into smaller sections called bars or measures. The only limit to how many notes can be in one bar is that the bar itself has a set length. In other words, you can put as many notes on top of each other (played simultaneously) as you want, but next to each other they cannot go over the limit of the bar", questionTitle: "Bars", noteText: "", clefType: "",imageName:"")

        lesson3.lessonQuestions!.append(l3q2)

        var l3q3 = LessonQuestion(questionId:203,lessonId: 2, questionType: "Text", questionText: "What decides how many notes can be put next to each other is partly what kind of note you choose to put there, but also on a symbol placed in the sheets", questionTitle: "Bars", noteText: "", clefType: "",imageName:"")

        lesson3.lessonQuestions!.append(l3q3)

        var l3q4 = LessonQuestion(questionId:204,lessonId: 2, questionType: "Label", questionText: "This is what one of these symbols could look like", questionTitle: "", noteText: "4|4", clefType: "gclef",imageName:"")

        lesson3.lessonQuestions!.append(l3q4)

        var l3q5 = LessonQuestion(questionId:205,lessonId: 2, questionType: "Text", questionText: "In this case we have 4/4, wich means that in each bar there should be notes to cover the length of four quarter notes", questionTitle: "Bars", noteText: "", clefType: "",imageName:"")

        lesson3.lessonQuestions!.append(l3q5)

        var l3q6 = LessonQuestion(questionId:206,lessonId: 2, questionType: "Image", questionText: "This is what a quarter note looks like", questionTitle: "", noteText: "", clefType: "",imageName:"quarter-note.png")

        lesson3.lessonQuestions!.append(l3q6)

        var l3q7 = LessonQuestion(questionId:207,lessonId: 2, questionType: "Image", questionText: "The quarter note got its name from being a quarter the length of the duration of this note, called whole note", questionTitle: "", noteText: "", clefType: "",imageName:"whole-note.png")

        lesson3.lessonQuestions!.append(l3q7)

        var l3q8 = LessonQuestion(questionId:208,lessonId: 2, questionType: "Text", questionText: "This means that if we have a 4/4 bar we can only fit in the length of one whole note! Let's go through the different note lengths!", questionTitle: "Note lengths", noteText: "", clefType: "",imageName:"")

        lesson3.lessonQuestions!.append(l3q8)

        var l3q9 = LessonQuestion(questionId:209,lessonId: 2, questionType: "Image", questionText: "We've already gone through the whole note, but if we want to get a note with half the length of the whole note it looks like...", questionTitle: "", noteText: "", clefType: "",imageName:"whole-note.png")

        lesson3.lessonQuestions!.append(l3q9)

        var l3q10 = LessonQuestion(questionId:210,lessonId: 2, questionType: "Image", questionText: "This! This note is called the half note. A note with half the length of this is of course the quarter note that we already looked at", questionTitle: "", noteText: "", clefType: "",imageName:"half-note.png")

        lesson3.lessonQuestions!.append(l3q10)

        var l3q11 = LessonQuestion(questionId:211,lessonId: 2, questionType: "Image", questionText: "But for the sake of repetition we can have a quick look at it again. Let's divide this note's length! What do we get?", questionTitle: "", noteText: "", clefType: "",imageName:"quarter-note.png")

        lesson3.lessonQuestions!.append(l3q11)

        var l3q12 = LessonQuestion(questionId:212,lessonId: 2, questionType: "Image", questionText: "We get something not surprisingly called an eighth note. Take a look at the flags, because from now on you're going to see a pattern!", questionTitle: "", noteText: "", clefType: "",imageName:"8th-note.png")

        lesson3.lessonQuestions!.append(l3q12)

        var l3q13 = LessonQuestion(questionId:213,lessonId: 2, questionType: "Image", questionText: "Half the length of the eigth note is the sixteenth note, see the difference? If we want to half the length from now on just add a flag!", questionTitle: "", noteText: "", clefType: "",imageName:"16th-note.png")

        lesson3.lessonQuestions!.append(l3q13)

        var l3q14 = LessonQuestion(questionId:214,lessonId: 2, questionType: "Image", questionText: "This is a thirty-second note", questionTitle: "", noteText: "", clefType: "",imageName:"32nd-note.png")

        lesson3.lessonQuestions!.append(l3q14)

        var l3q15 = LessonQuestion(questionId:215,lessonId: 2, questionType: "Image", questionText: "And this is a sixty-fourth note", questionTitle: "", noteText: "", clefType: "",imageName:"64th-note.png")

        lesson3.lessonQuestions!.append(l3q15)

        var l3q16 = LessonQuestion(questionId:216,lessonId: 2, questionType: "Text", questionText: "The thirty-second note and the sixty-fourth note are most probably notes you wont see or use very often, but knowing what they look like is good. Next up we are going to take a look at how silence is represented in sheet music!", questionTitle: "Rests", noteText: "", clefType: "",imageName:"")

        lesson3.lessonQuestions!.append(l3q16)

        var l3q17 = LessonQuestion(questionId:217,lessonId: 2, questionType: "Text", questionText: "Silence or rather the lack of playing is symbolized with something called rests. Rests work in exactly the same fashion as the notes do. This means that if you don't want to fill up a bar with music, you have to fill up the rest with the right amount of rests", questionTitle: "Rests", noteText: "", clefType: "",imageName:"")

        lesson3.lessonQuestions!.append(l3q17)

        var l3q18 = LessonQuestion(questionId: 218,lessonId: 2, questionType: "Image", questionText: "The equivalent of the whole note is called whole rest, and looks like this! Split this in half and you get.. ", questionTitle: "", noteText: "", clefType: "",imageName:"whole-rest.png")

        lesson3.lessonQuestions!.append(l3q18)

        var l3q19 = LessonQuestion(questionId:219,lessonId: 2, questionType: "Image", questionText: "A half rest.. This has the same length as a half note", questionTitle: "", noteText: "", clefType: "",imageName:"half-rest.png")

        lesson3.lessonQuestions!.append(l3q19)

        var l3q20 = LessonQuestion(questionId:220,lessonId: 2, questionType: "Image", questionText: "Half of the half rest makes a quarter rest, which looks like this", questionTitle: "", noteText: "", clefType: "",imageName:"quarter-rest.png")

        lesson3.lessonQuestions!.append(l3q20)

        var l3q21 = LessonQuestion(questionId:221,lessonId: 2, questionType: "Image", questionText: "Split it in half again and you get the eight rest. In the same fashion as with the notes you are going to see a pattern from now on!", questionTitle: "", noteText: "", clefType: "",imageName:"8th-rest.png")

        lesson3.lessonQuestions!.append(l3q21)

        var l3q22 = LessonQuestion(questionId:222,lessonId: 2, questionType: "Image", questionText: "A sixteenth rest.. ", questionTitle: "", noteText: "", clefType: "",imageName:"16th-rest.png")

        lesson3.lessonQuestions!.append(l3q22)

        var l3q23 = LessonQuestion(questionId:223,lessonId: 2, questionType: "Image", questionText: "A thirty-second rest", questionTitle: "", noteText: "", clefType: "",imageName:"32nd-rest.png")

        lesson3.lessonQuestions!.append(l3q23)

        var l3q24 = LessonQuestion(questionId:224,lessonId: 2, questionType: "Image", questionText: "And finally a sixty-fourth rest", questionTitle: "", noteText: "", clefType: "",imageName:"64th-rest.png")

        lesson3.lessonQuestions!.append(l3q24)

        var l3q25 = LessonQuestion(questionId:225,lessonId: 2, questionType: "Text", questionText: "If we go back to looking at the bars you remember that we only took a look at 4/4? Now that we know about the notes and rests we can talk a little about other bar lengths", questionTitle: "Bars again", noteText: "", clefType: "",imageName:"")

        lesson3.lessonQuestions!.append(l3q25)

        var l3q26 = LessonQuestion(questionId:226,lessonId: 2, questionType: "Text", questionText: "If we have a bar with 3/4 instead of 4/4 it would mean that we only allow 3 quarter notes in the same bar. This makes a difference in the way the song and music sound, waltz for example is always played in 3/4", questionTitle: "Bars again", noteText: "", clefType: "",imageName:"")

        lesson3.lessonQuestions!.append(l3q26)

        var l3q27 = LessonQuestion(questionId:227,lessonId: 2, questionType: "Text", questionText: "This concludes notes and rests for now. You should now be able to practice these out in the category called notes and rests!", questionTitle: "Go practice! :D", noteText: "", clefType: "",imageName:"")

        lesson3.lessonQuestions!.append(l3q27)

        // create 4th lesson object for going to store  ************************************************************************************
        var lesson4 = Lesson(lessonId: 3, lessonName: "Basic music symbols", lessonHint: "Different music symbols")

        var l4q1 = LessonQuestion(questionId:301,lessonId: 3, questionType: "Text", questionText: "Welcome back! In this lesson we are going to talk about what different symbols you might encounter when reading sheet music as well as what they mean. Let's start off with some very common and easy to understand dynamic indications", questionTitle: "Music symbols", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q1)

        var l4q2 = LessonQuestion(questionId:302,lessonId: 3, questionType: "Image", questionText: "Piano symbol", questionTitle: "", noteText: "", clefType: "",imageName:"piano.png")

        lesson4.lessonQuestions!.append(l4q2)

        var l4q3 = LessonQuestion(questionId:303,lessonId: 3, questionType: "Text", questionText: "The piano symbol, translates from italian to 'soft' and indicates that the notes' sound level should be very soft, this until the next dynamic indication shows up. Another common dynamic indication is..", questionTitle: "The piano symbol", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q3)

        var l4q4 = LessonQuestion(questionId:304,lessonId: 3, questionType: "Image", questionText: "The forte symbol!", questionTitle: "", noteText: "", clefType: "",imageName:"forte.png")

        lesson4.lessonQuestions!.append(l4q4)

        var l4q5 = LessonQuestion(questionId:305,lessonId: 3, questionType: "Text", questionText: "Forte translates to loud and means, in contrast to piano, that the notes following it should be very loud", questionTitle: "Forte", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q5)

        var l4q6 = LessonQuestion(questionId:306,lessonId: 3, questionType: "Text", questionText: "There are several more, we will go through all shortly. But the main idea that is good to grasp is that these are all like volume levels, ranging from very quiet to very loud. It is very important to follow these to make the music more dynamic", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q6)

        var l4q7 = LessonQuestion(questionId:307,lessonId: 3, questionType: "Text", questionText: "The only next thing you need to know is the word mezzo, which stands for moderately. This is used along with either forte or piano forming..", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q7)

        var l4q8 = LessonQuestion(questionId:308,lessonId: 3, questionType: "Image", questionText: "Mezzoforte", questionTitle: "", noteText: "", clefType: "",imageName:"mezzoforte.png")

        lesson4.lessonQuestions!.append(l4q8)

        var l4q9 = LessonQuestion(questionId:309,lessonId: 3, questionType: "Image", questionText: "Mezzopiano", questionTitle: "", noteText: "", clefType: "",imageName:"mezzopiano.png")

        lesson4.lessonQuestions!.append(l4q9)

        var l4q10 = LessonQuestion(questionId:310,lessonId: 3, questionType: "Text", questionText: "When you know all this the rest should be pretty intuitive, the more you add of a letter the more soft/loud it should be. Let's start from mezzopiano and go toward softer notes", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q10)

        var l4q11 = LessonQuestion(questionId:311,lessonId: 3, questionType: "Image", questionText: "Mezzopiano", questionTitle: "", noteText: "", clefType: "",imageName:"mezzopiano.png")

        lesson4.lessonQuestions!.append(l4q11)

        var l4q12 = LessonQuestion(questionId:312,lessonId: 3, questionType: "Image", questionText: "Piano symbol", questionTitle: "", noteText: "", clefType: "",imageName:"piano.png")

        lesson4.lessonQuestions!.append(l4q12)

        var l4q13 = LessonQuestion(questionId:313,lessonId: 3, questionType: "Image", questionText: "Pianissimo", questionTitle: "", noteText: "", clefType: "",imageName:"pianissimo.png")

        lesson4.lessonQuestions!.append(l4q13)

        var l4q14 = LessonQuestion(questionId:314,lessonId: 3, questionType: "Image", questionText: "Pianissimo possible", questionTitle: "", noteText: "", clefType: "",imageName:"pianissimopossible.png")

        lesson4.lessonQuestions!.append(l4q14)

        var l4q15 = LessonQuestion(questionId:315,lessonId: 3, questionType: "Text", questionText: "In only very rare cases you find even softer sounds. If we instead start out from mezzoforte and work our way up we have these symbols:", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q15)

        var l4q16 = LessonQuestion(questionId:316,lessonId: 3, questionType: "Image", questionText: "Mezzopiano", questionTitle: "", noteText: "", clefType: "",imageName:"mezzopiano.png")

        lesson4.lessonQuestions!.append(l4q16)

        var l4q17 = LessonQuestion(questionId:317,lessonId: 3, questionType: "Image", questionText: "The forte symbol!", questionTitle: "", noteText: "", clefType: "",imageName:"forte.png")

        lesson4.lessonQuestions!.append(l4q17)

        var l4q18 = LessonQuestion(questionId:318,lessonId: 3, questionType: "Image", questionText: "Fortissimo", questionTitle: "", noteText: "", clefType: "",imageName:"fortissimo.png")

        lesson4.lessonQuestions!.append(l4q18)

        var l4q19 = LessonQuestion(questionId:319,lessonId: 3, questionType: "Image", questionText: "Fortissimo possible", questionTitle: "", noteText: "", clefType: "",imageName:"fortissimopossible.png")

        lesson4.lessonQuestions!.append(l4q19)

        var l4q20 = LessonQuestion(questionId:320,lessonId: 3, questionType: "Text", questionText: "This is very good and all, but what do we do if we want it to gradually increase in sound level? Well, we wouldn't want to mess up the sheet with all these note for note, instead we can add something called a 'Crescendo'. Sometimes you can see this denoted as a cresc. in the sheets, but usually you see it as this symbol..", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q20)

        var l4q21 = LessonQuestion(questionId:321,lessonId: 3, questionType: "Image", questionText: "Crescendo", questionTitle: "", noteText: "", clefType: "",imageName:"crescendo.png")

        lesson4.lessonQuestions!.append(l4q21)

        var l4q22 = LessonQuestion(questionId:322,lessonId: 3, questionType: "Text", questionText: "This symbol can be stretched over all the notes you want it to gradually increase over. To make it more clear how much it should increase there usually also is one of the previous symbols before and one after, so you know in what sound level you should start and where you should be when the crescendo has ended", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q22)

        var l4q23 = LessonQuestion(questionId:323,lessonId: 3, questionType: "Text", questionText: "In the same fashion we also have something called 'Diminuendo' or 'Decrescendo' sometimes denoted as dim. the diminuendo looks like this", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q23)

        var l4q24 = LessonQuestion(questionId:324,lessonId: 3, questionType: "Image", questionText: "Diminuendo", questionTitle: "", noteText: "", clefType: "",imageName:"diminuendo.png")

        lesson4.lessonQuestions!.append(l4q24)

        var l4q25 = LessonQuestion(questionId:325,lessonId: 3, questionType: "Text", questionText: "The only difference between crescendo and diminuendo is of course just that the diminuendo makes the sound level gradually decrease instead of increase", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q25)

        var l4q26 = LessonQuestion(questionId:326,lessonId: 3, questionType: "Text", questionText: "Next up we are going to talk about another very common symbol, the repeat sign", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q26)

        var l4q27 = LessonQuestion(questionId:327,lessonId: 3, questionType: "Image", questionText: "Repeat", questionTitle: "", noteText: "", clefType: "",imageName:"repeat.png")

        lesson4.lessonQuestions!.append(l4q27)

        var l4q28 = LessonQuestion(questionId:328,lessonId: 3, questionType: "Text", questionText: "The way the repeat sign work is that everything inbetween the two signs is supposed to be repeated. Sometimes the repeated part differ slightly depending on for example what verse it is, this is usually inuitively denoted with numbers.", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q28)

        var l4q29 = LessonQuestion(questionId:329,lessonId: 3, questionType: "Text", questionText: "Another way to repeat parts in sheet music is by using the sign for 'Da capo' which means from the beginning. The sign looks like this", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q29)

        var l4q30 = LessonQuestion(questionId:330,lessonId: 3, questionType: "Image", questionText: "Da capo", questionTitle: "", noteText: "", clefType: "",imageName:"dacapo.png")

        lesson4.lessonQuestions!.append(l4q30)

        var l4q31 = LessonQuestion(questionId:331,lessonId: 3, questionType: "Text", questionText: "Sometimes this symbol is extended to 'Da capo al fine' which means from beginning to end. Bear in mind however that fine doesn't necessarily have to be the end of the sheet, it can be somewhere where it says 'fine'.", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q31)

        var l4q32 = LessonQuestion(questionId:332,lessonId: 3, questionType: "Text", questionText: "Sometimes da capo has another extension; 'Da capo al coda'. This means from beginning to coda, which is the next symbol we are going to take a closer look at!", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q32)

        var l4q33 = LessonQuestion(questionId:333,lessonId: 3, questionType: "Image", questionText: "Coda", questionTitle: "", noteText: "", clefType: "",imageName:"coda.png")

        lesson4.lessonQuestions!.append(l4q33)

        var l4q34 = LessonQuestion(questionId:334,lessonId: 3, questionType: "Text", questionText: "The coda is a ending part of the song, so when you see the coda sign after a 'da capo al coda' you are supposed to go to the coda part which is also denoted with the coda sign", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")

        lesson4.lessonQuestions!.append(l4q34)
        
        var l4q35 = LessonQuestion(questionId:335,lessonId: 3, questionType: "Text", questionText: "But what do you do if you want to repeat but not from the beginning and when using a repeat sign isn't suitable? You can use a 'Dal segno' symbol, that looks like this", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")
        
        lesson4.lessonQuestions!.append(l4q35)
        
        var l4q36 = LessonQuestion(questionId:336,lessonId: 3, questionType: "Image", questionText: "Dal segno", questionTitle: "", noteText: "", clefType: "",imageName:"dalsegno.png")
        
        lesson4.lessonQuestions!.append(l4q36)
        
        var l4q37 = LessonQuestion(questionId:337,lessonId: 3, questionType: "Text", questionText: "Dal segno means that you should repeat from the 'Segno' symbol. In the same fashion as da capo, dal segno can be extended with 'al fine' and 'al coda'. This is what the segno symbol looks like", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")
        
        lesson4.lessonQuestions!.append(l4q37)
        
        var l4q38 = LessonQuestion(questionId:338,lessonId: 3, questionType: "Image", questionText: "Segno", questionTitle: "", noteText: "", clefType: "",imageName:"segno.png")
        
        lesson4.lessonQuestions!.append(l4q38)
        
        var l4q39 = LessonQuestion(questionId:339,lessonId: 3, questionType: "Text", questionText: "This concludes the lessons about the most common symbols. Keep your eyes open for more lessons that will be availible soon! ", questionTitle: "More dynamic indications", noteText: "", clefType: "",imageName:"")
        
        lesson4.lessonQuestions!.append(l4q39)
        
        lessons!.append(lesson4)
        lessons!.append(lesson3)
        lessons!.append(lesson2)
        lessons!.append(lesson1)
        
        return lessons!
    }
    
}
