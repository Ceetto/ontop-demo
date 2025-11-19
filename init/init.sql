-----------------------------------------------------------------
-- TABLES
-----------------------------------------------------------------

CREATE TABLE IF NOT EXISTS platforms
(
    id
    BIGSERIAL
    PRIMARY
    KEY,
    name
    VARCHAR
(
    100
) NOT NULL UNIQUE,
    release_date DATE,
    parent_company VARCHAR
(
    100
)
    );

CREATE TABLE IF NOT EXISTS games
(
    id
    BIGSERIAL
    PRIMARY
    KEY,
    title
    VARCHAR
(
    200
) NOT NULL UNIQUE,
    release_date DATE
    );

CREATE TABLE IF NOT EXISTS game_platform
(
    id
    BIGSERIAL
    PRIMARY
    KEY,
    game_id
    BIGINT
    NOT
    NULL
    REFERENCES
    games
(
    id
) ON DELETE CASCADE,
    platform_id BIGINT NOT NULL REFERENCES platforms
(
    id
)
  ON DELETE CASCADE,
    UNIQUE
(
    game_id,
    platform_id
)
    );


CREATE TABLE IF NOT EXISTS genres
(
    id
    BIGSERIAL
    PRIMARY
    KEY,
    name
    VARCHAR
(
    50
) NOT NULL UNIQUE
    );

CREATE TABLE IF NOT EXISTS game_genre
(
    game_id
    BIGINT
    NOT
    NULL
    REFERENCES
    games
(
    id
) ON DELETE CASCADE,
    genre_id BIGINT NOT NULL REFERENCES genres
(
    id
)
  ON DELETE CASCADE,
    PRIMARY KEY
(
    game_id,
    genre_id
)
    );


-----------------------------------------------------------------
-- GENRES
-----------------------------------------------------------------
INSERT INTO genres (name)
VALUES ('Action'),
       ('Adventure'),
       ('RPG'),
       ('Open World'),
       ('Platformer'),
       ('FPS'),
       ('Puzzle'),
       ('Roguelike'),
       ('Metroidvania'),
       ('Simulation'),
       ('Strategy'),
       ('Racing'),
       ('Sports'),
       ('Horror'),
       ('Stealth'),
       ('Battle Royale'),
       ('MOBA'),
       ('Card'),
       ('Automation'),
       ('Narrative'),
       ('Soulslike'),
       ('Fighting'),
       ('Shooter'),
       ('Sandbox'),
       ('Survival') ON CONFLICT (name) DO NOTHING;

-----------------------------------------------------------------
-- PLATFORMS
-----------------------------------------------------------------

INSERT INTO platforms (name, release_date, parent_company)
VALUES ('PC (Windows)', '1985-11-20', 'Microsoft'),
       ('Steam', '2003-09-12', 'Valve'),
       ('PlayStation', '1994-12-03', 'Sony'),
       ('PlayStation 2', '2000-03-04', 'Sony'),
       ('PlayStation 3', '2006-11-11', 'Sony'),
       ('PlayStation 4', '2013-11-15', 'Sony'),
       ('PlayStation 5', '2020-11-12', 'Sony'),
       ('Xbox', '2001-11-15', 'Microsoft'),
       ('Xbox 360', '2005-11-22', 'Microsoft'),
       ('Xbox One', '2013-11-22', 'Microsoft'),
       ('Xbox Series X', '2020-11-10', 'Microsoft'),
       ('Nintendo Switch', '2017-03-03', 'Nintendo'),
       ('Nintendo Wii', '2006-11-19', 'Nintendo') ON CONFLICT DO NOTHING;

-----------------------------------------------------------------
-- GAMES (Original + New Titles)
-----------------------------------------------------------------

