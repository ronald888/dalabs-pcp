#!/usr/bin/env bash

function getdate {
   current_date=$(gdate +%s%N)
   echo $current_date
}

