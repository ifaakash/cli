#!/bin/bash
CONFIG_PATH="$HOME/.aws/config"

printf "*%.0s" {1..30}
echo "\nValidating AWS CLI installation"
if command -v aws &> /dev/null; then
	echo "AWS CLI is installed!"
	printf "*%.0s" {1..30}
else
	echo "\nAWS CLI is not installed!"
	echo "Do you want to install? Enter y – for YES / n - for NO"
fi
echo -e "\nAvailable AWS Profiles:"
PROFILES=$(grep -E '^\[(profile )?[a-zA-Z0-9_-]+\]' "$CONFIG_PATH" | sed -E 's/^\[profile //; s/^\[//; s/\]$//')
printf "$PROFILES" | cat -n

printf "\nSelect the AWS PROFILE that you want to authenticate to"
read SELECTED_PROFILE
printf "\nEnter the AWS Region"
read AWS_REGION
printf "*%.0s" {1..30}
printf "\nConnecting to $SELECTED_PROFILE"
aws configure sso

aws sso login --profile $SELECTED_PROFILE --region $AWS_REGION
printf "\nAuthenticating to Cloud"
