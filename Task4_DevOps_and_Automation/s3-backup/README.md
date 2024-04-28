**AWS S3 Bucket Backup Script**

This folder contains a bash script (s3-backup.sh). We can run the script as a cronjob to automate the backup of an AWS S3 bucket to another S3 bucket.

**How the Sync Operation Works**

The script uses the aws s3 sync command to synchronize the source bucket with the destination bucket. This command compares the source and destination buckets and copies any new or modified files from the source to the destination.


For **COST-EFFECTIVENESS** we can  change the storage class for the destination bucket. In this I have taken **DEEP_ARCHIVE** which is the most cheapest method for storing s3 object. 


The sync operation considers an S3 object for copying if:

    The sizes of the two S3 objects differ.
    
    The last modified time of the source is newer than the destination.
    
    The S3 object does not exist under the specified bucket and prefix destination.

**Running the Script**

To run the script, you need to pass four arguments in the following order:

AWS Region (e.g., ap-south-1)

Source S3 bucket name

Destination S3 bucket name

Storage class for the destination bucket


Example:

```
./s3-backup.sh ap-south-1 my-source-bucket my-destination-bucket DEEP_ARCHIVE
```

**Setting Up a Cron Job:**

We can set up a cron job to run this script at regular intervals. Here's an example of how to set up a daily backup at 2 AM:

    1. Open the crontab file:

    ```
    crontab -e
    ```

    2. Add the following line to the crontab file:
    
    ```
    0 2 * * * /path/to/your/script/s3-backup.sh ap-south-1 my-source-bucket my-destination-bucket DEEP_ARCHIVE >> /path/to/your/logfile.log 2>&1
    ```


This line tells cron to run the script at 2 AM every day and log the output to a specified log file.

Remember to replace /path/to/your/script/ with the actual path to the s3-backup.sh script and /path/to/your/logfile.log with the path where you want to store the log file.

Please note that we need to have the AWS CLI installed and configured with the necessary permissions to access the S3 buckets.
