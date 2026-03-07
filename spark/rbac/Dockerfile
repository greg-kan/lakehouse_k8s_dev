FROM apache/spark:3.5.8

USER root

# Install python tools + pyspark + jupyter
#RUN apt-get update && \
#    apt-get install -y python3-pip && \
#    pip3 install pyspark==3.5.8 jupyterlab

# Spark must know it's running on k8s
#ENV SPARK_HOME=/opt/spark
# ENV PYSPARK_PYTHON=python3
# ENV PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.9.7-src.zip

#WORKDIR /opt/spark/work-dir

#EXPOSE 8888

#CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]


