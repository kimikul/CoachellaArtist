class Lineup < ActiveRecord::Base
  def self.all_artists
    [
      'Adventure Club',
      'Aeroplane',
      'Alesso',
      'AlunaGeorge',
      'Anna Lunoe',
      'Art Department',
      'Bad Manners',
      'Beady Eye',
      'Beck',
      'Big Gigantic',
      'Bo Ningen',
      'Bombino',
      'Calvin Harris',
      'Chance the Rapper',
      'Classixx',
      'Daughter',
      'Disclosure',
      'Duck Sauce',
      'Factory Floor',
      'Fishbone',
      'Flight Facilities',
      'Flosstradamus',
      'Frank Turner',
      'J. Roddy Walston & the Business',
      'James Vincent McMorrow',
      'Jhene Aiko',
      'John Beaver',
      'John Newman',
      'Krewella',
      'Lana Del Rey',
      'Laurent Garnier',
      'Lee Burridge',
      'Little Dragon',
      'Maceo Plex',
      'Neutral Milk Hotel',
      'Poolside',
      'Preservation Hall Jazz Band',
      'Ratking',
      'Rudimental',
      'Scuba',
      'Showtek',
      'STRFKR',
      'Superchunk',
      'Surfer Blood',
      'The 1975',
      'The Martinez Brothers',
      'The Toy Dolls',
      'Trombone Shorty',
      'Banks',
      'Bear Hands',
      'Bicep',
      'Blood Orange',
      'Bombay Bicycle Club',
      'Cage the Elephant',
      'Cajmere',
      'Capital Cities',
      'Carbon Airways',
      'Chvrches',
      'City and Colour',
      'DARKSIDE',
      'Dillon Francis',
      'Drowners',
      'Empire of the Sun',
      'Fatboy Slim',
      'Foster The People',
      'Foxygen',
      'Future Islands',
      'Galantis',
      'Graveyard',
      'GTA',
      'Guy Gerber',
      'Headhunterz',
      'Holy Ghost!',
      'Kid Cudi',
      'Laura Mvula',
      'Lorde',
      'MAKJ',
      'MGMT',
      'Mogwai',
      'Nas',
      'Netsky',
      'Nicole Moudaber',
      'Pet Shop Boys',
      'Pharrell Williams',
      'Queens of the Stone Age',
      'RL Grime',
      'Saints of Valory',
      'Skrillex',
      'Sleigh Bells',
      'Solange',
      'Syd Arthur',
      'Temples',
      'The Dismemberment Plan',
      'The Head and the Heart',
      'The Internet',
      'The Magician',
      'The Naked and Famous',
      'Tiga',
      'TJR',
      'Ty Segall',
      'Unlocking the Truth',
      'UZ',
      'Warpaint',
      'Washed Out',
      'White Lies',
      'Young & Sick',
      'A$AP Ferg',
      'AFI',
      'Aloe Blacc',
      'Anthony Green',
      'Anti-Flag',
      'Austra',
      'Bastille',
      'Bonobo',
      'Broken Bells',
      'Bryan Ferry',
      'Caravan Palace',
      'Carnage',
      'Chromeo',
      'Crosses',
      'Damien Lazarus',
      'Davide Squillace',
      'Deorro',
      'Dixon',
      'DJ Falcon',
      'Duke Dumont',
      'Dum Dum Girls',
      'Ellie Goulding',
      'Flatbrush Zombies',
      'Flume',
      'Gabba Gabba Heys',
      'Gareth Emery',
      'Girl Talk',
      'GOAT',
      'Grouplove',
      'HAIM',
      'Hot Sauce 82',
      'Jagwar Ma',
      'Kate Nash',
      'Mako',
      'Martin Garrix',
      'Michael Brun',
      'MS MR',
      'Neko Case',
      'Nina Kraviz',
      'Shlohmo',
      'Solomun',
      'The Afghan Whigs',
      'The Bots',
      'The Cult',
      'The Glitch Mob',
      'The Jon Spencer Blues Explosion',
      'The Knife',
      'The Preatures',
      'The Replacements',
      'Title Fight',
      'Tom Odell',
      'Waxahatchee',
      'Woodkid',
      'Wye Oak',
      'Zedd',
      'ZZ Ward'
    ]
  end

  def self.select_random_artist
    artists = self.all_artists
    rand = rand(0..(artists.length-1))
    artists[rand]
  end
end
