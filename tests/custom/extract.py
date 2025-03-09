import requests
import pandas as pd

# You must use the requests library to get the public holidays for the given year.
# The url is public_holidays_url/{year}/BR.
# You must delete the columns "types" and "counties" from the dataframe.
# You must convert the "date" column to datetime.
# You must raise a SystemExit if the request fails. Research the raise_for_status
# method from the requests library.

URL = "https://date.nager.at/api/v3/publicholidays/2025/BR"
response = requests.get(URL)

if response.raise_for_status() != None:
    raise SystemExit(f"The following URL {URL} has an invalid response. {response.raise_for_status()}")

df = pd.DataFrame(response.json())

#remove columns using drop
df.drop("types", axis=1, inplace=True)
df.drop("counties", axis=1, inplace=True)
#print(df.columns)

#change "date" column type to datetime
df["date"] = pd.to_datetime(df["date"], format="%Y-%m-%d")
#print(df["date"])

print(df)