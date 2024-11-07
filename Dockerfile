FROM openjdk:8-jdk-slim

# Set environment variables
ENV PYSPARK_VERSION=3.4.3
ENV SPARK_VERSION=3.4.3
ENV HADOOP_VERSION=3

# Install dependencies (Java, Spark, and other required libraries)
RUN apt-get update && \
    apt-get install -y python3 python3-pip curl bash && \
    apt-get clean

# Download and install Apache Spark
RUN curl -sL https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | tar -xz -C /opt/ \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark

# Set environment variables for Spark and Hadoop
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH
ENV PYSPARK_PYTHON=python3

# Install Python dependencies (PySpark, etc.)
RUN pip install --no-cache-dir \
    pyspark==${PYSPARK_VERSION}

# Set working directory
WORKDIR /app

# Copy your project files into the container
COPY main.py .

# Expose the necessary port (if running a Spark cluster)
EXPOSE 4040

# Command to run the application
CMD ["python", "main.py"]
