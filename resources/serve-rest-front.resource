*** Settings ***
Library    Browser
# ...        timeout=5s
...        enable_presenter_mode=${True}
Library    FakerLibrary
Library    DateTime
Library    String

*** Variables ***
${BROWSER}    chromium
${HEADLESS}   false
${SITE}       https://front.serverest.dev

*** Keywords ***
Abrir o navegador
    New Browser    browser=${BROWSER}
    ...            headless=${HEADLESS}

    ${TRACE_NAME}  FakerLibrary.Uuid 4
    ${NOW}         Get Current Date    result_format=%d-%m-%Y_%H%M%S
    ${OUTPUT_DIR_NORM}    Replace String    ${OUTPUT_DIR}    \\    /

    New Context    viewport={"width": 1280, "height": 720}
    # ...            tracing=${OUTPUT_DIR_NORM}/evidencies/traces/${NOW}/${TRACE_NAME}.zip
    # ...            recordVideo={'dir': '${OUTPUT_DIR_NORM}/evidencies/videos/${NOW}'}

Ir para o site Serve Rest Front
    New Page       url=${SITE}
    ${title}       Get Title  ==  Front - ServeRest
    Log            ${title}



Preencher os dados do novo usuário e cadastrar
    Click            css=.btn-link
    ${EMAIL}         FakerLibrary.Email
    Set Test Variable    ${EMAIL_CADASTRADO}    ${EMAIL}
    Fill Text        css=input[data-testid='nome']        Thiago
    Fill Text        css=input[data-testid='email']       ${EMAIL}
    Fill Text        css=input[data-testid='password']    123456
    Check Checkbox   css=input[data-testid='checkbox']
    Click            css=button[data-testid='cadastrar']

Conferir usuário cadastrado com sucesso
    Get Text               h1  ==  Bem Vindo Thiago
    Get Element States     css=button[data-testid='logout']  validate  value & visible

Conferir usuário na lista de usuários
    Click      css=a[data-testid='listarUsuarios']
    ${elemento}  Get Table Cell Element    xpath=//*[@id="root"]/div/div/p/table    "Nome"    "${EMAIL_CADASTRADO}"
    ${nome}      Get Text     ${elemento}  ==  Thiago
    Log   ${nome}
    Take Screenshot
