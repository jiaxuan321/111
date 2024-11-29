setwd("C:\\Users\\chuci\\OneDrive\\Desktop")
# 加载数据
gwas_data <- read.table("20002_Illness_code_SR_1262_parkinsons_disease_AnyInst__BIN.UKB_Freeze_450_EUR.WES.Burden.Results4GWAScatalog.tsv", header = TRUE, sep = "\t")

# 查看数据的列名，确保它们与下面的代码匹配
colnames(gwas_data)
str(gwas_data)
head(gwas_data)
colnames(gwas_data) <- c("Name", "chromosome", "base_pair_location", "other_allele", 
                         "effect_allele", "Trait", "Cohort", "Model", 
                         "odds_ratio", "ci_lower", "ci_upper", 
                         "p_value", "effect_allele_frequency", "standard_error")

# 去除P值为NA的行
gwas_data_clean <- gwas_data[!is.na(gwas_data$p_value), ]
# 筛选显著的SNP（P值小于5e-7）
gwas_data_significant <- gwas_data_clean[gwas_data_clean$p_value < 5e-7, ]
head(gwas_data_significant)

# 查看筛选后的数据
colnames(gwas_data)
summary(gwas_data$p_value)  # 确保没有NA值
unique(gwas_data$chromosome)
summary(gwas_data$base_pair_location)

library(qqman)
gwas_data_significant <- gwas_data[gwas_data$p_value < 0.05, ]  # 或者用其他显著性阈值
manhattan(gwas_data_significant, 
          chr = "chromosome", 
          bp = "base_pair_location", 
          p = "p_value", 
          snp = "Name", 
          main = "GWAS Manhattan Plot")

qq(gwas_data_significant$p_value)
