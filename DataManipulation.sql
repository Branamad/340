-- : variable used to denote variables that are derived from client side user input

-- Home Page

    -- Search for a user in the database

SELECT p.user_Name, p.characters, p.accountcreationDate, p.accountlevel
    FROM Player p 
    WHERE
        p.user_Name = :user_Name_from_search_query;

    -- Search for a guild in the database

SELECT g.name, g.raid_groups, g.numberofcharacters
    FROM Guild g 
    WHERE
        g.name = :guild_name_from_search_query;


-- Create a Character Page

    -- Add a character

INSERT INTO Character (name, class, race)
    SELECT name, class, race 
        FROM (:name_from_textbox, :class_from_dropdown, :race_from_dropdown)
        INNER JOIN Player ON Character.player_id = Player.player_id
        WHERE Player.user_Name = :user_Name_from_textbox AND Player.user_password = :user_password_from_textbox;

    -- Delete a character

DELETE FROM Character
    INNER JOIN Player ON Character.player_id = Player.player_id
    WHERE Character.name = :name_from_textbox AND Player.user_Name = :user_Name_from_textbox AND Player_user_password = :pasword_from_textbox;


-- Join a Guide Page

    -- Join a guild

UPDATE Character
    SET Character.guildmembership = :guild_name_from_textbox
    WHERE Character.name = :character_name_from_textbox;

    -- Create a guild

INSERT INTO Guild (name)
    VALUES (:guild_name_from_textbox);
UPDATE Character
    SET Character.guildmembership = :guild_name_from_textbox
    WHERE Character.name = :character_name_from_textbox;

    -- Leave a guild
UPDATE Character
    SET Character.guildmembership = NULL
    WHERE Character.name = :character_name_from_textbox;

-- Start a raid page

    -- Start a raid

INSERT INTO Raid_Group (raid_group_leader)
    VALUES (:character_name_from_textbox);
INSERT INTO Guild_Raid_Group (guild_id)
    VALUES (:guild_name_from_textbox);
UPDATE Character
    SET Character.raid_group = Raid_ID
    WHERE Character.name = :character_name_from_textbox;

    -- View raid groups
SELECT rd.name 
    FROM Raid_Group rd
    WHERE rd.guild_id = :guild_name_from_textbox;

    -- End a raid

UPDATE Character
    SET Character.raid_group = NULL
    WHERE Character.raid_group = :raid_id_from_textbox;

-- Raid management page

    -- Design a raid

INSERT INTO Raid (raid_name, boss, experience)
    VALUES (:raid_name_from_textbox, :boss_name_from_textbox, :experience_from_textbox);

    -- Look up a raid

SELECT rd.raid_name, rd.boss, rd.experience
    FROM Raid rd 
    WHERE rd.raid_name = :raid_name_from_textbox;

-- Sign up page

    -- Create a new player account

INSERT INTO Player (user_Name, user_password)
    VALUES (:user_Name_from_textbox, :password_from_textbox);

    -- Update password

UPDATE Player
    SET Player.user_password = :new_password_from_textbox
    WHERE Player.user_Name = :user_Name_from_textbox AND Player.user_password = old_password_from_textbox;