-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema schoolsia
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `schoolsia` ;

-- -----------------------------------------------------
-- Schema schoolsia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `schoolsia` DEFAULT CHARACTER SET utf8 ;
USE `schoolsia` ;

-- -----------------------------------------------------
-- Table `schoolsia`.`courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`courses` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`courses` (
  `cour_id` INT NOT NULL AUTO_INCREMENT,
  `cour_name` VARCHAR(45) NULL,
  `cour_created` DATETIME NULL,
  `cour_updated` DATETIME NULL,
  PRIMARY KEY (`cour_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `schoolsia`.`indentification_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`indentification_type` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`indentification_type` (
  `idtp_id` VARCHAR(4) NOT NULL,
  `idtp_name` VARCHAR(45) NOT NULL,
  `idtp_description` VARCHAR(120) NULL,
  PRIMARY KEY (`idtp_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `schoolsia`.`school`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`school` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`school` (
  `sch_id` INT NOT NULL AUTO_INCREMENT,
  `sch_idtp_id` VARCHAR(4) NOT NULL,
  `sch_name` VARCHAR(45) NOT NULL,
  `sch_location` VARCHAR(45) NOT NULL,
  `sch_address` VARCHAR(45) NOT NULL,
  `sch_created` DATETIME NOT NULL,
  `sch_update` DATETIME NOT NULL,
  `sch_direc_id` INT NOT NULL,
  PRIMARY KEY (`sch_id`),
  CONSTRAINT `fk_sch_idtp_id`
    FOREIGN KEY (`sch_idtp_id`)
    REFERENCES `schoolsia`.`indentification_type` (`idtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_sch_idtp_id` ON `schoolsia`.`school` (`sch_idtp_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `schoolsia`.`gender`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`gender` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`gender` (
  `ge_id` VARCHAR(2) NOT NULL,
  `ge_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ge_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `schoolsia`.`students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`students` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`students` (
  `stu_id` INT NOT NULL AUTO_INCREMENT,
  `stu_cour_id` INT NOT NULL,
  `stu_sch_id` INT NOT NULL,
  `stu_idtp_id` VARCHAR(4) NOT NULL,
  `stu_ge_id` VARCHAR(2) NOT NULL,
  `stu_name` VARCHAR(45) NOT NULL,
  `stu_lastname` VARCHAR(45) NOT NULL,
  `stu_stratum` MEDIUMINT(3) NOT NULL,
  `stu_eps` VARCHAR(45) NOT NULL,
  `stu_email` VARCHAR(45) NOT NULL,
  `stu_genere` VARCHAR(45) NOT NULL,
  `stu_address` VARCHAR(45) NOT NULL,
  `stu_phone` VARCHAR(45) NOT NULL,
  `stu_created` DATETIME NOT NULL,
  `stu_update` DATETIME NOT NULL,
  PRIMARY KEY (`stu_id`),
  CONSTRAINT `fk_stu_cour_id`
    FOREIGN KEY (`stu_cour_id`)
    REFERENCES `schoolsia`.`courses` (`cour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stu_sch_id`
    FOREIGN KEY (`stu_sch_id`)
    REFERENCES `schoolsia`.`school` (`sch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stu_idtp_id`
    FOREIGN KEY (`stu_idtp_id`)
    REFERENCES `schoolsia`.`indentification_type` (`idtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stu_ge_id`
    FOREIGN KEY (`stu_ge_id`)
    REFERENCES `schoolsia`.`gender` (`ge_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_stu_cour_id` ON `schoolsia`.`students` (`stu_cour_id` ASC) VISIBLE;

CREATE INDEX `idx_stu_sch_id` ON `schoolsia`.`students` (`stu_sch_id` ASC) VISIBLE;

CREATE INDEX `idx_stu_idtp_id` ON `schoolsia`.`students` (`stu_idtp_id` ASC) VISIBLE;

CREATE INDEX `idx_stu_ge_id` ON `schoolsia`.`students` (`stu_ge_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `schoolsia`.`teachers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`teachers` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`teachers` (
  `tea_id` INT NOT NULL AUTO_INCREMENT,
  `tea_idtp_id` VARCHAR(4) NOT NULL,
  `tea_ge_id` VARCHAR(2) NOT NULL,
  `tea_name` VARCHAR(45) NULL,
  `tea_lastname` VARCHAR(45) NULL,
  `tea_job_title` VARCHAR(45) NULL,
  `tea_phone` VARCHAR(45) NULL,
  `tea_address` VARCHAR(45) NULL,
  `tea_course` VARCHAR(45) NULL,
  `tea_eps` VARCHAR(45) NULL,
  `tea_created` DATETIME NULL,
  `tea_update` DATETIME NULL,
  PRIMARY KEY (`tea_id`),
  CONSTRAINT `fk_tea_idtp_id`
    FOREIGN KEY (`tea_idtp_id`)
    REFERENCES `schoolsia`.`indentification_type` (`idtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tea_ge_id`
    FOREIGN KEY (`tea_ge_id`)
    REFERENCES `schoolsia`.`gender` (`ge_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_tea_idtp_id` ON `schoolsia`.`teachers` (`tea_idtp_id` ASC) VISIBLE;

CREATE INDEX `idx_tea_ge_id` ON `schoolsia`.`teachers` (`tea_ge_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `schoolsia`.`subjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`subjects` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`subjects` (
  `sub_id` INT NOT NULL AUTO_INCREMENT,
  `sub_created` VARCHAR(45) NULL,
  `sub_name` DATETIME NULL,
  `sub_updated` DATETIME NULL,
  PRIMARY KEY (`sub_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `schoolsia`.`schedules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`schedules` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`schedules` (
  `sche_id` INT NOT NULL AUTO_INCREMENT,
  `sche_sch_id` INT NOT NULL,
  `sche_school_time` DATETIME NOT NULL,
  PRIMARY KEY (`sche_id`),
  CONSTRAINT `fk_sche_sch_id`
    FOREIGN KEY (`sche_sch_id`)
    REFERENCES `schoolsia`.`school` (`sch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_sche_sch_id` ON `schoolsia`.`schedules` (`sche_sch_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `schoolsia`.`subject_time`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`subject_time` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`subject_time` (
  `subtm_id` INT NOT NULL AUTO_INCREMENT,
  `subtm_tea_id` INT NOT NULL,
  `subtm_cour_id` INT NOT NULL,
  `subtm_sch_id` INT NOT NULL,
  `subtm_sub_id` INT NOT NULL,
  `subtm_sche_id` INT NOT NULL,
  `subtm_director` BINARY NOT NULL DEFAULT 0,
  PRIMARY KEY (`subtm_id`),
  CONSTRAINT `fk_subtm_tea_id`
    FOREIGN KEY (`subtm_tea_id`)
    REFERENCES `schoolsia`.`teachers` (`tea_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subtm_cour_id`
    FOREIGN KEY (`subtm_cour_id`)
    REFERENCES `schoolsia`.`courses` (`cour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subtm_sch_id`
    FOREIGN KEY (`subtm_sch_id`)
    REFERENCES `schoolsia`.`school` (`sch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subtm_sub_id`
    FOREIGN KEY (`subtm_sub_id`)
    REFERENCES `schoolsia`.`subjects` (`sub_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subtm_sche_id`
    FOREIGN KEY (`subtm_sche_id`)
    REFERENCES `schoolsia`.`schedules` (`sche_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_subtm_tea_id` ON `schoolsia`.`subject_time` (`subtm_cour_id` ASC) VISIBLE;

CREATE INDEX `idx_subtm_cour_id` ON `schoolsia`.`subject_time` (`subtm_tea_id` ASC) VISIBLE;

CREATE INDEX `idx_subtm_sch_id` ON `schoolsia`.`subject_time` (`subtm_sch_id` ASC) VISIBLE;

CREATE INDEX `idx_subtm_sub_id` ON `schoolsia`.`subject_time` (`subtm_sub_id` ASC) VISIBLE;

CREATE INDEX `idx_subtm_sche_id` ON `schoolsia`.`subject_time` (`subtm_sche_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `schoolsia`.`forms_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`forms_types` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`forms_types` (
  `frmtp_id` INT NOT NULL AUTO_INCREMENT,
  `frm_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`frmtp_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `schoolsia`.`forms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`forms` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`forms` (
  `frm_id` INT NOT NULL AUTO_INCREMENT,
  `frm_frmtp_id` INT NOT NULL,
  `frm_sch_id` INT NOT NULL,
  `frm_version` INT NOT NULL,
  `frm_name` VARCHAR(45) NOT NULL,
  `frm_description` VARCHAR(250) NOT NULL,
  `frm_path` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`frm_id`),
  CONSTRAINT `fk_frm_frmtp_id`
    FOREIGN KEY (`frm_frmtp_id`)
    REFERENCES `schoolsia`.`forms_types` (`frmtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_frm_sch_id`
    FOREIGN KEY (`frm_sch_id`)
    REFERENCES `schoolsia`.`school` (`sch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_frm_frmtp_id` ON `schoolsia`.`forms` (`frm_frmtp_id` ASC) VISIBLE;

CREATE INDEX `idx_frm_sch_id` ON `schoolsia`.`forms` (`frm_sch_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `schoolsia`.`customer_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`customer_type` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`customer_type` (
  `custp_id` VARCHAR(4) NOT NULL,
  `custp_name` VARCHAR(45) NOT NULL,
  `custp_description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`custp_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `schoolsia`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`customers` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`customers` (
  `cust_id` INT NOT NULL AUTO_INCREMENT,
  `cust_idtp_id` VARCHAR(4) NOT NULL,
  `cust_sch_id` INT NOT NULL,
  `cust_custp_id` VARCHAR(4) NOT NULL,
  `cust_ge_id` VARCHAR(2) NOT NULL,
  `cust_name` VARCHAR(45) NOT NULL,
  `cust_lastname` VARCHAR(45) NOT NULL,
  `cust_password` VARCHAR(8) NOT NULL,
  `cust_address` VARCHAR(45) NULL,
  `cust_email` VARCHAR(45) NULL,
  `cust_celphone` VARCHAR(45) NULL,
  PRIMARY KEY (`cust_id`),
  CONSTRAINT `fk_cust_idtp_id`
    FOREIGN KEY (`cust_idtp_id`)
    REFERENCES `schoolsia`.`indentification_type` (`idtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cust_sch_id`
    FOREIGN KEY (`cust_sch_id`)
    REFERENCES `schoolsia`.`school` (`sch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cust_custp_id`
    FOREIGN KEY (`cust_custp_id`)
    REFERENCES `schoolsia`.`customer_type` (`custp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cust_ge_id`
    FOREIGN KEY (`cust_ge_id`)
    REFERENCES `schoolsia`.`gender` (`ge_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_cust_idtp_id` ON `schoolsia`.`customers` (`cust_idtp_id` ASC) VISIBLE;

CREATE INDEX `idx_cust_sch_id` ON `schoolsia`.`customers` (`cust_sch_id` ASC) VISIBLE;

CREATE INDEX `idx_cust_custp_id` ON `schoolsia`.`customers` (`cust_custp_id` ASC) VISIBLE;

CREATE INDEX `idx_cust_ge_id` ON `schoolsia`.`customers` (`cust_ge_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `schoolsia`.`student_result`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schoolsia`.`student_result` ;

CREATE TABLE IF NOT EXISTS `schoolsia`.`student_result` (
  `stdr_id` INT NOT NULL AUTO_INCREMENT,
  `stdr_stu_id` INT NOT NULL,
  `stdr_sub_id` INT NOT NULL,
  `stdr_note` INT NOT NULL,
  PRIMARY KEY (`stdr_id`),
  CONSTRAINT `fk_stdr_stu_id`
    FOREIGN KEY (`stdr_stu_id`)
    REFERENCES `schoolsia`.`students` (`stu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stdr_sub_id`
    FOREIGN KEY (`stdr_sub_id`)
    REFERENCES `schoolsia`.`subjects` (`sub_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_stdr_stu_id` ON `schoolsia`.`student_result` (`stdr_stu_id` ASC) VISIBLE;

CREATE INDEX `idx_stdr_sub_id` ON `schoolsia`.`student_result` (`stdr_sub_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `schoolsia`.`indentification_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `schoolsia`;
INSERT INTO `schoolsia`.`indentification_type` (`idtp_id`, `idtp_name`, `idtp_description`) VALUES ('CC', 'Cedula de Identidad', NULL);
INSERT INTO `schoolsia`.`indentification_type` (`idtp_id`, `idtp_name`, `idtp_description`) VALUES ('CE', 'Cedula de Extranjería', NULL);
INSERT INTO `schoolsia`.`indentification_type` (`idtp_id`, `idtp_name`, `idtp_description`) VALUES ('RC', 'Registro Civil', NULL);
INSERT INTO `schoolsia`.`indentification_type` (`idtp_id`, `idtp_name`, `idtp_description`) VALUES ('NIT', 'Número de Identificación Tributaria', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `schoolsia`.`gender`
-- -----------------------------------------------------
START TRANSACTION;
USE `schoolsia`;
INSERT INTO `schoolsia`.`gender` (`ge_id`, `ge_name`) VALUES ('H', 'Hombre');
INSERT INTO `schoolsia`.`gender` (`ge_id`, `ge_name`) VALUES ('I', 'Intersexual');
INSERT INTO `schoolsia`.`gender` (`ge_id`, `ge_name`) VALUES ('M', 'Mujer');

COMMIT;


-- -----------------------------------------------------
-- Data for table `schoolsia`.`customer_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `schoolsia`;
INSERT INTO `schoolsia`.`customer_type` (`custp_id`, `custp_name`, `custp_description`) VALUES ('adm', 'admin', 'admin school sia');
INSERT INTO `schoolsia`.`customer_type` (`custp_id`, `custp_name`, `custp_description`) VALUES ('tea', 'teacher', 'teacher');
INSERT INTO `schoolsia`.`customer_type` (`custp_id`, `custp_name`, `custp_description`) VALUES ('stu', 'student', 'student');
INSERT INTO `schoolsia`.`customer_type` (`custp_id`, `custp_name`, `custp_description`) VALUES ('coor', 'coordinator', 'academic coordinator');

COMMIT;

