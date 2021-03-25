*** Settings ***
Documentation      Robot Framework: test Tenant pmathy_demopipeline VRF RIBs
Library            Collections
Library            REST  %{TF_VAR_APICURL}  ssl_verify=false
Suite Setup        Get APIC Token

*** Variables ***
${auth_json}            {"aaaUser": {"attributes": { "name": "%{TF_VAR_APICUN}", "pwd" : "%{TF_VAR_APICPW}"}}}
@{routes_vrf_dmp_1}     10.1.1.0/24  10.1.2.0/24  10.1.3.0/24
@{routes_vrf_dmp_2}     10.1.1.0/24  10.1.3.0/24  20.20.20.0/24  30.30.30.0/24

*** Keywords ***
Get APIC Token
    ${res}=  POST  /api/aaaLogin.json  ${auth_json}
    Integer  response status  200
    ${cookie}=  Catenate  APIC-cookie\=${res['body']['imdata'][0]['aaaLogin']['attributes']['token']}
    [Teardown]  Set Suite Variable  ${cookie}  ${cookie}

*** Test Cases ***
Test VRF vrf_dmp_1 RIB on Leaf 1201
    Set Headers  {"Cookie": "${cookie}"}
    ${res}=  GET  /api/node/mo/topology/pod-2/node-1201/sys/uribv4/dom-pmathy_demopipeline:vrf_dmp_1/db-rt.json?query-target\=children
    @{input_list} =  Convert to List  ${res['body']['imdata']}
    @{route_list} =  Create List
    FOR  ${route}  IN  @{input_list}
        Append To List  ${route_list}  ${route}[uribv4Route][attributes][prefix]
    END
    FOR  ${route}  IN  @{routes_vrf_dmp_1}
        Should Contain Match  ${route_list}  ${route}
    END
    [Teardown]

Test VRF vrf_dmp_1 RIB on Leaf 1202
    Set Headers  {"Cookie": "${cookie}"}
    ${res}=  GET  /api/node/mo/topology/pod-2/node-1202/sys/uribv4/dom-pmathy_demopipeline:vrf_dmp_1/db-rt.json?query-target\=children
    @{input_list} =  Convert to List  ${res['body']['imdata']}
    @{route_list} =  Create List
    FOR  ${route}  IN  @{input_list}
        Append To List  ${route_list}  ${route}[uribv4Route][attributes][prefix]
    END
    FOR  ${route}  IN  @{routes_vrf_dmp_1}
        Should Contain Match  ${route_list}  ${route}
    END
    [Teardown]

Test VRF vrf_dmp_2 RIB on Leaf 1201
    Set Headers  {"Cookie": "${cookie}"}
    ${res}=  GET  /api/node/mo/topology/pod-2/node-1201/sys/uribv4/dom-pmathy_demopipeline:vrf_dmp_2/db-rt.json?query-target\=children
    @{input_list} =  Convert to List  ${res['body']['imdata']}
    @{route_list} =  Create List
    FOR  ${route}  IN  @{input_list}
        Append To List  ${route_list}  ${route}[uribv4Route][attributes][prefix]
    END
    FOR  ${route}  IN  @{routes_vrf_dmp_2}
        Should Contain Match  ${route_list}  ${route}
    END
    [Teardown]

Test VRF vrf_dmp_2 RIB on Leaf 1202
    Set Headers  {"Cookie": "${cookie}"}
    ${res}=  GET  /api/node/mo/topology/pod-2/node-1202/sys/uribv4/dom-pmathy_demopipeline:vrf_dmp_2/db-rt.json?query-target\=children
    @{input_list} =  Convert to List  ${res['body']['imdata']}
    @{route_list} =  Create List
    FOR  ${route}  IN  @{input_list}
        Append To List  ${route_list}  ${route}[uribv4Route][attributes][prefix]
    END
    FOR  ${route}  IN  @{routes_vrf_dmp_2}
        Should Contain Match  ${route_list}  ${route}
    END
    [Teardown]