<<<<<<< HEAD
# ARG IMAGE=intersystemsdc/irishealth-community:2020.4.0.524.0-zpm
ARG IMAGE=containers.intersystems.com/intersystems/irishealth-community:2021.1.0.215.3

=======
ARG IMAGE=intersystemsdc/irishealth-community:2020.4.0.524.0-zpm
ARG IMAGE=intersystemsdc/irishealth-community:latest
>>>>>>> 42b0128de883afece38e005f44931dc57fa5eb65
FROM $IMAGE
LABEL maintainer="Guillaume Rongier <guillaume.rongier@intersystems.com>"

RUN echo "password" > /tmp/password.txt && /usr/irissys/dev/Container/changePassword.sh /tmp/password.txt

COPY keys/iris.key /usr/irissys/mgr/iris.key

COPY . /tmp/src

WORKDIR /tmp/src

RUN iris start $ISC_PACKAGE_INSTANCENAME EmergencyId=sys,sys && \
 sh install.sh $ISC_PACKAGE_INSTANCENAME && \
 /bin/echo -e "sys\nsys\n" | iris stop $ISC_PACKAGE_INSTANCENAME quietly 

WORKDIR /home/irisowner/
