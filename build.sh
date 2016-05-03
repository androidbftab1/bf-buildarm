#!/bin/bash
#GPL
BPICMDVERSION="v0.1.1"

#DOCKERIMG="sinovoip/bpi-buildarm"
DOCKERIMG="androidbftab1/bpi-buildarm"
BUILD=YES
RUN=NO
PORT=2223

for IN in "$@" ; do
  if [[ "$IN" == *"="* ]] ; then
    P=${IN%%=*}
    V=${IN##*=}
    echo "INFO: $P to" "${V:-(empty)}"
    eval $P=$V
  fi
done

docker_build() {
  docker build -t ${DOCKERIMG} .
}


docker_run() {
  docker run -d -p ${PORT}:22 -v /media:/media ${DOCKERIMG}
}

main() {
  if [[ "x${BUILD}" == "xYES" ]] ; then
    docker_build
  fi
  if [[ "x${RUN}" == "xYES" ]] ; then
    docker_run
  fi
}

#main
main
