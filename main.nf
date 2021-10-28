#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process echo_remote_file_content {

  container = "docker.io/taniguti/wf-cas9:latest"   // this does not work :(
  // container = "docker.io/docker/whalesay:latest" // this works!!

  input: path remote_file

  output: stdout emit: cat

  script: "cat $remote_file"
}

workflow {
  echo_remote_file_content(params.remote_file)
  println echo_remote_file_content.out.cat.view()
}
