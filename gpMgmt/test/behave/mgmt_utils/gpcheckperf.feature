@gpcheckperf
Feature: Tests for gpcheckperf

  @concourse_cluster
  Scenario: gpcheckperf runs disk and memory tests
    Given the database is running
    When  the user runs "gpcheckperf -h cdw -h sdw1 -d /data/gpdata/ -r ds"
    Then  gpcheckperf should return a return code of 0
    And   gpcheckperf should print "disk write tot bytes" to stdout

  @concourse_cluster
  Scenario: gpcheckperf runs runs sequential network test
    Given the database is running
    When  the user runs "gpcheckperf -h cdw -h sdw1 -d /data/gpdata/ -r n"
    Then  gpcheckperf should return a return code of 0
    And   gpcheckperf should print "avg = " to stdout
    And   gpcheckperf should not print "NOTICE: -t is deprecated " to stdout

   @concourse_cluster
   Scenario: gpcheckperf runs tests by passing hostfile in extra verbose mode
     Given the database is running
     And create a gpcheckperf input host file
     When  the user runs "gpcheckperf -f /tmp/hostfile1 -r M -d /data/gpdata/ --duration=3m -V"
     Then  gpcheckperf should return a return code of 0
     And   gpcheckperf should print "Full matrix netperf bandwidth test" to stdout
     And   gpcheckperf should not print "IndexError: list index out of range" to stdout
     And   gpcheckperf should print "--  NETPERF TEST" to stdout
     And   gpcheckperf should print "TEARDOWN" to stdout

  @concourse_cluster
   Scenario: gpcheckperf runs tests by passing hostfile in verbose mode
     Given the database is running
     And create a gpcheckperf input host file
     When  the user runs "gpcheckperf -f /tmp/hostfile1 -r M -d /data/gpdata/ --duration=3m -v"
     Then  gpcheckperf should return a return code of 0
     And   gpcheckperf should print "Full matrix netperf bandwidth test" to stdout
     And   gpcheckperf should not print "IndexError: list index out of range" to stdout
     And   gpcheckperf should print "--  NETPERF TEST" to stdout
     And   gpcheckperf should print "making gpcheckperf directory on all hosts ..." to stdout
     And   gpcheckperf should print "TEARDOWN" to stdout

  @concourse_cluster
   Scenario: gpcheckperf runs tests by passing hostfile in regular mode
     Given the database is running
     And create a gpcheckperf input host file
     When  the user runs "gpcheckperf -f /tmp/hostfile1 -r M -d /data/gpdata/ --duration=3m"
     Then  gpcheckperf should return a return code of 0
     And   gpcheckperf should print "Full matrix netperf bandwidth test" to stdout
     And   gpcheckperf should not print "IndexError: list index out of range" to stdout

  @concourse_cluster
   Scenario: gpcheckperf runs network test by passing hostfile in regular mode
     Given the database is running
     And create a gpcheckperf input host file
     When  the user runs "gpcheckperf -f /tmp/hostfile1 -r N -d /data/gpdata/ --duration=3m"
     Then  gpcheckperf should return a return code of 0
     And   gpcheckperf should print "--  NETPERF TEST" to stdout
     And   gpcheckperf should print "Netperf bisection bandwidth test" to stdout

  @concourse_cluster
   Scenario: gpcheckperf runs network test by passing hostfile in verbose mode
     Given the database is running
     And create a gpcheckperf input host file
     When  the user runs "gpcheckperf -f /tmp/hostfile1 -r N -d /data/gpdata/ --duration=3m -v"
     Then  gpcheckperf should return a return code of 0
     And   gpcheckperf should print "--  NETPERF TEST" to stdout
     And   gpcheckperf should print "Netperf bisection bandwidth test" to stdout
     And   gpcheckperf should print "making gpcheckperf directory on all hosts ..." to stdout
     And   gpcheckperf should print "TEARDOWN" to stdout

  @concourse_cluster
   Scenario: gpcheckperf runs matrix test by passing single host should not throw exception
     Given the database is running
     And create a gpcheckperf input host file
     When  the user runs "gpcheckperf -h cdw -r M -d /data/gpdata/ --duration=3m -v"
     Then  gpcheckperf should return a return code of 0
     And   gpcheckperf should print "--  NETPERF TEST" to stdout
     And   gpcheckperf should print "single host only - abandon netperf test" to stdout
     And   gpcheckperf should print "TEARDOWN" to stdout
     And   gpcheckperf should not print "TypeError:" to stdout

  @concourse_cluster
   Scenario: gpcheckperf runs network test by passing single host should not throw exception
     Given the database is running
     And create a gpcheckperf input host file
     When  the user runs "gpcheckperf -h cdw -r N -d /data/gpdata/ --duration=3m -v"
     Then  gpcheckperf should return a return code of 0
     And   gpcheckperf should print "--  NETPERF TEST" to stdout
     And   gpcheckperf should print "single host only - abandon netperf test" to stdout
     And   gpcheckperf should print "TEARDOWN" to stdout
     And   gpcheckperf should not print "TypeError:" to stdout

