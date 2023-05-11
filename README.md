# DevOps technical tasks
## Python
1. Create HTTPS server: Create a Flask server that communicates over HTTPS. The
server should accept requests from clients over HTTPS and respond with a JSON
payload containing a greeting message and the client's IP address.
2. AWS Lambda - Handle S3 bucket creation: Write a Lambda function that triggers
when an S3 bucket object is created and performs a specific action.
## Docker
1. Python App - Compiled Library: Create a Docker image for a Python app that uses a
C library. The C library needs to be compiled from source, and the Python app needs to
be able to access the compiled library.
## Terraform
1. AWS Lambda: Create a Terraform configuration that provisions an AWS Lambda
function and an API Gateway endpoint that triggers the Lambda function. The
configuration should include appropriate IAM roles and permissions.
## Bash
1. Scan Hosts: Write a Bash script that performs a network health check by pinging a list
of hosts and logging the results to a file. The script should prompt the user for the name
of the file containing the list of hosts, the number of ping packets to send, and the time
interval between ping packets. The script should output a message for each host
indicating whether the ping was successful or not and log the results to a file. The log file
should contain the timestamp, the host name or IP address, the number of packets sent,
the number of packets received, and the percentage of packets lost.