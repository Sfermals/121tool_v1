# 121TOOL_v1

![Screenshot](1.jpg)

As per requirenment, application makes use of a built-in JSON data file, whose filename can be
specified in the “DATA_FILE” environment variable. If the environment variable is not
found, then it will default to using “Questions.json”.

a. The “staging” branch should use “Questions-test.json” as its input
datafile

![Screenshot](s.png)

![Screenshot](quest-test.png)


b. The “release” branch should use “Questions.json” as its input datafile

![Screenshot](r.png)

![Screenshot](ques.png)

CI/CD ran in jenkins:

https://sfermals.app/


Improvement can be done: 

- fix trigger issue upon commiting
- run test intergrated with sonarqube to gather code vulnerability and code smells
- integrate into pipeline code, script to stop previously run container on same port before running new ones

exp: 

#!/usr/bin/env bash

for id in $(docker ps -q)
do
    if [[ $(docker port "${id}") == *"${1}"* ]]; then
        echo "stopping container ${id}"
        docker stop "${id}"
    fi
done


- To be continue as more and more experience and knowledge learned. Thanks.
