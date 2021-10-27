#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process get_remote_file {

  // container = "taniguti/wf-cas9"
  // container = "docker.io/taniguti/wf-cas9:latest"
  container = "quay.io/nextflow/bash"

  publishDir "publish_dir"

  input: path remote_file

  output: path "message.txt", emit: message

  script:
  """
  cat $remote_file >> message.txt
  """
}

process cowsay_remote_file_content {

  container 'docker.io/docker/whalesay:latest'

  publishDir "publish_dir"

  input: path message

  output:
    stdout emit: cowsay

  script:
  """
  cat $message | cowsay
  """
}

workflow {

  get_remote_file(params.str)

  cowsay_remote_file_content(get_remote_file.out)

  println cowsay_remote_file_content.out.cowsay.view()
  println params.str
}
