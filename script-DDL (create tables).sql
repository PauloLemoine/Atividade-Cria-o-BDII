-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema loja
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema loja
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `loja` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `loja` ;

-- -----------------------------------------------------
-- Table `loja`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`categoria` (
  `ID_Categoria` INT NOT NULL AUTO_INCREMENT,
  `Nome_Categoria` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID_Categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`cliente` (
  `ID_Cliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  `Endereco` VARCHAR(255) NULL DEFAULT NULL,
  `Telefone` VARCHAR(15) NULL DEFAULT NULL,
  `Email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Cliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja`.`promocao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`promocao` (
  `ID_Promocao` INT NOT NULL AUTO_INCREMENT,
  `Nome_Promocao` VARCHAR(100) NULL DEFAULT NULL,
  `Desconto_Percentual` DECIMAL(5,2) NULL DEFAULT NULL,
  `Data_Inicio` DATE NULL DEFAULT NULL,
  `Data_Fim` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Promocao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`produto` (
  `ID_Produto` INT NOT NULL AUTO_INCREMENT,
  `Nome_Produto` VARCHAR(100) NOT NULL,
  `Descricao` VARCHAR(255) NULL DEFAULT NULL,
  `Valor` DECIMAL(10,2) NOT NULL,
  `Tamanho` VARCHAR(10) NULL,
  `Cor` VARCHAR(50) NOT NULL,
  `Marca` VARCHAR(50) NOT NULL,
  `ID_Categoria` INT NULL DEFAULT NULL,
  `promocao_ID_Promocao` INT NULL,
  PRIMARY KEY (`ID_Produto`),
  INDEX `ID_Categoria` (`ID_Categoria` ASC) VISIBLE,
  INDEX `fk_produto_promocao1_idx` (`promocao_ID_Promocao` ASC) VISIBLE,
  CONSTRAINT `produto_ibfk_1`
    FOREIGN KEY (`ID_Categoria`)
    REFERENCES `loja`.`categoria` (`ID_Categoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_produto_promocao1`
    FOREIGN KEY (`promocao_ID_Promocao`)
    REFERENCES `loja`.`promocao` (`ID_Promocao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`estoque` (
  `ID_Estoque` INT NOT NULL AUTO_INCREMENT,
  `ID_Produto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  `Data_Entrada` DATE NOT NULL,
  `Data_Saida` DATE NOT NULL,
  PRIMARY KEY (`ID_Estoque`),
  INDEX `ID_Produto` (`ID_Produto` ASC) VISIBLE,
  CONSTRAINT `estoque_ibfk_1`
    FOREIGN KEY (`ID_Produto`)
    REFERENCES `loja`.`produto` (`ID_Produto`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`fornecedor` (
  `cnpj` VARCHAR(18) NOT NULL,
  `Nome` VARCHAR(100) NOT NULL,
  `Telefone` VARCHAR(15) NULL DEFAULT NULL,
  `Email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`cnpj`),
  UNIQUE INDEX `Telefone_UNIQUE` (`Telefone` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`funcionario` (
  `ID_Funcionario` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  `Cargo` VARCHAR(50) NULL DEFAULT NULL,
  `Contato` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Funcionario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`venda` (
  `ID_Venda` INT NOT NULL AUTO_INCREMENT,
  `Data_Venda` DATE NOT NULL,
  `ID_Cliente` INT NOT NULL,
  `ID_Funcionario` INT NOT NULL,
  `Total_Venda` DECIMAL(10,2) NOT NULL,
  `Desconto` DECIMAL(10,2) NULL DEFAULT NULL,
  `Forma_Pagamento` VARCHAR(50) NULL,
  `Status_Entrega` VARCHAR(50) NULL,
  PRIMARY KEY (`ID_Venda`),
  INDEX `ID_Cliente` (`ID_Cliente` ASC) VISIBLE,
  INDEX `ID_Funcionario` (`ID_Funcionario` ASC) VISIBLE,
  CONSTRAINT `venda_ibfk_1`
    FOREIGN KEY (`ID_Cliente`)
    REFERENCES `loja`.`cliente` (`ID_Cliente`)
    ON UPDATE CASCADE,
  CONSTRAINT `venda_ibfk_2`
    FOREIGN KEY (`ID_Funcionario`)
    REFERENCES `loja`.`funcionario` (`ID_Funcionario`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja`.`item_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`item_venda` (
  `ID_Venda` INT NOT NULL,
  `ID_Produto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`ID_Venda`, `ID_Produto`),
  INDEX `ID_Produto` (`ID_Produto` ASC) VISIBLE,
  CONSTRAINT `item_venda_ibfk_1`
    FOREIGN KEY (`ID_Venda`)
    REFERENCES `loja`.`venda` (`ID_Venda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `item_venda_ibfk_2`
    FOREIGN KEY (`ID_Produto`)
    REFERENCES `loja`.`produto` (`ID_Produto`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `loja`.`compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`compras` (
  `idcompras` INT NOT NULL,
  `cupomFiscal` VARCHAR(45) NULL,
  `dataComp` DATETIME NULL,
  `dataEntrega` DATETIME NULL,
  `desconto` DECIMAL(4,2) NULL,
  `valorFrete` DECIMAL(5,2) NULL,
  PRIMARY KEY (`idcompras`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja`.`item_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`item_compra` (
  `qtd` INT(11) NOT NULL,
  `valorComp` DECIMAL(6,2) NULL,
  `compras_idcompras` INT NOT NULL,
  `produto_ID_Produto` INT NOT NULL,
  PRIMARY KEY (`compras_idcompras`, `produto_ID_Produto`),
  INDEX `fk_item_compra_produto1_idx` (`produto_ID_Produto` ASC) VISIBLE,
  CONSTRAINT `fk_item_compra_compras1`
    FOREIGN KEY (`compras_idcompras`)
    REFERENCES `loja`.`compras` (`idcompras`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_item_compra_produto1`
    FOREIGN KEY (`produto_ID_Produto`)
    REFERENCES `loja`.`produto` (`ID_Produto`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja`.`fornecedor_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`fornecedor_compra` (
  `Quantidade` INT UNSIGNED NOT NULL,
  `fornecedor_cnpj` VARCHAR(18) NOT NULL,
  `compras_idcompras` INT NOT NULL,
  PRIMARY KEY (`fornecedor_cnpj`, `compras_idcompras`),
  INDEX `fk_fornecedor_compra_fornecedor1_idx` (`fornecedor_cnpj` ASC) VISIBLE,
  INDEX `fk_fornecedor_compra_compras1_idx` (`compras_idcompras` ASC) VISIBLE,
  CONSTRAINT `fk_fornecedor_compra_fornecedor1`
    FOREIGN KEY (`fornecedor_cnpj`)
    REFERENCES `loja`.`fornecedor` (`cnpj`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_fornecedor_compra_compras1`
    FOREIGN KEY (`compras_idcompras`)
    REFERENCES `loja`.`compras` (`idcompras`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `loja`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`endereco` (
  `fornecedor_cnpj` VARCHAR(18) NOT NULL,
  `UF` CHAR(2) NOT NULL,
  `cidade` VARCHAR(60) NOT NULL,
  `bairro` VARCHAR(60) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `numero` INT(11) NOT NULL,
  `complemento` VARCHAR(60) NULL,
  `CEP` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`fornecedor_cnpj`),
  CONSTRAINT `fk_endereco_fornecedor1`
    FOREIGN KEY (`fornecedor_cnpj`)
    REFERENCES `loja`.`fornecedor` (`cnpj`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
