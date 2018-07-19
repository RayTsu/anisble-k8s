#!/bin/sh
nexus_repo_dir=/app/sonatype-work/nexus3/blobs/default/content/directpath/nexus-repository-docker
docker_name="$1"
cd $nexus_repo_dir
for i in `ls |grep -v check`
do
  cd $nexus_repo_dir
  cd $i;grep "docker-name=$docker_name" *.properties >/dev/null
  if [[ $? -ne 0 ]];then
      continue
  fi
  echo $i
  echo "*********start clean $docker_name***********"
  rm -r $nexus_repo_dir/$i
  echo "*********end clean $docker_name***********"
  cd $nexus_repo_dir
done

