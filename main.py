from pyspark.sql import SparkSession
def process_emp_data():
    spark = SparkSession.builder \
        .appName("PySpark Docker Example") \
        .getOrCreate()
    print(spark.version)

    data = [("Alice", 1,100), ("Bob", 2,300), ("Charlie", 3,400)]
    columns = ["Name", "id","sal"]


    df = spark.createDataFrame(data, columns)
    df.createOrReplaceTempView("vw_emp")

    sql= f"""
                with tab_sql as
                (
                    select  row_number()over(order by sal )rno ,
                            id,
                            name,
                            sal
                    from    vw_emp
                )
                select  *
                from    tab_sql
        """

    df = spark.sql(sql)

    df.show()

    spark.stop()

if __name__ == "__main__":
    process_emp_data()