//
//  File.swift
//  Moodify
//
//  Created by Avi Khemani on 5/29/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import Foundation

struct Dictionaries {
    
    static let moodToStrategy : [Mood : String] = [
        .happy : "Congrats!!! Being happy is an awesome feeling. What's more is that being happy comes with a ton of other benefits, such as a healthier heart, stronger immune system, and much more.",
        .sad : "Sad Strategy",
        .stressed : "Aw man, sorry to hear. It's pretty common to feel stressed. Don't be too alarmed since stress often makes you more productive. Methods to reduce stress include exercising, soothing music, and much more.",
        .bored : "Bored Strategy",
        .angry : "Angry Strategy",
        .tired : "Tired Strategy",
        .excited : "Excited Strategy",
        .determined : "Determined Strategy",
        .apathetic : "Apathetic Strategy",
    ]
    
    static let urlStringDictionary : [Mood : String] = [
        .happy : "https://www.healthline.com/nutrition/happiness-and-health",
        .sad : "https://www.healthline.com/nutrition/happiness-and-health",
        .stressed : "https://www.healthline.com/nutrition/16-ways-relieve-stress-anxiety",
        .bored : "https://www.healthline.com/nutrition/happiness-and-health",
        .angry : "https://www.healthline.com/nutrition/happiness-and-health",
        .tired : "https://www.healthline.com/nutrition/happiness-and-health",
        .excited : "https://www.healthline.com/nutrition/happiness-and-health#section6",
        .determined : "https://www.healthline.com/nutrition/happiness-and-health#section6",
        .apathetic : "https://www.healthline.com/nutrition/happiness-and-health#section6",
    ]
    
    static let moodToSongs : [Mood : [String]] = [
        .happy : ["I Gotta Feeling", "Fireflies", "Dynamite", "Down", "Tik Tok", "The Man", "Old Town Road"],
        .sad : ["Bad Day", "River Flows In You", "Fight Song", "Battle Scars", "Bright Star", "Brighter Than the Sun"],
        .stressed : ["River Flows In You", "Nuvole bianche", "A Thousand Years", "Kiss the Rain"]
    ]
    
    static let songToArtist : [String : String] = [
        "I Gotta Feeling" : "Black Eyed Peas",
        "Fireflies" : "Owl City",
        "Down" : "Jay Sean (ft. Lil Wayne)",
        "Tik Tok" : "Kesha",
        "The Man" : "Aloe Blacc",
        "Dynamite" : "Taio Cruz",
        "River Flows In You" : "Yiruma",
        "Nuvole bianche" : "Ludovico Einaudi",
        "A Thousand Years" : "The Piano Guys",
        "Kiss the Rain" : "Yiruma"
        
    ]
    
    static let moodToQuotes : [Mood : [String]] = [
        .happy : [
            "“Folks are usually about as happy as they make their minds up to be.”\n- Abraham Lincoln",
            "“For every minute you are angry you lose sixty seconds of happiness.”\n- Ralph Waldo Emerson",
            "“Time you enjoy wasting is not wasted time.”\n- Marthe Troly-Curtin",
            "“Happiness is when what you think, what you say, and what you do are in harmony.”\n- Mahatma Gandhi",
            "“Happiness is not something ready made. It comes from your own actions.”\n- Dalai Lama",
            "“The most important thing is to enjoy your life—to be happy—it's all that matters.”\n- Audrey Hepburn"
        ],
    ]
    
    static let moodToImages: [Mood : [[String]]] = [
        .happy : [
            [Links.happynature1, Links.happynature2, Links.happynature3, Links.happynature4],
            [Links.happyanimal1, Links.happyanimal2, Links.happyanimal3, Links.happyanimal4],
            [Links.happypeople1, Links.happypeople2, Links.happypeople3, Links.happypeople4],
            [Links.happymeme1, Links.happymeme2, Links.happymeme3, Links.happymeme4]
        ]
    ]
    
    static let moodToVideos: [Mood : [VideoInfo]] = [
        .happy : [
            VideoInfo(name: "Super Happy Dogs | Funny Dog Video Compilation 2017", identifier: "wl4m1Rqmq-Y"),
            VideoInfo(name: "Bunny Eating Raspberries!", identifier: "A9HV5O8Un6k"),
            VideoInfo(name: "Lecture 2: MVC's", identifier: "w7a79cx3UaY"),
            VideoInfo(name: "Steve Jobs introduces iPhone in 2007", identifier: "MnrJzXM7a6o"),
            VideoInfo(name: "Substitute Teacher - Key & Peele", identifier: "Dd7FixvoKBw")
        ]
    ]

}
