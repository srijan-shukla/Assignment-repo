#!/bin/bash

# Define region, source and estination buckets and storage class
REGION=$1
SOURCE_BUCKET=$2
DESTINATION_BUCKET=$3
STORAGE_CLASS=$4

# Sync the buckets and changes the storage class in the backup bucket
aws s3 --region "$REGION" sync "$SOURCE_BUCKET" "$DESTINATION_BUCKET" --storage-class "$STORAGE_CLASS"