FROM ubuntu:latest

# Run a system update to get it up to speed
# Then install python and pip
RUN apt-get update && apt-get install -y python \
    python-pip

# Install jupyter
RUN pip install jupyter

# Create a new system user
#RUN useradd -ms /bin/bash jupyter

# Change to this new user
#USER jupyter

# Set the container working directory to the user home folder
#WORKDIR /home/google939756_student/test/
#WORKDIR /home/test/output/

RUN useradd -ms /bin/bash jupyter

# Change to this new user
USER jupyter

# Set the container working directory to the user home folder
WORKDIR /home/jupyter/
#COPY Hello.ipynb /home/google939756_student/test/
COPY jupyterServer.ipynb /home/jupyter/

RUN jupyter nbconvert --to python jupyterServer.ipynb
#COPY Hello.py /home/jupyter/

#RUN pwd
#COPY Hello.py /home/jupyter/
#ENTRYPOINT ["python","Hello.py"]
#EXPOSE 8888
#COPY py.sh /home/jupyter/
#RUN python py.sh
#COPY /home/google941385_student/JupyterOneClick/py.sh /home/jupyter/
#RUN ./py.sh
#RUN python /home/jupyter/Hello.py
ENTRYPOINT ["python","-m","jupyterServer.py","8888"]