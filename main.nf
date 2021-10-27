#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process hello {

  container 'docker/whalesay:latest'

  input: path x

  output: stdout emit: result

  """
  cat $x | cowsay
  """
}

workflow {
  hello(params.str)
  println hello.out.result.view()
}
