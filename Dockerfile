FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONPATH=/usr/local/lib/python3.10/dist-packages:/usr/lib/python3/dist-packages

RUN mkdir -p /opt/blender/app

WORKDIR /opt/blender/app

#RUN export TZ=Europe/Paris
#RUN mkdir -p blender/app
RUN apt update -y && apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt install awscli libsm-dev libxxf86vm-dev libxfixes-dev libxi-dev libxrender-dev libxkbcommon-dev devscripts libgl-dev python3.7 python3-pip git -y

#RUN curl -k -o blender-binaries.tar.xz https://mirrors.aliyun.com/blender/release/Blender3.6/blender-3.6.5-linux-x64.tar.xz
#RUN tar xf blender-binaries.tar.xz


COPY requirements.txt .
RUN pip install -r requirements.txt
RUN pip install --target . awslambdaric
COPY blender-binaries .

COPY lambda_function.py .
COPY script.py .
COPY scene.blend .
RUN ls -ltrh

#RUN echo "export PYTHONPATH=/usr/local/lib/python3.10/dist-packages" >> /etc/bash.bashrc
#RUN echo "export PYTHONPATH=/usr/lib/python3/dist-packages" >> /etc/bash.bashrc
#CMD [ "/usr/bin/python3", "/opt/blender/app/lambda_function.py" ]
ENTRYPOINT [ "/usr/bin/python3", "-m", "awslambdaric" ]
# The CMD sets your handler location (filename.function)
CMD [ "lambda_function.lambda_handler" ]
