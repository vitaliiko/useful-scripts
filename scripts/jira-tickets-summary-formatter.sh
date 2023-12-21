#!/bin/bash

# Consumes file with lines like
# PROJECTID-0001  Ticket Summary  3-  Medium  DONE  2
# And converts each line into the following format
# * [PROJECTID-0001](https://atlassian.net/browse/PROJECTID-0001) Ticket Summary

project_id_to_exclude=PROJECTID
jira_url=https://atlassian.net/browse

while IFS=$'\t' read -r ticket_id summary rest_of_line; do
  if [[ $ticket_id =~ ^$project_id_to_exclude ]]; then
    continue
  fi
  ticket_id=$(echo ${ticket_id} | awk '{print $1}')
  result="* [$ticket_id]($jira_url/$ticket_id) $summary"
  echo "$result"
done < tickets.txt > formatted_tickets.txt
