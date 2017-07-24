#!/usr/bin/env bash
aws ecs create-cluster --cli-input-json file://manual-aws-ecs-cluster.json

aws ecs create-service --cli-input-json file://manual-aws-ecs-service.json

aws ecs register-task-definition --cli-input-json file://manual-aws-ecs-taskdef.json


