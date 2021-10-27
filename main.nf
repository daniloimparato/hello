#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process get_remote_file {

  container = "docker.io/docker/whalesay:latest"
  // container = "docker.io/taniguti/wf-cas9:latest"

  input: path remote_file

  output: path "message.txt", emit: message

  script:
  """
  cat $remote_file >> message.txt
  """
}

process cat_remote_file_content {

  container = "docker.io/docker/whalesay:latest"
  // container = "docker.io/taniguti/wf-cas9:latest"

  input: path message

  output: stdout emit: cat

  script:
  """
  cat $message
  """
}

workflow {

  get_remote_file(params.str)

  cat_remote_file_content(get_remote_file.out)

  println cat_remote_file_content.out.cat.view()
  println params.str
}
