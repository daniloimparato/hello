#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process echo_remote_file_content {

  // container = "docker.io/biocontainers/biocontainers:v1.2.0_cv1" // does not work :(
  // container = "docker.io/docker/whalesay:latest" // works! both images are public

  input: path remote_file

  output: stdout emit: cat

  script: "cat $remote_file"
}

workflow {
  echo_remote_file_content(params.remote_file)
  echo_remote_file_content.out.cat.view()
}
