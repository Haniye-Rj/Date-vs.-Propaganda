# 1. SETUP & LIBRARIES
if(!require(arules)) install.packages("arules")
if(!require(arulesViz)) install.packages("arulesViz")
if(!require(visNetwork)) install.packages("visNetwork")
if(!require(ggplot2)) install.packages("ggplot2")

library(arules)
library(arulesViz)
library(visNetwork)
library(ggplot2)

# 2. LOAD DATA
data <- read.csv("/Users/Haniye/Downloads/bq-results-20260118-152958-1768750219518.csv")

# 3. DATA CLEANING & NEW COLUMNS (GoldsteinScale & NumArticles)
# We add prefixes like "GS_" and "Media_" to avoid the "duplicated factor level" error
data$Stability <- cut(data$GoldsteinScale, 
                      breaks = c(-10, -5, 0, 5, 10), 
                      labels = c("GS_VeryLow", "GS_Low", "GS_High", "GS_VeryHigh"))

data$Media_Volume <- cut(data$NumArticles, 
                         breaks = c(0, 5, 20, Inf), 
                         labels = c("Media_Low", "Media_Med", "Media_High"))

# Create a clean subset for mining
clean_data <- data[, c("Location", "Actor1Name", "EventCode", "Stability", "Media_Volume")]
clean_data <- na.omit(clean_data)

# Convert all columns to factors
clean_data[] <- lapply(clean_data, as.factor)

# Transform into transactions
trans <- as(clean_data, "transactions")

# 4. RULE MINING
# Adjusting support to 0.005 and confidence to 0.5 for meaningful rules
rules <- apriori(trans, 
                 parameter = list(supp = 0.005, conf = 0.5, minlen = 2))

# Sort rules by lift
rules_lift <- sort(rules, by = "lift", decreasing = TRUE)

# 5. VISUALIZATIONS (Node Visuals & More)

# Visual 1: Interactive Node Graph (Check the 'Viewer' Tab)
# This is your main interactive "Node Visual"
plot(head(rules_lift, 30), method = "graph", engine = "htmlwidget")

# Visual 2: Static Node Graph (Check the 'Plots' Tab)
plot(head(rules_lift, 20), method = "graph", engine = "ggplot2")


# Visual 3: Item Frequency Plot
itemFrequencyPlot(trans, topN = 15, col = "skyblue", main = "Top Item Frequency")

# 6. TARGETED ANALYSIS: VIOLENCE & PROTESTS
# Specifically looking for rules leading to EventCode 141 (Protests)
protest_rules <- subset(rules, rhs %pin% "EventCode=141")
inspect(head(sort(protest_rules, by = "lift"), 5))

# Specifically looking for rules leading to Very Low Stability (Violence indicator)
violence_rules <- subset(rules, rhs %pin% "Stability=GS_VeryLow")
inspect(head(sort(violence_rules, by = "lift"), 5))