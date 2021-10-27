#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// chosen_image = "docker.io/docker/whalesay:latest"
chosen_image = "docker.io/taniguti/wf-cas9:latest"

process get_remote_file {

  container = chosen_image

  input: path remote_file

  output: path "message.txt", emit: message

  script:
  """
  cat $remote_file >> message.txt
  """
}

process cat_remote_file_content {

  container = chosen_image

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
