import pandas as pd
import matplotlib.pyplot as plt 
from sqlalchemy import create_engine

engine = create_engine(
    "postgresql://postgres:MUKUL@localhost:5432/Delhi_metro"
)

print("PostgreSQL connected successfully!")
# Top 10 from station 
query1 = """
SELECT from_station,count(*) as total_rides FROM DELHI_METRO_RIDES
GROUP BY from_station 
Order by total_rides DESC
limit 10 ;"""
df1=pd.read_sql(query1,engine)
print(df1)
#Ticket Type-wise Rides
query2 = """
SELECT ticket_type,COUNT(*) AS total_rides
FROM DELHI_METRO_RIDES
GROUP BY ticket_type
ORDER BY total_rides DESC;"""
df2=pd.read_sql(query2,engine)
print(df2)
#monthly total rides
query3 = """
SELECT DATE_TRUNC('month', date) AS month,COUNT(*) AS total_rides
FROM DELHI_METRO_RIDES
GROUP BY month
ORDER BY month; ;"""
df3=pd.read_sql(query3,engine)
print(df3)
# Monthly total revenue
query4 = """
SELECT DATE_TRUNC('month', date) AS month,SUM(fare * passengers) AS total_revenue
FROM DELHI_METRO_RIDES
GROUP BY month
ORDER BY month;"""
df4=pd.read_sql(query4,engine)
print(df4)
# TICKET TYPE-WISE REVENUE
query5 = """
SELECT ticket_type,SUM(fare * passengers) AS total_revenue
FROM DELHI_METRO_RIDES
GROUP BY ticket_type
ORDER BY total_revenue DESC;
"""
df5 = pd.read_sql(query5, engine)
print(df5)
#TOP 10 STATIONS BY TOTAL PASSENGERS
query6 = """
SELECT from_station,SUM(passengers) AS total_passengers
FROM DELHI_METRO_RIDES
GROUP BY from_station
ORDER BY total_passengers DESC
LIMIT 10;
"""
df6 = pd.read_sql(query6, engine)
print(df6)

#----------------------------------------#
#PLOTING Graphs #
#----------------------------------------#
plt.figure(figsize=(18,22))


# GRAPH 1
plt.subplot(3,2,1)

plt.bar(df1["from_station"], df1["total_rides"], color="r")

plt.ylabel("TOTAL RIDES")
plt.title("TOP 10 FROM STATION", pad=15)

plt.xticks(rotation=30, fontsize=9)


# GRAPH 2
plt.subplot(3,2,2)

plt.bar(df2["ticket_type"], df2["total_rides"], color="b")

plt.ylabel("TOTAL RIDES")
plt.title("RIDES BY TICKET TYPE", pad=15)

plt.xticks(rotation=30, fontsize=9)



# GRAPH 3
plt.subplot(3,2,3)

plt.plot(df3["month"], df3["total_rides"], color="g", marker="o")

plt.ylabel("TOTAL RIDES")
plt.title("MONTHLY TOTAL RIDES", pad=15)

plt.xticks(df3["month"][::3], rotation=30, fontsize=9)
plt.grid()

# GRAPH 4
plt.subplot(3,2,4)

plt.plot(df4["month"], df4["total_revenue"], color="m", marker="o")

plt.ylabel("TOTAL REVENUE")
plt.title("MONTHLY TOTAL REVENUE", pad=15)

plt.xticks(df4["month"][::3], rotation=30, fontsize=9)
plt.grid()

# GRAPH 5
plt.subplot(3,2,5)

plt.bar(df5["ticket_type"], df5["total_revenue"], color="orange")

plt.ylabel("TOTAL REVENUE")
plt.title("REVENUE BY TICKET TYPE", pad=15)

plt.xticks(rotation=30, fontsize=9)


# GRAPH 6
plt.subplot(3,2,6)

plt.bar(df6["from_station"], df6["total_passengers"], color="purple")

plt.ylabel("TOTAL PASSENGERS")
plt.title("TOP 10 STATIONS BY PASSENGERS", pad=15)

plt.xticks(rotation=30, fontsize=9)


# PROPER SPACING
plt.subplots_adjust(
    left=0.08,
    right=0.95,
    top=0.95,
    bottom=0.10,
    hspace=1.0,
    wspace=0.3
)
plt.savefig("metro_analysis.png", dpi=300, bbox_inches="tight")

plt.show()