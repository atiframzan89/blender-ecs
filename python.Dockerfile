FROM public.ecr.aws/lambda/python:3.10

WORKDIR ${LAMBDA_TASK_ROOT}

RUN yum update -y
RUN yum install tar libc gcc glibc.x86_64 libSM libXfixes libXxf86vm libXi libXrender libxkbcommon libglvnd-glx -y
#RUN curl -k -o blender-binaries.tar.xz https://mirrors.aliyun.com/blender/release/Blender3.6/blender-3.6.5-linux-x64.tar.xz
#RUN tar -xf blender-binaries.tar.xz
RUN echo ${LAMBDA_TASK_ROOT}
# Copy requirements.txt
COPY requirements.txt ${LAMBDA_TASK_ROOT}

COPY blender-binaries ${LAMBDA_TASK_ROOT}

# Install the specified packages
RUN pip install -r requirements.txt

# Copy function code
COPY lambda_function.py ${LAMBDA_TASK_ROOT}
COPY script.py ${LAMBDA_TASK_ROOT}
COPY scene.blend ${LAMBDA_TASK_ROOT}


# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "lambda_function.lambda_handler" ]
