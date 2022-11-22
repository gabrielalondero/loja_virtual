# Loja virtual usando Firebase
Aplicativo de Loja em Flutter.
 - Na sessão Início:
    - Mostra uma grade de imagens.
 - Na sessão Produtos:
    - Mostra uma lista de produtos por categoria,
       - Ao clicar na categoria, podemos ver os produtos em grade ou em lista.
       - Ao clicar no produto, podemos ver o carrossel de imagens dele, seus tamanhos disponíveis, descrição e preço.
          - Ao clicar em algum tamanho, o botão de 'Adicionar no carrinho' (ou 'Entre para comprar' caso não estiver logado) será habilitado.
          - Ao clicar em 'Adicionar ao carrinho' aparecera a página do carrinho onde:
             - Mostra os produtos, podendo aumentar a quantidade deles;
             - Pode adicionar um cupom de desconto disponível.
             - A parte do calcular frete não está funcionando, mas aparece no layout.
             - No fim, aparece todos os valores: subtotal, desconto, frete, e total.
             - Ao clicar em 'Finalizar Pedido' a lista de produtos no carrinho é limpada e podemos ver os produtos na sessão 'Meus pedidos' no drawer.
 - Na sessão Meus Pedidos:
    - Mostra os detalhes do pedido: Codigo, descrição com quantidade e valor unitário, e valor total.
    - Mostra o status do pedido em tempo real conforme for mudando do Firebase.
 - Na sessão Lojas: 
    - Mostra imagem, nome, e endereço das lojas, podemos clicar para ligar ou ver no Google Maps a localização.
 - Obs.:
    - O carrinho e os pedidos somente serão carregados se o usuário estiver logado.
    - Na tela de login, terá a opção de criar uma conta.
    - Método de login: email e senha.
    - Backend: Firebase.

 - Plugins:
    `flutter_staggered_grid_view` visialização em grade na tela inicial

    `cloud_firestore` acessar o banco de dados

    `carousel_slider` para poder arrastar as imagens para os lados

    `transparent_image`  carregamento de imagem mais suave

    `scoped_model` para fazer modificações no estado do app

    `firebase_auth` para fazer a autenticacao

    `url_launcher` para lançar` o telefone com o número da loja ou lançar o map com o local da loja
