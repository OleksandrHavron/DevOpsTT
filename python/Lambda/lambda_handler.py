import boto3

def lambda_handler(event, context):
    # Get the bucket name and object key from the S3 event
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    object_key = event['Records'][0]['s3']['object']['key']
    
    # Perform a specific action on the newly created object
    s3 = boto3.client('s3')
    # Change object storage class 
    new_storage_class = "STANDARD_IA"
    s3.copy(
        {
            "Bucket": bucket_name, 
            "Key": object_key},
        bucket_name, 
        object_key,
        ExtraArgs = {
            'StorageClass': new_storage_class,
            'MetadataDirective': 'COPY'
        }
    )
    # Print a success message to the CloudWatch logs
    print(f'Successfully processed S3 object {object_key} from bucket {bucket_name}')