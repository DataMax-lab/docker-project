from pyspark.sql import SparkSession

def main():
    spark = SparkSession.builder \
        .appName("PySpark Docker Example") \
        .getOrCreate()

    data = [("Alice", 1), ("Bob", 2), ("Charlie", 3)]
    columns = ["Name", "Value"]
    df = spark.createDataFrame(data, columns)
    print(spark.version)
    df.show()

    spark.stop()

if __name__ == "__main__":
    main()