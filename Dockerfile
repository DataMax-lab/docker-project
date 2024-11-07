# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set environment variables
ENV PYSPARK_VERSION=3.3.1
ENV SPARK_VERSION=3.3.1
ENV HADOOP_VERSION=3.2

# Install dependencies (Java, Spark, and other required libraries)
RUN apt-get update \
    && apt-get install -y \
    openjdk-8-jdk \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Download and install Apache Spark
RUN curl -sL https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | tar -xz -C /opt/ \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark

# Set environment variables for Spark and Hadoop
ENV SPARK_HOME=/opt/spark
ENV HADOOP_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin

# Install Python dependencies (PySpark, etc.)
RUN pip install --no-cache-dir \
    pyspark==${PYSPARK_VERSION} \
    pandas \
    matplotlib \
    numpy \
    scikit-learn

# Set working directory
WORKDIR /app

# Copy your project files into the container
COPY . /app

# Expose the necessary port (if running a Spark cluster)
EXPOSE 4040

# Command to run the application
CMD ["python", "main.py"]
