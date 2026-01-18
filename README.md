# Data vs. Propaganda: Mapping the 2026 Iranian Domestic Unrest

## Project Overview

This project applies **Association Rule Mining (ARM)** to large-scale event data to objectively analyze the drivers of social unrest in Iran during 2026. By utilizing the Apriori algorithm, this study identifies mathematically significant patterns between actors, locations, and conflict intensity.

The core mission of this project is **intellectual honesty**. It seeks to answer state-sponsored narratives—which often attribute domestic protests to foreign funding (e.g., USA)—by examining whether the data supports those claims or indicates a more domestic, grievance-based origin.

---

## Dataset & Data Collection

The data utilized in this study is sourced from the **GDELT Project** (Global Database of Events, Language, and Tone).

* **Data Source:** GDELT 2.0 Global Knowledge Graph.
* **Collection Method:** Data was queried via Google BigQuery, specifically targeting events located in Iran with a timestamp in early 2026.
* **Volume:** The dataset contains approximately **16,811** unique event records.
* **Key Features:**
* `Actor1Name`: The primary entity involved (e.g., GOVERNMENT, DEMONSTRATOR).
* `EventCode`: Categorized action based on the CAMEO scale (e.g., 141 for Protests).
* `GoldsteinScale`: A numeric value (-10 to +10) measuring the theoretical impact an event has on state stability.
* `NumArticles`: The volume of global media coverage, used as a proxy for event significance.



---

## Project Goals

1. **Identify Conflict Triggers:** Determine which combinations of actors and locations most frequently result in "Low Stability" events.
2. **Verify Narratives:** Test the Islamic Republic’s propaganda. If protests are "foreign-funded," the data should show a high correlation between foreign actors (LHS) and protests (RHS).
3. **Provide Visual Transparency:** Create a **Node Visual** (Network Graph) that allows researchers and the public to see the "web of accountability" in the conflict.
4. **Stability Analysis:** Map how specific government actions directly correlate with drops in the GoldsteinScale (Stability).

---

## Methodology

### Data Transformation

To make the data suitable for the Apriori algorithm, continuous variables were "binned" into categorical factors:

* **Stability:** Binned from the GoldsteinScale into levels: `GS_veryLow`, `GS_Low`, `GS_High`, and `GS_veryHigh`.
* **Media Volume:** Binned from NumArticles into `Media_Low`, `Media_Med`, and `Media_High`.

### Algorithm

I utilized the `arules` package in R to mine association rules with a **Minimum Support of 0.005** and **Minimum Confidence of 0.5**. Rules were then sorted by **Lift** to identify the strongest non-random relationships.

---

## Key Findings

* **Domestic Responsibility:** The strongest rule found (`Lift: 3.61`) shows that when the **GOVERNMENT** is the actor during **GS_veryLow** stability, it leads to **Protests (141)** with a **90.7% confidence**.
* **Absence of Foreign Influence:** In the top 10 most significant rules for protests, neither the "USA" nor "United States" appeared as a primary driver (LHS).
* **Violence Correlation:** Actions such as **EventCode 145 (Violent Protest)** were found to have a **100% confidence** (Confidence: 1) in resulting in Very Low Stability, highlighting the severity of the 2026 unrest.

---

## Visualizations

### The Node Visual (Network Graph)

The network graph (found in `Nod.html` or `Rplot01.pdf`) illustrates the clusters of conflict.

* **Central Hubs:** Nodes like `GOVERNMENT` and `GS_veryLow` act as hubs, showing they are central to the majority of conflict rules.
* **Regional Hotspots:** Mashhad and Pahlavi (Gilan) appear as significant geographic triggers for protests.
<img width="854" height="846" alt="image" src="https://github.com/user-attachments/assets/ae188298-d1bb-43ac-8f36-38db5d6b9e95" />
<img width="545" height="543" alt="image" src="https://github.com/user-attachments/assets/ed8423f4-e34f-43da-b9ea-2b292372dbb6" />


---

## How to Run

1. Clone this repository.
2. Ensure you have R installed along with libraries: `arules`, `arulesViz`, `visNetwork`, and `ggplot2`.
3. Update the data path in `R_A.R` to point to your local `.csv` file.
4. Run the script to generate the rules and the interactive HTML visual.

