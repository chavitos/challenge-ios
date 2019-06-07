## a Lodjinha

**Versão mínima:** iOS 9</br>
**Linguagem:** Swift</br>

**Sobre:** O projeto foi feito utilizando [Clean Swift](http://clean-swift.com), para as funcionalidades a partir da Home, e view code para a tela Sobre. Para ser executado de forma correta, siga os passos descritos na seção [Pré-requisitos de compilação](#Pré-requisitos de compilação).
</br></br>
## Pré-requisitos de compilação

É necessário executar o comando `pod install` na pasta `/challenge-ios/LodjinhaSZ/` para o projeto conseguir rodar o build com sucesso.

Esse comando irá instalar as seguintes dependências:

* [Alamofire](https://github.com/Alamofire/Alamofire#installation) - Utilizado no network manager para as chamadas REST do app
* [Cartography](https://github.com/robb/Cartography) - Utilizado para as constrains dos elementos da tela Sobre
</br></br>

## Telas e funcinalidades

### 1 - Home
	
###### Premissas:
- A tela de Home deve ser acessada ao tocar a opção Home do Tab Bar, conforme protótipo.
- O tamanho total da tela de Home deve ser determinada pelo tamanho total de todos as views somadas; ou seja, não deverá haver sub-scroll vertical.
- Ao exibir qualquer Funcionalidade externa acessada pela Home, a Tab Bar não deve aparecer.

###### Funcionalidade 01
Exibir a barra de banners rotativo. Cada banner deve preencher todo o espaço horizontal da tela. Ao realizar o swipe left ou swipe right, o banner deve ser trocado pelo próximo ou anterior, conforme disponibilidade. Utilizar um indicador para facilitar ao usuário saber quantos banners existem e em qual posição ele está.

###### Funcionalidade 02
Exibir um menu deslizável horizotal com as categorias, conforme protótipo. O número de categorias é fixo, e não há necessidade de scroll infinito. Ao clicar em uma categoria, o app deve redirecionar o usuário para a Funcionalidade 04.

###### Funcionalidade 03
Exibir uma lista dos produtos mais vendidos. A lista possui um número fixo de produtos e não há necessidade de scroll infinito. Ao clicar em um produto, o usuário deve ser direcionado à Funcionalidade 05.

### 2 - Lista de produtos por categoria
	
###### Premissas:
- A Tab Bar não deve ser exibida.
- Ao voltar para Home, a Tab Bar deve voltar a ser exibida.
- Um indicador de loading deve ser exibido enquanto uma nova página estiver sendo carregada.
- O usuário não deve ficar com a rolagem e navegação travados enquanto uma nova página estiver sendo carregada.

###### Funcionalidade 04
Exibir uma lista dos produtos da categoria selecionada, conforme protótipo. O lista possui um número desconhecido de produtos, e deverá ser paginado, limitando a página em 20 registros. Ao tocar em um produto, o usuário deverá ser direcionado à Funcionalidade 05.

### 3 - Detalhe de produto

###### Premissas:
- A Tab Bar não deve ser exibida.
- Se exibida a partir da Home, ao voltar, a Tab Bar deve ser exibida novamente.
	
###### Funcionalidade 05
Exibir a descrição do produto conforme protótipo. O botão Reservar deve estar sempre visível, fixado na parte de baixo da tela. O texto de descrição poderá vir formatado como HTML. O app deve tratar esse texto e exibí-lo corretamente (negrito, itálico, etc).
	
###### Funcionalidade 06
Ao clicar no botão Reservar, o app deve efetuar a reserva do produto com o servidor. Exibir a mensagem de sucesso ou erro da reserva. O usuário não deve poder tocar outra vez no botão enquanto a primeira reserva não for concluída. Se a reserva for concluída com sucesso, após fechar a mensagem de sucesso, retornar para a tela que chamou a Exibição de Produto.

### 4 - Sobre
	
###### Premissas:
- A tela de Sobre deve ser acessada ao tocar a opção Home do Tab Bar, conforme protótipo.

###### Funcionalidade 07
Exibir o logo e o nome do app. Na parte de baixo da tela, exibir o nome do desenvolvedor (seu nome) e a data de desenvolvimento.
</br></br>
## Recursos auxiliares

[Protótipo Navegável](https://marvelapp.com/1db0728)

[Fontes](https://fonts.google.com/specimen/Pacifico)

[Documentação da API](https://alodjinha.herokuapp.com/swagger-ui.html)