INSERT INTO games (title, release_date)
VALUES
    -- original
    ('The Legend of Zelda: Breath of the Wild', '2017-03-03'),
    ('Super Mario Odyssey', '2017-10-27'),
    ('Half-Life 2', '2004-11-16'),
    ('Portal 2', '2011-04-19'),
    ('Elden Ring', '2022-02-25'),
    ('Dark Souls', '2011-09-22'),
    ('Dark Souls III', '2016-03-24'),
    ('Bloodborne', '2015-03-24'),
    ('Hollow Knight', '2017-02-24'),
    ('Stardew Valley', '2016-02-26'),
    ('The Witcher 3: Wild Hunt', '2015-05-19'),
    ('Cyberpunk 2077', '2020-12-10'),
    ('Red Dead Redemption 2', '2018-10-26'),
    ('Grand Theft Auto V', '2013-09-17'),
    ('Minecraft', '2011-11-18'),
    ('Terraria', '2011-05-16'),
    ('Doom (2016)', '2016-05-13'),
    ('Doom Eternal', '2020-03-20'),
    ('Hades', '2020-09-17'),
    ('Slay the Spire', '2019-01-23'),
    ('Celeste', '2018-01-25'),
    ('God of War (2018)', '2018-04-20'),
    ('God of War Ragnarök', '2022-11-09'),
    ('Uncharted 4: A Thief''s End', '2016-05-10'),
    ('The Last of Us', '2013-06-14'),
    ('The Last of Us Part II', '2020-06-19'),
    ('Persona 5', '2016-09-15'),
    ('Persona 5 Royal', '2019-10-31'),
    ('Persona 4 Golden', '2012-06-14'),
    ('Metal Gear Solid V: The Phantom Pain', '2015-09-01'),
    ('Death Stranding', '2019-11-08'),
    ('Mass Effect 2', '2010-01-26'),
    ('Mass Effect Legendary Edition', '2021-05-14'),
    ('BioShock', '2007-08-21'),
    ('BioShock Infinite', '2013-03-26'),
    ('Fallout New Vegas', '2010-10-19'),
    ('Fallout 4', '2015-11-10'),
    ('Skyrim', '2011-11-11'),
    ('Oblivion', '2006-03-20'),
    ('Morrowind', '2002-05-01'),
    ('Halo: Combat Evolved', '2001-11-15'),
    ('Halo 3', '2007-09-25'),
    ('Halo Infinite', '2021-12-08'),
    ('Forza Horizon 4', '2018-10-02'),
    ('Forza Horizon 5', '2021-11-09'),
    ('Overwatch', '2016-05-24'),
    ('Overwatch 2', '2022-10-04'),
    ('League of Legends', '2009-10-27'),
    ('Dota 2', '2013-07-09'),
    ('Counter-Strike: Global Offensive', '2012-08-21'),
    ('Counter-Strike 2', '2023-09-27'),
    ('Apex Legends', '2019-02-04'),
    ('Fortnite', '2017-07-21'),
    ('PUBG', '2017-12-20'),
    ('Animal Crossing: New Horizons', '2020-03-20'),
    ('Pokemon Sword', '2019-11-15'),
    ('Pokemon Shield', '2019-11-15'),
    ('Super Smash Bros. Ultimate', '2018-12-07'),
    ('Fire Emblem: Three Houses', '2019-07-26'),
    ('Splatoon 3', '2022-09-09'),
    ('Monster Hunter World', '2018-01-26'),
    ('Monster Hunter Rise', '2021-03-26'),
    ('Diablo III', '2012-05-15'),
    ('Diablo IV', '2023-06-06'),
    ('Path of Exile', '2013-10-23'),
    ('Genshin Impact', '2020-09-28'),
    ('Rocket League', '2015-07-07'),
    ('FIFA 23', '2022-09-30'),
    ('Madden NFL 23', '2022-08-19'),
    ('NBA 2K23', '2022-09-09'),
    ('The Sims 4', '2014-09-02'),
    ('SimCity (2013)', '2013-03-05'),
    ('Cities Skylines', '2015-03-10'),
    ('Factorio', '2020-08-14'),
    ('Satisfactory', '2020-06-08'),
    ('RimWorld', '2018-10-17'),
    ('Baldur''s Gate 3', '2023-08-03'),
    ('Divinity Original Sin 2', '2017-09-14'),
    ('Dragon Age: Origins', '2009-11-03'),
    ('Dragon Age: Inquisition', '2014-11-18'),
    ('Tetris Effect', '2018-11-09'),
    ('Inside', '2016-06-29'),
    ('Limbo', '2010-07-21'),
    ('Cuphead', '2017-09-29'),
    ('Sekiro: Shadows Die Twice', '2019-03-22'),
    ('Ghost of Tsushima', '2020-07-17'),
    ('Returnal', '2021-04-30'),
    ('Ratchet & Clank: Rift Apart', '2021-06-11'),
    ('Gran Turismo 7', '2022-03-04'),
    ('Horizon Zero Dawn', '2017-02-28'),
    ('Horizon Forbidden West', '2022-02-18'),
    ('NieR Automata', '2017-02-23'),
    ('NieR Replicant', '2021-04-23'),

    -- NEW GAMES ADDED
    ('Alan Wake 2', '2023-10-27'),
    ('Control', '2019-08-27'),
    ('Hollow Knight Silksong', NULL),
    ('Starfield', '2023-09-06'),
    ('Bioshock 2', '2010-02-09'),
    ('Assassin''s Creed Valhalla', '2020-11-10'),
    ('Assassin''s Creed Odyssey', '2018-10-05'),
    ('Assassin''s Creed Origins', '2017-10-27'),
    ('The Stanley Parable', '2013-10-17'),
    ('Factorio Expansion', NULL),
    ('Dead Space (Remake)', '2023-01-27'),
    ('Armored Core VI', '2023-08-25'),
    ('Hogwarts Legacy', '2023-02-10'),
    ('The Talos Principle', '2014-12-11'),
    ('The Talos Principle 2', '2023-11-02'),
    ('Lies of P', '2023-09-19'),
    ('Metroid Dread', '2021-10-08'),
    ('Mario Kart 8 Deluxe', '2017-04-28'),
    ('Bayonetta 3', '2022-10-28'),
    ('The Callisto Protocol', '2022-12-02'),
    ('Star Wars Jedi: Survivor', '2023-04-28'),
    ('Star Wars Jedi: Fallen Order', '2019-11-15') ON CONFLICT DO NOTHING;

