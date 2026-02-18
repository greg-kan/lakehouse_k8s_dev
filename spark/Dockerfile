FROM ubuntu:22.04

ARG SPARK_VERSION=3.5.8 \
 SPARK_MAJOR_VERSION=3.5 \
 HADOOP_VERSION=3.3.4 \
 HADOOP_MAJOR_VERSION=3 \
 PYTHON_VERSION=3.10 \
 AWS_SDK_VERSION=1.12.262 \
 SCALA_VERSION=2.12 \
 ICEBERG_VERSION=1.9.2 \
 SPARK_DIST=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_MAJOR_VERSION}

RUN apt-get update && \
 apt-get -y install openjdk-11-jdk-headless \
 wget \
 python${PYTHON_VERSION} \
 python3-pip && \
 apt-get clean
 
RUN wget https://downloads.apache.org/spark/spark-${SPARK_VERSION}/${SPARK_DIST}.tgz && \
 tar -xzf ${SPARK_DIST}.tgz && \
 mv ${SPARK_DIST} /opt/spark && \
 rm ${SPARK_DIST}.tgz
  
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH

RUN wget -nv -P ${SPARK_HOME}/jars \
  https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_2.12/${ICEBERG_VERSION}/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_2.12-${ICEBERG_VERSION}.jar \
  https://repo1.maven.org/maven2/org/projectnessie/nessie-integrations/nessie-spark-extensions-${SPARK_MAJOR_VERSION}_2.12/0.105.3/nessie-spark-extensions-${SPARK_MAJOR_VERSION}_2.12-0.105.3.jar \
  https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/${ICEBERG_VERSION}/iceberg-aws-bundle-${ICEBERG_VERSION}.jar \
  https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_SDK_VERSION}/aws-java-sdk-bundle-${AWS_SDK_VERSION}.jar \
  https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar \
  https://repo1.maven.org/maven2/org/postgresql/postgresql/42.6.2/postgresql-42.6.2.jar

RUN pip3 install --upgrade pip

RUN pip install --no-cache-dir \
 jupyterlab \
 pyspark==${SPARK_VERSION} \
 pandas \
 sparksql-magic

WORKDIR /workspace

EXPOSE 7077
EXPOSE 8080
EXPOSE 8888
EXPOSE 4040

# ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]

