# import pandas as pd

# # df = pd.read_csv("ncr_ride_bookings.csv")

# # print(df)

# # avg_distance = df["Ride Distance"].mean()
# # avg_driver_rating = df["Driver Ratings"].mean()
# # avg_customer_rating = df["Customer Rating"].mean()

# # # ---------------------------------------------------
# # # GENERAL NULL REPLACEMENT
# # # ---------------------------------------------------

# # df["Booking Value"].fillna(0, inplace=True)

# # df["Ride Distance"].fillna(avg_distance, inplace=True)

# # df["Driver Ratings"].fillna(avg_driver_rating, inplace=True)

# # df["Customer Rating"].fillna(avg_customer_rating, inplace=True)

# # df["Payment Method"].fillna("Cash on Delivery", inplace=True)

# # # ---------------------------------------------------
# # # RIDE CANCELLED BEFORE START
# # # ---------------------------------------------------

# # condition1 = df["Booking Status"] == "Cancelled by Customer"

# # df.loc[condition1, "Booking Value"] = \
# # df.loc[condition1, "Booking Value"].fillna(0)

# # df.loc[condition1, "Ride Distance"] = \
# # df.loc[condition1, "Ride Distance"].fillna(0)

# # df.loc[condition1, "Driver Ratings"] = \
# # df.loc[condition1, "Driver Ratings"].fillna(0)

# # df.loc[condition1, "Customer Rating"] = \
# # df.loc[condition1, "Customer Rating"].fillna(avg_customer_rating)

# # # Payment method remains null
# # df.loc[condition1, "Payment Method"] = \
# # df.loc[condition1, "Payment Method"]

# # # ---------------------------------------------------
# # # RIDE CANCELLED/STOPPED IN MIDDLE
# # # ---------------------------------------------------

# # condition2 = (
# #     (df["Booking Status"] == "Incomplete") |
# #     (df["Incomplete Rides Reason"] == "Ride Cancelled") |
# #     (df["Incomplete Rides Reason"] == "Stopped in Middle")
# # )

# # df.loc[condition2, "Booking Value"] = \
# # df.loc[condition2, "Booking Value"].fillna(100)

# # df.loc[condition2, "Ride Distance"] = \
# # df.loc[condition2, "Ride Distance"].fillna(avg_distance)

# # df.loc[condition2, "Driver Ratings"] = \
# # df.loc[condition2, "Driver Ratings"].fillna(3.5)

# # df.loc[condition2, "Customer Rating"] = \
# # df.loc[condition2, "Customer Rating"].fillna(avg_customer_rating)

# # df.loc[condition2, "Payment Method"] = \
# # df.loc[condition2, "Payment Method"].fillna("Cash")

# # # ---------------------------------------------------
# # # CHECK NULL VALUES
# # # ---------------------------------------------------

# # print(df.isnull().sum())

# # # SAVE CLEANED DATA
# # df.to_csv("cleaned_uber_data1.csv", index=False)

# # print("Data cleaning completed")

# # import pandas as pd
# import numpy as np

# df = pd.read_csv("cleaned_uber_data1.csv")

# # Convert empty spaces to null
# df.replace(r'^\s*$', np.nan, regex=True, inplace=True)

# # Check null values
# print(df.isnull().sum())
# df.to_csv("cleaned_uber_data2.csv", index=False)

# print("Data cleaning completed")



import pandas as pd

# Load dataset
df = pd.read_csv("ncr_ride_bookings.csv")

# ---------------------------------------------------
# 1. Remove extra quotes from text columns
# ---------------------------------------------------
df["Booking ID"] = df["Booking ID"].str.replace('"', '', regex=False)
df["Customer ID"] = df["Customer ID"].str.replace('"', '', regex=False)

# ---------------------------------------------------
# 2. Convert Date column to datetime
# ---------------------------------------------------
df["Date"] = pd.to_datetime(df["Date"], errors='coerce')

# ---------------------------------------------------
# 3. Convert Time column to proper time format
# ---------------------------------------------------
df["Time"] = pd.to_datetime(df["Time"], format='%H:%M:%S', errors='coerce').dt.time

# ---------------------------------------------------
# 4. Remove duplicate rows
# ---------------------------------------------------
df.drop_duplicates(inplace=True)

# ---------------------------------------------------
# 5. Handle missing numerical values
# ---------------------------------------------------
numeric_cols = [
    "Avg VTAT",
    "Avg CTAT",
    "Booking Value",
    "Ride Distance",
    "Driver Ratings",
    "Customer Rating"
]

for col in numeric_cols:
    df[col] = df[col].fillna(df[col].median())

# ---------------------------------------------------
# 6. Handle missing categorical values
# ---------------------------------------------------
categorical_cols = [
    "Reason for cancelling by Customer",
    "Driver Cancellation Reason",
    "Incomplete Rides Reason",
    "Payment Method"
]

for col in categorical_cols:
    df[col] = df[col].fillna("Not Applicable")

# ---------------------------------------------------
# 7. Fill ride-related missing flags with 0
# ---------------------------------------------------
flag_cols = [
    "Cancelled Rides by Customer",
    "Cancelled Rides by Driver",
    "Incomplete Rides"
]

for col in flag_cols:
    df[col] = df[col].fillna(0)

# ---------------------------------------------------
# 8. Check remaining missing values
# ---------------------------------------------------
print(df.isnull().sum())

# ---------------------------------------------------
# 9. Save cleaned dataset
# ---------------------------------------------------
df.to_csv("cleaned_ncr_ride_bookings.csv", index=False)

print("Dataset cleaned successfully!")