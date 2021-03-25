*** Settings ***
Documentation      Robot Framework: Test VM OoB connectivity
Library            Process

*** Test Cases ***
Test Ping to pmathy-dmp-app1-epg1
    ${result} =  Run Process  ping 192.168.1.100 -c 3  shell=True
    Log  all output: ${result.stdout}
    Should Contain  ${result.stdout}  64 bytes from 192.168.1.100

Test Ping to pmathy-dmp-app1-epg2
    ${result} =  Run Process  ping 192.168.1.101 -c 3  shell=True
    Log  all output: ${result.stdout}
    Should Contain  ${result.stdout}  64 bytes from 192.168.1.101

Test Ping to pmathy-dmp-app1-epg3
    ${result} =  Run Process  ping 192.168.1.102 -c 3  shell=True
    Log  all output: ${result.stdout}
    Should Contain  ${result.stdout}  64 bytes from 192.168.1.102

Test Ping to pmathy-dmp-app1-epg4
    ${result} =  Run Process  ping 192.168.1.103 -c 3  shell=True
    Log  all output: ${result.stdout}
    Should Contain  ${result.stdout}  64 bytes from 192.168.1.103

Test Ping to pmathy-dmp-l3out-csr
    ${result} =  Run Process  ping 192.168.1.200 -c 3  shell=True
    Log  all output: ${result.stdout}
    Should Contain  ${result.stdout}  64 bytes from 192.168.1.200