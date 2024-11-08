from pyspark.sql import SparkSession
from pyspark.sql import functions as f
def main():
    spark = SparkSession.builder \
        .appName("PySpark Docker Example") \
        .getOrCreate()

    data = [("Alice", 1,100), ("Bob", 2,300), ("Charlie", 3,400)]
    columns = ["Name", "id","sal"]
    df = spark.createDataFrame(data, columns)
    print(spark.version)

    df = df.withColumn("sal_with_bonus",f.col("sal")+f.lit(20))
    df.show()

    spark.stop()

if __name__ == "__main__":
    main()