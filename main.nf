#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process hello {

  container 'docker/whalesay:latest'

  input: val x

  output: stdout emit: result

  """
  cowsay '${x}'
  """
}

workflow {
    hello(params.str)
    println hello.out.result.view()
}
