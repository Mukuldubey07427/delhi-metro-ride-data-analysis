import pandas as pd
import numpy as np

data = pd.read_csv('delhi_metro_updated.csv')

print(data.head())       # first 5 rows
print(data.tail())       # last 5 rows

print("\nSHAPE:")
print(data.shape)

print("\nCOLUMNS:")
print(data.columns)

print("\nDATA TYPES:")
print(data.dtypes)

print("\nMISSING VALUES:")
print(data.isnull().sum())

print("\nDUPLICATE ROWS:")
print(data.duplicated().sum())

# Check duplicates
print("Duplicate rows:", data.duplicated().sum())
# Remove duplicates
data = data.drop_duplicates()

#text columns cleaning
text_columns= [
    "From_Station",
    "To_Station",
    "Ticket_Type",
    "Remarks"
]
for col in text_columns:
    data[col] = data[col].astype("string").str.strip()

#date conversion
data["Date"] = pd.to_datetime(
    data["Date"],
    errors="coerce"
)

#Filling the missing values in passengers column
data["Passengers"]=data["Passengers"].fillna(data["Passengers"].median())
#Filling the missing values in Ticket_types column
data["Ticket_Type"]=data["Ticket_Type"].fillna("unknown")
#Filling the missing values in Remarks column
data["Remarks"]=data["Remarks"].fillna("Not specified")

# CHECK INVALID / NEGATIVE VALUES
print("Negative distance :",(data["Distance_km"] < 0).sum())
print("Negative fare:",(data["Fare"] < 0).sum())
print("Negative cost:",(data["Cost_per_passenger"] < 0).sum())
print("Negative Passengers:",(data["Passengers"] < 0).sum())

data.loc[data["Distance_km"] < 0, "Distance_km"] = np.nan
data.loc[data["Fare"] < 0, "Fare"] = np.nan
data.loc[data["Cost_per_passenger"] < 0, "Cost_per_passenger"] = np.nan
data.loc[data["Passengers"] < 0, "Passengers"] = np.nan

print("\n--- FINAL MISSING VALUES ---")
print(data.isnull().sum())

print("\n--- FINAL DUPLICATES ---")
print("Duplicate rows:", data.duplicated().sum())

print("\n--- FINAL DATA TYPES ---")
print(data.dtypes)

print("\n--- FINAL SHAPE ---")
print(data.shape)

data.to_csv( "delhi_metro_cleaned.csv",index=False)

print("DATA CLEANING COMPLETED")


