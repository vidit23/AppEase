//
//  Animals.swift
//  GuessGame WatchKit Extension
//
//  Created by Nandhitha Raghuram on 11/19/20.
//

import Foundation


class FindAMatch: ObservableObject  {
    
    var emojiNameDict: Dictionary<String, String>
    private var emojiNameList: [String]
    @Published var correctAnswer = 0
    @Published var gameOptions = ArraySlice<String>([])
    
    init() {
        emojiNameDict = ["See-No-Evil Monkey": "🙈","Hear-No-Evil Monkey": "🙉","Speak-No-Evil Monkey": "🙊",
                       "Collision": "💥","Dizzy": "💫","Sweat Droplets": "💦", "Dashing Away": "💨","Monkey Face": "🐵",
                       "Monkey": "🐒","Gorilla": "🦍","Dog Face": "🐶","Dog": "🐕", "Poodle": "🐩","Wolf": "🐺","Fox": "🦊",
                       "Raccoon": "🦝","Cat Face": "🐱","Cat": "🐈","Lion": "🦁","Tiger Face": "🐯","Tiger": "🐅",
                       "Leopard": "🐆","Horse Face": "🐴","Horse": "🐎","Unicorn": "🦄","Zebra": "🦓","Deer": "🦌",
                       "Cow Face": "🐮","Ox": "🐂","Water Buffalo": "🐃", "Cow": "🐄","Pig Face": "🐷","Pig": "🐖", "Boar": "🐗",
                       "Pig Nose": "🐽","Ram": "🐏","Ewe": "🐑","Goat": "🐐","Camel": "🐪","Two-Hump Camel": "🐫","Llama": "🦙",
                       "Giraffe": "🦒","Elephant": "🐘","Rhinoceros": "🦏","Hippopotamus": "🦛","Mouse Face": "🐭","Mouse":"🐁","Rat": "🐀",
                       "Hamster": "🐹","Rabbit Face": "🐰","Rabbit": "🐇","Chipmunk": "🐿","Hedgehog": "🦔","Bat": "🦇",
                       "Bear": "🐻","Koala": "🐨","Panda": "🐼","Kangaroo": "🦘", "Badger": "🦡","Paw Prints": "🐾","Turkey": "🦃",
                       "Chicken": "🐔","Rooster": "🐓", "Hatching Chick": "🐣","Baby Chick": "🐤", "Front-Facing Baby Chick": "🐥",
                       "Bird": "🐦", "Penguin": "🐧","Dove": "🕊", "Eagle": "🦅","Duck": "🦆","Swan": "🦢","Owl": "🦉", "Peacock": "🦚",
                       "Parrot": "🦜","Frog": "🐸","Crocodile": "🐊","Turtle": "🐢","Lizard": "🦎","Snake": "🐍", "Dragon Face": "🐲", "Dragon": "🐉","Sauropod": "🦕","T-Rex": "🦖","Spouting Whale": "🐳","Whale": "🐋","Dolphin": "🐬",
                       "Fish": "🐟", "Tropical Fish": "🐠","Blowfish": "🐡","Shark": "🦈",
                       "Octopus": "🐙","Spiral Shell": "🐚","Snail": "🐌","Butterfly": "🦋","Bug": "🐛","Ant": "🐜","Honeybee": "🐝",
                       "Lady Beetle": "🐞","Cricket": "🦗","Spider": "🕷","Spider Web": "🕸","Scorpion": "🦂","Mosquito": "🦟",
                       "Bouquet": "💐","Cherry Blossom": "🌸","White Flower": "💮","Rosette": "🏵", "Rose": "🌹","Wilted Flower": "🥀",
                       "Hibiscus": "🌺","Sunflower": "🌻","Blossom": "🌼","Tulip": "🌷","Seedling": "🌱", "Evergreen Tree": "🌲",
                       "Deciduous Tree": "🌳", "Palm Tree": "🌴","Cactus": "🌵", "Sheaf of Rice": "🌾", "Herb": "🌿", "Shamrock": "☘",
                       "Four Leaf Clover": "🍀", "Maple Leaf": "🍁", "Fallen Leaf": "🍂", "Leaf Fluttering in Wind": "🍃", "Mushroom": "🍄", "Chestnut": "🌰", "Crab": "🦀", "Lobster": "🦞","Shrimp": "🦐", "Squid": "🦑", "Globe Showing Europe-Africa": "🌍", "Globe Showing Americas": "🌎",
                       "Globe Showing Asia-Australia": "🌏", "Globe with Meridians": "🌐", "New Moon": "🌑", "Waxing Crescent Moon": "🌒",
                       "First Quarter Moon": "🌓", "Waxing Gibbous Moon": "🌔", "Full Moon": "🌕", "Waning Gibbous Moon": "🌖",
                       "Last Quarter Moon": "🌗", "Waning Crescent Moon": "🌘", "Crescent Moon": "🌙", "New Moon Face": "🌚", "First Quarter Moon Face": "🌛", "Last Quarter Moon Face": "🌜", "Sun": "☀", "Full Moon Face": "🌝", "Sun with Face": "🌞", "Star": "⭐", "Glowing Star": "🌟", "Shooting Star": "🌠", "Cloud": "☁", "Sun Behind Cloud": "⛅", "Cloud with Lightning and Rain": "⛈", "Sun Behind Small Cloud": "🌤", "Sun Behind Large Cloud": "🌥", "Sun Behind Rain Cloud": "🌦", "Cloud with Rain": "🌧", "Cloud with Snow": "🌨", "Cloud with Lightning": "🌩", "Tornado": "🌪", "Fog": "🌫", "Wind Face": "🌬", "Rainbow": "🌈", "Umbrella": "☂", "Umbrella with Rain Drops": "☔", "High Voltage": "⚡", "Snowflake": "❄", "Snowman": "☃", "Snowman Without Snow": "⛄", "Comet": "☄", "Fire": "🔥", "Droplet": "💧", "Water Wave": "🌊", "Christmas Tree": "🎄", "Sparkles": "✨", "Tanabata Tree": "🎋", "Pine Decoration": "🎍"]
        emojiNameList = Array(emojiNameDict.keys)
        self.generateNewQuestion()
    }
    
    func generateNewQuestion() {
        gameOptions = emojiNameList.shuffled().prefix(3)
        correctAnswer = Int.random(in: 0...2)
    }
    
}
