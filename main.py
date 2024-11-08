from pyspark.sql import SparkSession
def process_emp_data():
    spark = SparkSession.builder \
        .appName("PySpark Docker Example") \
        .getOrCreate()

    data = [("Alice", 1,100), ("Bob", 2,300), ("Charlie", 3,400)]
    columns = ["Name", "id","sal"]
    df = spark.createDataFrame(data, columns)
    print(spark.version)

    df.show()

    spark.stop()

if __name__ == "__main__":
    process_emp_data()