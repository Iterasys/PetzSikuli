*** Settings ***
Documentation    Fluxo de compra no site da Petz

Library          SikuliLibrary

Suite Setup      Add Image Path      ${EXECDIR}//resources//images
Suite Teardown   Esquecer e Encerrar

*** Test Cases ***
Compra
    [Tags]    SMOKE
    Dado que acesso o site da Petz
    Quando pesquiso o produto "pote"
    # Entao visualizo o produto
    Quando seleciono o produto
    E adiciono duas unidades ao carrinho
    # Entao visualizo o produto e o total no carrinho

*** Keywords ***
Dado que acesso o site da Petz
    Click               icone_do_chrome.png
    Click               modo_visitante.png
    Input Text          barra_de_endereco.png       https://www.petz.com.br
    Press Special Key   ENTER

Quando pesquiso o produto "${produto}"
    Set Test Variable   ${produto}
    Click               btn_ok.png
    Input Text          pesquisar_na_petz.png       ${produto}
    Click               lupa.png

Entao visualizo o produto
    # Screen Should Contain       pote_rosa2.png
    Wait For Image                pote_rosa.png     20

Quando seleciono o produto
    Click                       pote_rosa2.png

E adiciono duas unidades ao carrinho
    Click                       adicionar_segunda_unidade.png
    Screen Should Contain       quantidade_2.png
    Click                       adicionar_ao_carrinho.png

Entao visualizo o produto e o total no carrinho
    Screen Should Contain       produto_carrinho.png
    Screen Should Contain       preco_unitario.png
    Screen Should Contain       quantidade_produto.png
    Screen Should Contain       total.png

Esquecer e Encerrar
    Click                       excluir_item_carrinho.png
    Click                       btn_sim.png
    Click                       btn_fechar.png
    Stop Remote Server