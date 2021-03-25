*** Settings ***
Documentation      Robot Framework: test VM pmathy-dmp-l3out-csr connectivity
Library            pyats.robot.pyATSRobot
Library            tests_pmathy-dmp-l3out-csr.py
Library            tests_all.py
Suite Setup        Set Testbed

*** Variables ***
${testbed_file}            ./robot/pyats/testbed.yml

*** Keywords ***
Set Testbed
    use testbed "${testbed_file}"

*** Test Cases ***
All Test CommonSetup
    run testcase "tests_all.CommonSetup"

Test Device Connectivity for all Testbed devices
    run testcase "tests_all.BasicConnTest"

Test Ping to ACI L3Out IP Address
    run testcase "tests_pmathy-dmp-l3out-csr.CsrGwConnTest"

Read out and validate Routing Table
    run testcase "tests_pmathy-dmp-l3out-csr.CsrRouteTest"