-----------------------------------------------------------------
-- GAME-PLATFORM LINKS
-----------------------------------------------------------------

WITH mapping(title, platform_name) AS (VALUES ('The Legend of Zelda: Breath of the Wild', 'Nintendo Switch'),
                                              ('Super Mario Odyssey', 'Nintendo Switch'),
                                              ('Splatoon 3', 'Nintendo Switch'),
                                              ('Fire Emblem: Three Houses', 'Nintendo Switch'),
                                              ('Super Smash Bros. Ultimate', 'Nintendo Switch'),
                                              ('Animal Crossing: New Horizons', 'Nintendo Switch'),
                                              ('Pokemon Sword', 'Nintendo Switch'),
                                              ('Pokemon Shield', 'Nintendo Switch'),
                                              ('Monster Hunter Rise', 'Nintendo Switch'),

                                              -- multi-platform examples
                                              ('Hades', 'Steam'),
                                              ('Hades', 'Nintendo Switch'),
                                              ('Hollow Knight', 'Steam'),
                                              ('Hollow Knight', 'Nintendo Switch'),
                                              ('Cuphead', 'Steam'),
                                              ('Cuphead', 'Xbox One'),
                                              ('Cuphead', 'Nintendo Switch'),

                                              -- PlayStation exclusives & multis
                                              ('Bloodborne', 'PlayStation 4'),
                                              ('Ghost of Tsushima', 'PlayStation 4'),
                                              ('Ghost of Tsushima', 'PlayStation 5'),
                                              ('The Last of Us Part II', 'PlayStation 4'),
                                              ('The Last of Us', 'PlayStation 3'),
                                              ('The Last of Us', 'PlayStation 4'),

                                              -- Xbox multis
                                              ('Halo Infinite', 'Xbox Series X'),
                                              ('Halo Infinite', 'Xbox One'),
                                              ('Forza Horizon 5', 'Xbox Series X'),
                                              ('Forza Horizon 5', 'Xbox One'),

                                              -- Big multiplatform block
                                              ('Elden Ring', 'PlayStation 5'),
                                              ('Elden Ring', 'Xbox Series X'),
                                              ('Elden Ring', 'Steam'),
                                              ('Cyberpunk 2077', 'PlayStation 5'),
                                              ('Cyberpunk 2077', 'Xbox Series X'),
                                              ('Cyberpunk 2077', 'Steam'),
                                              ('Red Dead Redemption 2', 'PlayStation 4'),
                                              ('Red Dead Redemption 2', 'Xbox One'),
                                              ('Red Dead Redemption 2', 'Steam'))

INSERT
INTO game_platform (game_id, platform_id)
SELECT g.id, p.id
FROM mapping m
         JOIN games g ON g.title = m.title
         JOIN platforms p ON p.name = m.platform_name ON CONFLICT DO NOTHING;

-- assign 1+ extra platforms for games without enough platforms
INSERT INTO game_platform (game_id, platform_id)
SELECT g.id, p.id
FROM games g
         JOIN platforms p ON (g.id + p.id) % 5 = 0   -- round-robin distribution
WHERE NOT EXISTS (
    SELECT 1 FROM game_platform gp WHERE gp.game_id = g.id HAVING COUNT (*) >= 2
    )
ON CONFLICT DO NOTHING;

-- final fallback: ensure at least 1 platform
INSERT INTO game_platform (game_id, platform_id)
SELECT g.id, p.id
FROM games g
         CROSS JOIN platforms p
WHERE p.name = 'PC (Windows)'
  AND NOT EXISTS (SELECT 1 FROM game_platform gp WHERE gp.game_id = g.id) ON CONFLICT DO NOTHING;


