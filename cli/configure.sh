[ec2-user@ip-172-31-84-202 ~]$ aws --version
aws-cli/1.16.102 Python/2.7.14 Linux/4.14.114-105.126.amzn2.x86_64 botocore/1.12.92
[ec2-user@ip-172-31-84-202 ~]$ aws configure
AWS Access Key ID [None]: <Enter Access key> 
AWS Secret Access Key [None]: <Enter Secret Key> 
Default region name [None]: us-west-2
Default output format [None]: json
[ec2-user@ip-172-31-84-202 ~]$

[ec2-user@ip-172-31-84-202 ~]$ aws ec2 describe-availability-zones --region us-west-2
{
    "AvailabilityZones": [
        {
            "State": "available",
            "ZoneName": "us-west-2a",
            "Messages": [],
            "ZoneId": "usw2-az2",
            "RegionName": "us-west-2"
        },
        {
            "State": "available",
            "ZoneName": "us-west-2b",
            "Messages": [],
            "ZoneId": "usw2-az1",
            "RegionName": "us-west-2"
        },
        {
            "State": "available",
            "ZoneName": "us-west-2c",
            "Messages": [],
            "ZoneId": "usw2-az3",
            "RegionName": "us-west-2"
        },
        {
            "State": "available",
            "ZoneName": "us-west-2d",
            "Messages": [],
            "ZoneId": "usw2-az4",
            "RegionName": "us-west-2"
        }
    ]
}
[ec2-user@ip-172-31-84-202 ~]$
