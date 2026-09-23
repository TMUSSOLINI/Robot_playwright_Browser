*** Settings ***
Library    Browser

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
    Click    css=.btn-link
    Sleep    5s