-----------------------------------------------------------------
-- GAME GENRES
-----------------------------------------------------------------
WITH genre_map(title, genre_name) AS (VALUES
                                          -- Examples (add as many as you want – these cover most games)
                                          ('The Legend of Zelda: Breath of the Wild', 'Action'),
                                          ('The Legend of Zelda: Breath of the Wild', 'Adventure'),
                                          ('The Legend of Zelda: Breath of the Wild', 'Open World'),

                                          ('Elden Ring', 'Action'),
                                          ('Elden Ring', 'RPG'),
                                          ('Elden Ring', 'Open World'),
                                          ('Elden Ring', 'Soulslike'),
                                          ('Bloodborne', 'Action'),
                                          ('Bloodborne', 'RPG'),
                                          ('Bloodborne', 'Soulslike'),
                                          ('Bloodborne', 'Horror'),
                                          ('Dark Souls', 'Action'),
                                          ('Dark Souls', 'RPG'),
                                          ('Dark Souls', 'Soulslike'),
                                          ('Dark Souls III', 'Action'),
                                          ('Dark Souls III', 'RPG'),
                                          ('Dark Souls III', 'Soulslike'),

                                          ('Hades', 'Roguelike'),
                                          ('Hades', 'Action'),
                                          ('Hades', 'RPG'),
                                          ('Slay the Spire', 'Card'),
                                          ('Slay the Spire', 'Roguelike'),
                                          ('Slay the Spire', 'Strategy'),

                                          ('Stardew Valley', 'Simulation'),
                                          ('Stardew Valley', 'RPG'),
                                          ('Minecraft', 'Sandbox'),
                                          ('Minecraft', 'Survival'),
                                          ('Minecraft', 'Adventure'),

                                          ('The Witcher 3: Wild Hunt', 'RPG'),
                                          ('The Witcher 3: Wild Hunt', 'Open World'),
                                          ('The Witcher 3: Wild Hunt', 'Action'),
                                          ('Cyberpunk 2077', 'RPG'),
                                          ('Cyberpunk 2077', 'Open World'),
                                          ('Cyberpunk 2077', 'Action'),

                                          ('Red Dead Redemption 2', 'Action'),
                                          ('Red Dead Redemption 2', 'Open World'),
                                          ('Red Dead Redemption 2', 'Adventure'),
                                          ('Grand Theft Auto V', 'Action'),
                                          ('Grand Theft Auto V', 'Open World'),

                                          ('God of War (2018)', 'Action'),
                                          ('God of War (2018)', 'Adventure'),
                                          ('God of War Ragnarök', 'Action'),
                                          ('God of War Ragnarök', 'Adventure'),

                                          ('Halo Infinite', 'FPS'),
                                          ('Halo Infinite', 'Action'),
                                          ('Doom Eternal', 'FPS'),
                                          ('Doom Eternal', 'Action'),

                                          ('Celeste', 'Platformer'),
                                          ('Celeste', 'Adventure'),
                                          ('Hollow Knight', 'Metroidvania'),
                                          ('Hollow Knight', 'Adventure'),
                                          ('Hollow Knight', 'Platformer'),

                                          ('Baldur''s Gate 3', 'RPG'),
                                          ('Baldur''s Gate 3', 'Strategy'),
                                          ('Baldur''s Gate 3', 'Adventure'),
                                          ('Starfield', 'RPG'),
                                          ('Starfield', 'Open World'),
                                          ('Starfield', 'Adventure'),

                                          ('Alan Wake 2', 'Action'),
                                          ('Alan Wake 2', 'Horror'),
                                          ('Alan Wake 2', 'Adventure'),
                                          ('Lies of P', 'Action'),
                                          ('Lies of P', 'Soulslike'),
                                          ('Lies of P', 'RPG')
    -- Add more rows here for other games as needed
),
     mapped AS (SELECT g.id AS game_id, gr.id AS genre_id
                FROM genre_map gm
                         JOIN games g ON g.title = gm.title
                         JOIN genres gr ON gr.name = gm.genre_name)
INSERT
INTO game_genre (game_id, genre_id)
SELECT game_id, genre_id
FROM mapped ON CONFLICT (game_id, genre_id) DO NOTHING;

-- FINAL FALLBACK: ensure EVERY game has at least 2 genres
INSERT INTO game_genre (game_id, genre_id)
SELECT g.id, gr.id
FROM games g
         CROSS JOIN (SELECT id FROM genres WHERE name IN ('Action', 'Adventure') ORDER BY name LIMIT 2) gr
WHERE (SELECT COUNT(*)
       FROM game_genre gg
       WHERE gg.game_id = g.id) < 2 ON CONFLICT DO NOTHING;
