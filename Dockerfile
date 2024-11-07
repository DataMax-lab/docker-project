# Use an official OpenJDK as a parent image (required by Spark)
FROM openjdk:8-jdk-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install Spark (version 3.3.0)
ENV SPARK_VERSION=3.3.0
ENV HADOOP_VERSION=3.2

RUN curl -o /tmp/spark.tar.gz \
    "https://apache.mirrors.hoobly.com/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
    && tar -xvzf /tmp/spark.tar.gz -C /opt \
    && rm /tmp/spark.tar.gz

# Set Spark environment variables
ENV SPARK_HOME=/opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}
ENV PATH=$SPARK_HOME/bin:$PATH
ENV PYSPARK_PYTHON=python3

# Install Python dependencies
RUN apt-get update && apt-get install -y python3 python3-pip
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Set working directory
WORKDIR /app

# Copy the PySpark app to the container
COPY main.py .

# Command to run the PySpark app
CMD ["python3", "app.py"]