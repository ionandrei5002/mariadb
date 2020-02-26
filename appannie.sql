SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS `games`
(
    `product_name` VARCHAR(255),
    `product_id` BIGINT,
    `market` VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `game_details`
(
    `product_name` VARCHAR(255), 
    `market` VARCHAR(50), 
    `product_code` VARCHAR(50),
    `app_id` BIGINT,
    `product_url` VARCHAR(255), 
    `current_version` VARCHAR(20), 
    `release_date` DATE, 
    `last_update` DATE, 
    `main_category_path` VARCHAR(255), 
    `description` VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `ranks`
(
    `short_date` DATE, 
    `product_id` BIGINT, 
    `country_id` INT, 
    `category_id` INT, 
    `feed_id` INT, 
    `device_id` INT, 
    `position` INT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `ratings`
(
    `short_date` DATE, 
    `product_id` BIGINT, 
    `country_id` INT, 
    `cur_count` INT, 
    `cur_average` FLOAT, 
    `cur_1` INT, 
    `cur_2` INT, 
    `cur_3` INT, 
    `cur_4` INT, 
    `cur_5` INT, 
    `all_count` INT, 
    `all_average` FLOAT, 
    `all_1` INT, 
    `all_2` INT, 
    `all_3` INT, 
    `all_4` INT, 
    `all_5` INT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `features`
(
    `short_date` DATE, 
    `product_id` BIGINT, 
    `country_id` INT, 
    `category_id` INT, 
    `device_id` INT, 
    `level` INT, 
    `position` INT, 
    `row` INT,
    `featured_visibility` INT,
    `title_id` INT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `features_ios`
(
    `short_date` DATE, 
    `featured_tab` VARCHAR(50), 
    `story_label` VARCHAR(50), 
    `collection_label` VARCHAR(50), 
    `creative_url` VARCHAR(255), 
    `type` VARCHAR(20), 
    `aa_code` VARCHAR(255), 
    `product_id` BIGINT,
    `title` VARCHAR(255),
    `country_id` INT,
    `notes` VARCHAR(255),
    `story_position` INT,
    `feature` VARCHAR(255),
    `item_position` INT
) ENGINE=InnoDB;

COMMIT;