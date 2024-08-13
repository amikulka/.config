#!/bin/bash

monitor_ids=($(aerospace list-monitors --format %{monitor-id}))
echo "Monitor list: ${monitor_ids}"

  for monitor in "${monitor_ids[@]}"; do
  echo "Monitor ID: ${monitor}"
  workspaces=($(aerospace list-workspaces --monitor ${monitor}))
  for sid in "${workspaces[@]}"; do
	  echo "Workspace ID: ${sid}"
  done
done
