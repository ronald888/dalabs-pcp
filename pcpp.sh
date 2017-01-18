#!/usr/bin/env bash

THREAD=$1
WORKSET=$2
TARGETDIR=$3

. pcpc.sh

# let's do some quick validation
# but this script should be called from pcp.sh
# which populates the above parameters

if [[ -z ${THREAD} ]] || [[ -z  ${WORKSET} ]] || [[ -z ${TARGETDIR} ]];
then
   echo "pcpp.sh parameters not set."
   echo "Make sure this is called from pcp.sh"
   echo "Exiting. Nothing to do."
   exit 255
fi

echo "THREAD ${THREAD}: Copying files to ${TARGETDIR}"
THREAD_START_TIME=$(getdate)

for work in $WORKSET;
do
   echo "THREAD ${THREAD}: Copying ${work} to ${TARGETDIR}"

   THREAD_CP_START_TIME=$(getdate)
   cp "${work}" "${TARGETDIR}"
   THREAD_CP_END_TIME=$(getdate)

   duration=$(($((($THREAD_CP_END_TIME - $THREAD_CP_START_TIME)))/1000000))
   echo "THREAD ${THREAD}: Copy time: ${duration} milliseconds"
done

THREAD_END_TIME=$(getdate)

duration=$(($((($THREAD_END_TIME - $THREAD_START_TIME)))/1000000))
echo
echo "All files copied to ${TARGETDIR}"
echo "THREAD ${THREAD}: Total Copy time: ${duration} milliseconds"
