-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema siaescolar
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `siaescolar` ;

-- -----------------------------------------------------
-- Schema siaescolar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `siaescolar` DEFAULT CHARACTER SET utf8 ;
USE `siaescolar` ;

-- -----------------------------------------------------
-- Table `siaescolar`.`courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`courses` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`courses` (
  `cour_id` INT NOT NULL AUTO_INCREMENT,
  `cour_name` VARCHAR(45) NULL,
  `cour_created` DATETIME NULL,
  `cour_updated` DATETIME NULL,
  PRIMARY KEY (`cour_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `siaescolar`.`indentification_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`indentification_type` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`indentification_type` (
  `idtp_id` VARCHAR(4) NOT NULL,
  `idtp_name` VARCHAR(20) NOT NULL,
  `idtp_description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtp_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `siaescolar`.`school`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`school` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`school` (
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
    REFERENCES `siaescolar`.`indentification_type` (`idtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_sch_idtp_id` ON `siaescolar`.`school` (`sch_idtp_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `siaescolar`.`students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`students` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`students` (
  `stu_id` INT NOT NULL AUTO_INCREMENT,
  `stu_cour_id` INT NOT NULL,
  `stu_sch_id` INT NOT NULL,
  `stu_idtp_id` VARCHAR(4) NOT NULL,
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
    REFERENCES `siaescolar`.`courses` (`cour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stu_sch_id`
    FOREIGN KEY (`stu_sch_id`)
    REFERENCES `siaescolar`.`school` (`sch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stu_idtp_id`
    FOREIGN KEY (`stu_idtp_id`)
    REFERENCES `siaescolar`.`indentification_type` (`idtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_stu_cour_id` ON `siaescolar`.`students` (`stu_cour_id` ASC) VISIBLE;

CREATE INDEX `idx_stu_sch_id` ON `siaescolar`.`students` (`stu_sch_id` ASC) VISIBLE;

CREATE INDEX `idx_stu_idtp_id` ON `siaescolar`.`students` (`stu_idtp_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `siaescolar`.`teachers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`teachers` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`teachers` (
  `tea_id` INT NOT NULL AUTO_INCREMENT,
  `tea_idtp_id` VARCHAR(4) NOT NULL,
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
    REFERENCES `siaescolar`.`indentification_type` (`idtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_tea_idtp_id` ON `siaescolar`.`teachers` (`tea_idtp_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `siaescolar`.`subjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`subjects` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`subjects` (
  `sub_id` INT NOT NULL AUTO_INCREMENT,
  `sub_tea_id` INT NOT NULL,
  `sub_created` VARCHAR(45) NULL,
  `sub_name` DATETIME NULL,
  `sub_updated` DATETIME NULL,
  PRIMARY KEY (`sub_id`),
  CONSTRAINT `fk_sub_tea_id`
    FOREIGN KEY (`sub_tea_id`)
    REFERENCES `siaescolar`.`teachers` (`tea_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_sub_tea_id` ON `siaescolar`.`subjects` (`sub_tea_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `siaescolar`.`teachers_courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`teachers_courses` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`teachers_courses` (
  `teacour_id` INT NOT NULL AUTO_INCREMENT,
  `teacour_tea_id` INT NOT NULL,
  `teacour_cour_id` INT NOT NULL,
  `teacour_sch_id` INT NOT NULL,
  `teacour_director` BINARY NOT NULL DEFAULT 0,
  PRIMARY KEY (`teacour_id`),
  CONSTRAINT `fk_teacour_tea_id`
    FOREIGN KEY (`teacour_tea_id`)
    REFERENCES `siaescolar`.`teachers` (`tea_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teacour_cour_id`
    FOREIGN KEY (`teacour_cour_id`)
    REFERENCES `siaescolar`.`courses` (`cour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teacour_sch_id`
    FOREIGN KEY (`teacour_sch_id`)
    REFERENCES `siaescolar`.`school` (`sch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_teacour_tea_id` ON `siaescolar`.`teachers_courses` (`teacour_cour_id` ASC) VISIBLE;

CREATE INDEX `idx_teacour_cour_id` ON `siaescolar`.`teachers_courses` (`teacour_tea_id` ASC) VISIBLE;

CREATE INDEX `idx_teacour_sch_id` ON `siaescolar`.`teachers_courses` (`teacour_sch_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `siaescolar`.`forms_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`forms_types` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`forms_types` (
  `frmtp_id` INT NOT NULL AUTO_INCREMENT,
  `frm_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`frmtp_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `siaescolar`.`forms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`forms` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`forms` (
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
    REFERENCES `siaescolar`.`forms_types` (`frmtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_frm_sch_id`
    FOREIGN KEY (`frm_sch_id`)
    REFERENCES `siaescolar`.`school` (`sch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_frm_frmtp_id` ON `siaescolar`.`forms` (`frm_frmtp_id` ASC) VISIBLE;

CREATE INDEX `idx_frm_sch_id` ON `siaescolar`.`forms` (`frm_sch_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `siaescolar`.`customer_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`customer_type` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`customer_type` (
  `custp_id` INT NOT NULL,
  `custp_name` VARCHAR(45) NOT NULL,
  `custp_description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`custp_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `siaescolar`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`customers` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`customers` (
  `cust_id` INT NOT NULL AUTO_INCREMENT,
  `cust_idtp_id` VARCHAR(4) NOT NULL,
  `cust_sch_id` INT NOT NULL,
  `cust_custp_id` INT NOT NULL,
  `cust_name` VARCHAR(45) NOT NULL,
  `cust_lastname` VARCHAR(45) NOT NULL,
  `cust_password` VARCHAR(8) NOT NULL,
  `cust_address` VARCHAR(45) NULL,
  `cust_email` VARCHAR(45) NULL,
  `cust_celphone` VARCHAR(45) NULL,
  PRIMARY KEY (`cust_id`),
  CONSTRAINT `fk_cust_idtp_id`
    FOREIGN KEY (`cust_idtp_id`)
    REFERENCES `siaescolar`.`indentification_type` (`idtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cust_sch_id`
    FOREIGN KEY (`cust_sch_id`)
    REFERENCES `siaescolar`.`school` (`sch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cust_custp_id`
    FOREIGN KEY (`cust_custp_id`)
    REFERENCES `siaescolar`.`customer_type` (`custp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_cust_idtp_id` ON `siaescolar`.`customers` (`cust_idtp_id` ASC) VISIBLE;

CREATE INDEX `idx_cust_sch_id` ON `siaescolar`.`customers` (`cust_sch_id` ASC) VISIBLE;

CREATE INDEX `idx_cust_custp_id` ON `siaescolar`.`customers` (`cust_custp_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `siaescolar`.`student_result`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `siaescolar`.`student_result` ;

CREATE TABLE IF NOT EXISTS `siaescolar`.`student_result` (
  `stdr_id` INT NOT NULL AUTO_INCREMENT,
  `stdr_stu_id` INT NOT NULL,
  `stdr_sub_id` INT NOT NULL,
  `stdr_note` INT NOT NULL,
  PRIMARY KEY (`stdr_id`),
  CONSTRAINT `fk_stdr_stu_id`
    FOREIGN KEY (`stdr_stu_id`)
    REFERENCES `siaescolar`.`students` (`stu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stdr_sub_id`
    FOREIGN KEY (`stdr_sub_id`)
    REFERENCES `siaescolar`.`subjects` (`sub_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `idx_stdr_stu_id` ON `siaescolar`.`student_result` (`stdr_stu_id` ASC) VISIBLE;

CREATE INDEX `idx_stdr_sub_id` ON `siaescolar`.`student_result` (`stdr_sub_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
