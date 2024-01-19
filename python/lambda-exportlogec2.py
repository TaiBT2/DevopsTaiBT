import boto3
import csv

s3Client = boto3.client('s3')
def lambda_handler(event, context):
    bucket = event['Record'][0]['s3']['bucket']['name']
    key = event['Record'][0]['object']['key']
    # TODO implement
    print(bucket)
    print(key)
    
    response = s3Client.get_object(Bucket=bucket, Key = key)
    
    data = response['Body'].read().decode('utf-8')
    reader =csv.reader(io.StringIO(data))
    next(reader)
    for row in reader:
        print(str.format("year-{}, Mileage-{}, Price-{}", row[0], row[1], row[2]))
