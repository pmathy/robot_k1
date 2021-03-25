*** Settings ***
Documentation      Robot Framework: test VM pmathy-dmp-app1-epg1 connectivity
Library            SSHLibrary
Suite Setup        Connect Host
Suite Teardown     Close All Connections

*** Variables ***
${host}            192.168.1.100
${username}        %{RBT_SSH_UN}
${password}        %{RBT_SSH_PW}
${alias}           pmathy-dmp-app1-epg1

*** Keywords ***
Connect Host
    Open Connection     ${host}        alias=${alias}
    Login               ${username}    ${password}    delay=1

*** Test Cases ***
Test Ping to ACI Gateway
    ${stdout} =  Execute Command  ping 10.1.1.1 -c 3
    Should Contain  ${stdout}  64 bytes from 10.1.1.1

Test Ping to pmathy-dmp-app1-epg2
    ${stdout} =  Execute Command  ping 10.1.2.10 -c 3
    Should Contain  ${stdout}  64 bytes from 10.1.2.10

Test Ping to pmathy-dmp-app1-epg3
    ${stdout} =  Execute Command  ping 10.1.3.10 -c 3
    Should Contain  ${stdout}  64 bytes from 10.1.3.10