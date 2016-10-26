# tf_ecs
terraform for the AWS ecs container service
```
aws iam get-instance-profile --instance-profile-name ecs_inst_profile
{
    "InstanceProfile": {
        "InstanceProfileId": "AIPAISUEKRXXX2NHVWVRS", 
        "Roles": [
            {
                "AssumeRolePolicyDocument": {
                    "Version": "2008-10-17", 
                    "Statement": [
                        {
                            "Action": "sts:AssumeRole", 
                            "Effect": "Allow", 
                            "Principal": {
                                "Service": [
                                    "ecs.amazonaws.com", 
                                    "ec2.amazonaws.com"
                                ]
                            }
                        }
                    ]
                }, 
                "RoleId": "AROAJAZ3U767HNO52GCKC", 
                "CreateDate": "2016-10-26T09:53:08Z", 
                "RoleName": "ecs_role", 
                "Path": "/", 
                "Arn": "arn:aws:iam::123454823659:role/ecs_role"
            }
        ], 
        "CreateDate": "2016-10-26T09:53:09Z", 
        "InstanceProfileName": "ecs_inst_profile", 
        "Path": "/", 
        "Arn": "arn:aws:iam::123454823659:instance-profile/ecs_inst_profile"
    }
}
```
```
curl http://169.254.169.254/latest/meta-data/iam/info; echo
{
  "Code" : "Success",
  "LastUpdated" : "2016-10-26T13:23:55Z",
  "InstanceProfileArn" : "arn:aws:iam::123454823659:instance-profile/ecs_inst_profile",
  "InstanceProfileId" : "AIPAISUEKRXXX2NHVWVRS"
}
```
