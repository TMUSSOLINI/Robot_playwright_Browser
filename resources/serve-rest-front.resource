*** Settings ***
Library    Browser
Library    FakerLibrary

*** Variables ***
${BROWSER}    chromium
${HEADLESS}   false
${SITE}       https://front.serverest.dev

*** Keywords ***
Abrir o navegador
    New Browser    browser=${BROWSER}
    ...            headless=${HEADLESS}

    New Context    viewport={"width": 1280, "height": 720}

Ir para o site Serve Rest Front
    New Page       url=${SITE}


Preencher os dados do novo usuário e cadastrar
    Click       css=.btn-link
    ${EMAIL}    FakerLibrary.Email
    Fill Text        css=input[data-testid='nome']        Thiago
    Fill Text        css=input[data-testid='email']       ${EMAIL}
    Fill Text        css=input[data-testid='password']    123456
    Check Checkbox   css=input[data-testid='checkbox']
    Click            css=button[data-testid='cadastrar']
    Sleep    5s
