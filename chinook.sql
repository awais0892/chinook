-- Remove database creation and use existing database
-- CREATE DATABASE IF NOT EXISTS chinook;
-- USE chinook;

-- Create Artist table
CREATE TABLE IF NOT EXISTS Artist (
    ArtistId INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(120),
    PRIMARY KEY (ArtistId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create Album table
CREATE TABLE IF NOT EXISTS Album (
    AlbumId INT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(160) NOT NULL,
    ArtistId INT NOT NULL,
    Price DECIMAL(10,2) DEFAULT 0.00,
    PRIMARY KEY (AlbumId),
    FOREIGN KEY (ArtistId) REFERENCES Artist(ArtistId)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create MediaType table
CREATE TABLE IF NOT EXISTS MediaType (
    MediaTypeId INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(120),
    PRIMARY KEY (MediaTypeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create Genre table
CREATE TABLE IF NOT EXISTS Genre (
    GenreId INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(120),
    PRIMARY KEY (GenreId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create Track table
CREATE TABLE IF NOT EXISTS Track (
    TrackId INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(200) NOT NULL,
    AlbumId INT,
    MediaTypeId INT NOT NULL,
    GenreId INT,
    Composer VARCHAR(220),
    Milliseconds INT NOT NULL,
    Bytes INT,
    UnitPrice DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (TrackId),
    FOREIGN KEY (AlbumId) REFERENCES Album(AlbumId)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample data for MediaType
INSERT INTO MediaType (Name) VALUES
('MPEG audio file'),
('Protected AAC audio file'),
('Protected MPEG-4 video file'),
('Purchased AAC audio file'),
('AAC audio file');

-- Insert sample data for Genre
INSERT INTO Genre (Name) VALUES
('Rock'),
('Jazz'),
('Metal'),
('Alternative & Punk'),
('Rock And Roll'),
('Blues'),
('Latin'),
('Reggae'),
('Pop'),
('Soundtrack'),
('Bossa Nova'),
('Easy Listening'),
('Heavy Metal'),
('R&B/Soul'),
('Electronica/Dance'),
('World'),
('Hip Hop/Rap'),
('Science Fiction'),
('TV Shows'),
('Sci Fi & Fantasy'),
('Drama'),
('Comedy'),
('Alternative'),
('Classical'),
('Opera');

-- Insert sample data for Artist
INSERT INTO Artist (Name) VALUES
('AC/DC'),
('Accept'),
('Aerosmith'),
('Alanis Morissette'),
('Alice In Chains'),
('Antônio Carlos Jobim'),
('Apocalyptica'),
('Audioslave'),
('BackBeat'),
('Billy Cobham'),
('Black Label Society'),
('Black Sabbath'),
('Body Count'),
('Bruce Dickinson'),
('Buddy Guy'),
('Caetano Veloso'),
('Chico Buarque'),
('Chico Science & Nação Zumbi'),
('Cidade Negra'),
('Cláudio Zoli'),
('Various Artists'),
('Led Zeppelin'),
('Frank Zappa & Captain Beefheart'),
('Marcos Valle'),
('Milton Nascimento & Bebeto'),
('Azymuth'),
('Gilberto Gil'),
('João Gilberto'),
('Bebel Gilberto'),
('Jorge Vercilo');

-- Insert sample data for Album
INSERT INTO Album (Title, ArtistId, Price) VALUES
('For Those About To Rock We Salute You', 1, 9.99),
('Balls to the Wall', 2, 12.99),
('Restless and Wild', 2, 14.99),
('Let There Be Rock', 1, 9.99),
('Big Ones', 3, 19.99),
('Jagged Little Pill', 4, 11.99),
('Facelift', 5, 13.99),
('Warner 25 Anos', 6, 15.99),
('Plays Metallica By Four Cellos', 7, 16.99),
('Audioslave', 8, 17.99),
('Out Of Exile', 8, 18.99),
('BackBeat Soundtrack', 9, 19.99),
('The Best Of Billy Cobham', 10, 14.99),
('Alcohol Fueled Brewtality Live! [Disc 1]', 11, 15.99),
('Alcohol Fueled Brewtality Live! [Disc 2]', 11, 15.99),
('Black Sabbath', 12, 12.99),
('Black Sabbath Vol. 4 (Remaster)', 12, 13.99),
('Body Count', 13, 14.99),
('Chemical Wedding', 14, 15.99),
('The Best Of Buddy Guy - The Millenium Collection', 15, 16.99),
('Minha Historia', 16, 17.99),
('Afrociberdelia', 17, 18.99),
('Da Lama Ao Caos', 18, 19.99),
('Acústico MTV [Live]', 19, 14.99),
('Cidade Negra - Hits', 20, 15.99),
('Na Pista', 21, 16.99),
('Axé Bahia 2001', 22, 17.99),
('BBC Sessions [Disc 1] [Live]', 23, 18.99),
('Bongo Fury', 24, 19.99),
('Carnaval 2001', 25, 14.99),
('Chill: Brazil (Disc 1)', 26, 15.99),
('Chill: Brazil (Disc 2)', 27, 16.99),
('Garage Inc. (Disc 1)', 28, 17.99),
('Greatest Hits II', 29, 18.99),
('Greatest Kiss', 30, 14.99);

-- Insert sample data for Track
INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice) VALUES
('For Those About To Rock (We Salute You)', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 343719, 11170334, 0.99),
('Balls to the Wall', 2, 1, 1, NULL, 342562, 5510424, 0.99),
('Fast As a Shark', 3, 1, 1, 'F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffman', 230619, 3990994, 0.99),
('Restless and Wild', 3, 1, 1, 'F. Baltes, R.A. Smith-Diesel, S. Kaufman, U. Dirkscneider & W. Hoffman', 252051, 4331779, 0.99),
('Princess of the Dawn', 3, 1, 1, 'Deaffy & R.A. Smith-Diesel', 375418, 6290521, 0.99),
('Put The Finger On You', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 205662, 6713451, 0.99),
('Let''s Get It Up', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 233926, 7636561, 0.99),
('Inject The Venom', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 210834, 6852860, 0.99),
('Snowballed', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 203102, 6599424, 0.99),
('Evil Walks', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 263497, 8611245, 0.99),
('C.O.D.', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 199836, 6566314, 0.99),
('Breaking The Rules', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 263288, 8596840, 0.99),
('Night Of The Long Knives', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 290468, 9553598, 0.99),
('Spellbound', 1, 1, 1, 'Angus Young, Malcolm Young, Brian Johnson', 270863, 8817038, 0.99),
('Go Down', 4, 1, 1, 'AC/DC', 331180, 10847611, 0.99),
('Dog Eat Dog', 4, 1, 1, 'AC/DC', 215196, 7032162, 0.99),
('Let There Be Rock', 4, 1, 1, 'AC/DC', 366654, 12021261, 0.99),
('Bad Boy Boogie', 4, 1, 1, 'AC/DC', 267728, 8776140, 0.99),
('Problem Child', 4, 1, 1, 'AC/DC', 325041, 10617116, 0.99),
('Overdose', 4, 1, 1, 'AC/DC', 369319, 12066294, 0.99),
('Hell Ain''t A Bad Place To Be', 4, 1, 1, 'AC/DC', 254380, 8331286, 0.99),
('Whole Lotta Rosie', 4, 1, 1, 'AC/DC', 323761, 10547154, 0.99),
('Walk On Water', 5, 1, 1, 'Steven Tyler, Joe Perry, Jack Blades, Tommy Shaw', 295680, 9719579, 0.99),
('Love In An Elevator', 5, 1, 1, 'Steven Tyler, Joe Perry', 321828, 10552051, 0.99),
('Rag Doll', 5, 1, 1, 'Steven Tyler, Joe Perry, Jim Vallance, Holly Knight', 264698, 8675345, 0.99),
('What It Takes', 5, 1, 1, 'Steven Tyler, Joe Perry, Desmond Child', 310622, 10144730, 0.99),
('Dude (Looks Like A Lady)', 5, 1, 1, 'Steven Tyler, Joe Perry, Desmond Child', 264855, 8679940, 0.99),
('Janie''s Got A Gun', 5, 1, 1, 'Steven Tyler, Tom Hamilton', 330736, 10869391, 0.99),
('Cryin''', 5, 1, 1, 'Steven Tyler, Joe Perry, Taylor Rhodes', 309263, 10056995, 0.99),
('Amazing', 5, 1, 1, 'Steven Tyler, Richie Supa', 356519, 11616195, 0.99),
('Blind Man', 5, 1, 1, 'Steven Tyler, Joe Perry, Taylor Rhodes', 240718, 7877453, 0.99),
('Deuces Are Wild', 5, 1, 1, 'Steven Tyler, Jim Vallance', 215875, 7074167, 0.99),
('The Other Side', 5, 1, 1, 'Steven Tyler, Jim Vallance', 244375, 7983270, 0.99),
('Crazy', 5, 1, 1, 'Steven Tyler, Joe Perry, Desmond Child', 316656, 10402398, 0.99),
('Eat The Rich', 5, 1, 1, 'Steven Tyler, Joe Perry, Jim Vallance', 251036, 8262039, 0.99),
('Angel', 5, 1, 1, 'Steven Tyler, Desmond Child', 307617, 9989331, 0.99),
('Livin'' On The Edge', 5, 1, 1, 'Steven Tyler, Joe Perry, Mark Hudson', 381231, 12374569, 0.99),
('All I Really Want', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 284891, 9375567, 0.99),
('You Oughta Know', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 249234, 8196916, 0.99),
('Perfect', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 188133, 6145404, 0.99),
('Hand In My Pocket', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 221570, 7224246, 0.99),
('Right Through You', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 176117, 5793082, 0.99),
('Forgiven', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 300355, 9753256, 0.99),
('You Learn', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 239699, 7824835, 0.99),
('Head Over Feet', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 267493, 8758008, 0.99),
('Mary Jane', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 280607, 9163588, 0.99),
('Ironic', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 229825, 7598866, 0.99),
('Not The Doctor', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 227631, 7604601, 0.99),
('Wake Up', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 293485, 9703359, 0.99),
('You Oughta Know (Alternate)', 6, 1, 4, 'Alanis Morissette & Glenn Ballard', 491885, 16008629, 0.99),
('We Die Young', 7, 1, 1, 'Jerry Cantrell', 152084, 4925362, 0.99),
('Man In The Box', 7, 1, 1, 'Jerry Cantrell, Layne Staley', 286641, 9310272, 0.99),
('Sea Of Sorrow', 7, 1, 1, 'Jerry Cantrell', 349831, 11316328, 0.99),
('Bleed The Freak', 7, 1, 1, 'Jerry Cantrell', 241946, 7847716, 0.99),
('I Can''t Remember', 7, 1, 1, 'Jerry Cantrell, Layne Staley', 222955, 7302550, 0.99),
('Love, Hate, Love', 7, 1, 1, 'Jerry Cantrell, Layne Staley', 387134, 12575396, 0.99),
('It Ain''t Like That', 7, 1, 1, 'Jerry Cantrell, Michael Starr, Sean Kinney', 277577, 8993793, 0.99),
('Sunshine', 7, 1, 1, 'Jerry Cantrell', 284969, 9216057, 0.99),
('Put You Down', 7, 1, 1, 'Jerry Cantrell', 196231, 6420530, 0.99),
('Confusion', 7, 1, 1, 'Jerry Cantrell, Michael Starr, Layne Staley', 344163, 11183664, 0.99),
('I Know Somethin (Bout You)', 7, 1, 1, 'Jerry Cantrell', 261955, 8497788, 0.99),
('Real Thing', 7, 1, 1, 'Jerry Cantrell, Layne Staley', 243879, 7937731, 0.99); 