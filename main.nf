#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// process getVersions {

//   container = "taniguti/wf-cas9"

//   publishDir "publish_dir"

//   output: path "versions.txt", emit: samples_bam

//   script:
//   """
//   samtools --version | head -n 1 | sed 's/ /,/' >> versions.txt
//   """
// }

process hello {

  container 'docker/whalesay:latest'

  publishDir "publish_dir"

  input: path x

  output:
    path "versions.txt", emit: versions
    stdout emit: cowsay

  script:
  """
  echo nihao >> versions.txt
  cat $x | cowsay
  """
}

workflow {

  hello(params.str)
  println hello.out.cowsay.view()
  println hello.out.versions.view()
  println params.str

  // getVersions()
  // getVersions.out.samples_bam.view()
}
