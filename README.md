# Data vs. Propaganda: Mapping the 2026 Iranian Domestic Unrest

**Author:** [Haniyeh Raji]

**Date:** January 2026

---

## 1. Abstract

As domestic unrest escalated across Iran in early 2026, the state implemented an "Absolute Digital Isolation" strategy, leading to a near-total nationwide internet blackout by mid-January. This project applies **Association Rule Mining (ARM)** to **16,811** event records from the **GDELT Project** to analyze conflict drivers during this information lockdown. While IRGC narratives frequently attribute domestic protests to foreign funding (e.g., USA, Israel), MY mathematical modeling identifies a domestic, grievance-based origin centered on government-actor interactions. By integrating external research from **Citizen Lab (Report No. 189)**, we distinguish between high-volume digital influence operations and the statistically significant drivers of physical unrest.

---

## 2. Purpose & Mission

The core mission of this study is **Intellectual Honesty**. In an environment where the state controls the physical space and the digital gateway, data is the last line of defense for objective truth.

* **Narrative Verification:** Testing the Islamic Republic’s claim of "foreign-funded" instability. If true, the data should show high *Confidence* and *Lift* between foreign actors (LHS) and protest events (RHS).
* **Accountability Mapping:** Creating a visual "Web of Accountability" to show which domestic government actions correlate with drops in state stability.

---

## 3. Methodology

### Data Collection & Transformation

* **Source:** GDELT 2.0 Global Knowledge Graph via Google BigQuery.
* **Window:** January 1, 2026 – January 18, 2026.
* **Continuous to Categorical:** To make the data suitable for the **Apriori Algorithm**, continuous variables were "binned":
* **Stability:** `GS_veryLow` (-10 to -5), `GS_Low` (-5 to 0), etc.
* **Media Volume:** `Media_Low`, `Media_Med`, `Media_High`.



### Algorithmic Parameters

Utilizing the `arules` package in R:

* **Min. Support:** 0.005
* **Min. Confidence:** 0.5
* **Metric of Interest:** **Lift** (measuring how much more likely a protest is given a specific actor, compared to random chance).

---

## 4. Key Findings

### I. Domestic Responsibility

The strongest rules in the dataset point toward internal triggers.

> **Rule:** {GOVERNMENT, GS_veryLow}  {Protest (CAMEO 141)}
> **Confidence:** 90.7% | **Lift:** 3.61

This indicates that government actions during periods of low stability are the most reliable predictors of protest activity, far outweighing any other actor.

### II. Absence of Foreign Influence

Despite state claims, foreign actors did not appear as primary drivers.

* **Finding:** Neither the "USA" nor "United States" appeared in the top 20 rules sorted by Lift.
* **External Cross-Reference:** Citizen Lab's **Project PRISONBREAK** research confirmed an Israel-linked AI influence operation was active on X (Twitter) at this time. However, our GDELT analysis shows these digital signals had a negligible correlation with the **physical events** on the ground in Mashhad or Gilan.

### III. The "Blackout" Artifact

The data shows a sharp drop in event volume starting **January 8, 2026**.

* This is not a sign of peace; it is a sign of successful **censorship**.
---

## 5. Visualizations

The project includes an interactive **Network Graph** (Node Visual) illustrating the "Hubs of Conflict."

* **Central Hubs:** `GOVERNMENT` and `GS_veryLow` act as the primary anchors for the network.
* **Regional Hotspots:** Mashhad and Pahlavi (Gilan) appear as significant geographic triggers for protests.

---

## 6. Limitations & Reality Check

Data in a conflict zone is never perfect. This report acknowledges:

1. **The Reporting Bias:** GDELT relies on News. During a blackout, thousands of events remain "dark." The reality on the ground is likely more severe than the data suggests.
2. **State-Media Noise:** After the blackout, a higher percentage of available data comes from state-aligned sources. We utilized "Actor Type" filtering to mitigate this, but some bias is inevitable.
3. **Correlation vs. Causality:** While the rules show a strong *association*, they describe a feedback loop rather than a simple linear cause.

---

## 7. Conclusion

The data supports a clear conclusion: **The 2026 unrest was a domestic phenomenon.** While foreign AI influence operations existed in the digital sphere (as documented by Citizen Lab), they were not the "drivers" of the physical conflict. The "Web of Accountability" points squarely at domestic government interactions with the citizenry.

❤️ **Stand with the people.** 🔥 **Stand against oppression.** 🕊️ **Free Iran.**

---

### How to Run

1. Clone this repository.
2. Ensure R libraries `arules`, `arulesViz`, `visNetwork`, and `ggplot2` are installed.
3. Run `R_A.R` to regenerate the rules and the interactive HTML visual.

