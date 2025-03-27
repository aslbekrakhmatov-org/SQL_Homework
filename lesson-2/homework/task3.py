import pyodbc

connection=pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=DESKTOP-R3QV8MR;"
    "DATABASE=lesson2;"
    "Trusted_Connection=yes;"
)

cursor= connection.cursor()

query = ('''SELECT * FROM photos''')

cursor.execute(query)
row = cursor.fetchone()
image_id, image_data = row
if row:
    with open("retrieved_image.png", "wb") as file:
        file.write(image_data)
else:
    print("No image found in the database.")

cursor.close()
connection.close()