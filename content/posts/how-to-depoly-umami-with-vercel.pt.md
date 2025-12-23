---
title: Implante o Umami Facilmente para Estatísticas de Tráfego do Site na Vercel
date: 2025-06-15
tags: [Umami, Vercel, Neon, Estatísticas de Tráfego do Site, Open Source, Hugo, Análise Web, Análise de Dados, Rastreamento de Visitantes, Alternativa ao Google Analytics, PostgreSQL, Implantação Sem Custo]
categories: [Tutorial Técnico]
keywords: [guia de implantação Umami, hospedagem gratuita Vercel, banco de dados Neon, análise web, alternativa ao Google Analytics, análise de código aberto, estatísticas blog Hugo, configuração sem custo, rastreamento visitantes site, proteção privacidade dados]
description: Este guia completo mostra como aproveitar os serviços gratuitos da Vercel e o banco de dados PostgreSQL Neon para configurar rapidamente um sistema de análise web focado na privacidade usando o Umami. Esta solução sem custo é perfeita para blogs pessoais e sites pequenos e médios, oferecendo uma alternativa mais leve e consciente da privacidade ao Google Analytics. Através da arquitetura Serverless da Vercel, você pode implementar facilmente o monitoramento de tráfego do site que é totalmente compatível com Hugo e outros sites estáticos.
---

Umami é uma ferramenta de estatísticas de sites de código aberto, simples, rápida e focada na privacidade, tornando-a uma alternativa ideal ao Google Analytics. Este artigo irá guiá-lo sobre como implantar o Umami na Vercel e criar um banco de dados PostgreSQL Neon através do Vercel Storage, para construir um sistema de estatísticas de tráfego de site leve e sem custo. Este tutorial é especificamente otimizado para usuários de sites estáticos Hugo, garantindo que os arquivos Markdown gerados sejam compatíveis com a geração de sites estáticos do Hugo.

## Introdução

Para blogs pessoais ou sites pequenos e médios, o Google Analytics pode ser muito complexo e inconveniente de acessar em certas regiões. O Umami oferece uma interface limpa com métricas centrais, tornando-o adequado para necessidades de análise de tráfego leve. Com a implantação serverless da Vercel e o banco de dados Neon integrado através do Vercel Storage, podemos configurar rapidamente um sistema de estatísticas eficiente sem custos de manutenção do servidor.

Aqui estão os passos detalhados de implantação.

## Preparativos

Antes de começar, certifique-se de ter o seguinte:

1. **Conta GitHub**: Para fazer fork do repositório Umami.
2. **Conta Vercel**: Para implantar o Umami e criar o banco de dados Neon.
3. **Conta Neon**: Registrada, para conectar através do Vercel Storage.
4. Um site Hugo em execução (ou outro site estático) para incorporar o código de rastreamento do Umami.

## Passo 1: Fazer Fork do Repositório Umami

1. Visite o repositório GitHub oficial do Umami: [https://github.com/umami-software/umami](https://github.com/umami-software/umami).
2. Clique no botão **Fork** no canto superior direito para fazer fork do repositório em sua conta GitHub.
3. (Opcional) Se você precisar personalizar o Umami, pode clonar o repositório localmente para modificações, mas este tutorial usa a configuração padrão.

## Passo 2: Implantar Umami na Vercel

1. Faça login no [site da Vercel](https://vercel.com/), clique em **Add New** > **Project**.
2. Na página **Import Git Repository**, selecione o repositório Umami que você acabou de fazer fork.
3. Configure o projeto:
   - **Framework Preset**: Escolha **Next.js** (Umami é construído sobre Next.js).
   - **Environment Variables**: Pule por enquanto; você configurará o `DATABASE_URL` para o banco de dados Neon mais tarde.
4. Clique no botão **Deploy**, e a Vercel construirá automaticamente o projeto (pode falhar inicialmente devido à falta de uma conexão de banco de dados, o que será corrigido mais tarde).

## Passo 3: Criar Banco de Dados Neon no Vercel Storage

1. No painel da Vercel, vá para o seu projeto Umami.
2. Clique na aba **Storage** na navegação superior, depois selecione **Create Database**.
![](https://img.music-poster.art/2025/06/cba773362305001171fb5d0defb4f960.png)
3. Selecione **Neon** em Database Type e faça login na sua conta Neon para autorizar o acesso da Vercel.
4. Configure o banco de dados:
   - **Project Name**: Qualquer nome, por exemplo, `umami-project`.
   - **Database Name**: Recomenda-se usar `umami`.
   - **Cloud Service Provider**: Escolha sua região (por exemplo, região da Ásia da AWS) para reduzir a latência.
5. Ao criar, a Vercel gerará automaticamente um **DATABASE_URL** e o adicionará às variáveis de ambiente do projeto no seguinte formato:
   ```
   postgresql://[username]:[password]@[host]/[database]
   ```
6. Volte às configurações do projeto para confirmar que `DATABASE_URL` está incluído nas **Environment Variables**.
7. Reimplante o projeto: Clique na aba **Deployments**, selecione a implantação mais recente e clique em **Redeploy**.

## Passo 4: Configurar Umami

1. Uma vez implantado, clique em **Visit** para visualizar sua instância Umami e anote o nome de domínio padrão atribuído (por exemplo, `seu-projeto.vercel.app`).
2. Visite o site Umami, e as credenciais de login padrão para a primeira vez são:
   - Nome de usuário: `admin`
   - Senha: `umami`
3. Altere a senha imediatamente após fazer login por segurança.
4. No painel Umami, clique em **Add Website**, e insira as informações do seu site (por exemplo, domínio, nome).
![](https://img.music-poster.art/2025/06/2b0b37c13001ea761ffcd370f170defc.png)
5. O Umami gerará um código de rastreamento JavaScript no seguinte formato:
   ```html
   <script async src="https://seu-projeto.vercel.app/umami.js" data-website-id="SEU_WEBSITE_ID"></script>
   ```
   Copie este código.

## Passo 5: Incorporar Código de Rastreamento no Site Hugo

Para permitir que o Umami rastreie o tráfego do seu site Hugo, você precisa incorporar o código de rastreamento no seu site. Isso geralmente requer que o tema Hugo que você está usando suporte isso; se não, você precisará modificar o tema Hugo você mesmo.

Aqui, estou usando o tema [hugo-narrow](https://github.com/luizdepra/hugo-narrow), que suporta a configuração do Umami. Portanto, você pode configurá-lo no arquivo `hugo.yaml`:
```yaml
  analytics:
    enabled: true
    umami:
      enabled: true
      id: "SEU_WEBSITE_ID"
      src: "https://seu-projeto.vercel.app/umami.js"
      domains: ""
```
Substitua `SEU_WEBSITE_ID` pelo ID do site que você criou no Umami. O `src` também precisa ser atualizado para o domínio do seu projeto Umami implantado na Vercel.

Em seguida, visite seu site, e o Umami começará a coletar dados de tráfego.

## Passo 6: Validação e Otimização

1. Volte ao painel Umami e espere alguns minutos para verificar se algum dado de tráfego foi registrado.
2. Verifique se o código de rastreamento está funcionando corretamente:
   - Abra as Ferramentas de Desenvolvedor do navegador (F12), mude para a aba **Network**, atualize a página e confirme se há uma solicitação para `seu-projeto.vercel.app/api/collect`.
3. (Opcional) Personalize o painel Umami:
   - Adicione vários sites para rastreamento.
   - Configure links de compartilhamento de dados para compartilhar facilmente estatísticas com sua equipe.
   - Ajuste o tema ou as configurações de idioma do Umami para suportar uma interface em português.

## Notas

- **Plano Gratuito Neon**: O banco de dados Neon criado através do Vercel Storage tem limites em armazenamento e tempo de computação, adequado para sites pequenos. Se o tráfego for alto, considere atualizar para um plano pago.
- **Plano Gratuito Vercel**: O plano gratuito da Vercel oferece 100GB de largura de banda por mês, suficiente para a maioria das necessidades de sites pessoais.
- **Conformidade de Privacidade**: O Umami foca na privacidade, mas certifique-se de que seu site esteja em conformidade com GDPR ou outras regulamentações de privacidade (como operar em regiões como a UE).
- **Segurança**: Faça backups regulares do seu banco de dados Neon e certifique-se de que a conta de administrador do Umami use uma senha forte.

## Conclusão

Com a Vercel e seu banco de dados Neon integrado, você pode configurar um poderoso sistema de estatísticas de tráfego do site sem custo em apenas minutos. A interface limpa e os recursos centrais do Umami são perfeitos para usuários de blogs Hugo, atendendo às necessidades de rastreamento de visitas, análise de fontes e monitoramento de desempenho de páginas.

Se você tiver alguma dúvida ou precisar de mais otimizações, sinta-se à vontade para discutir nos comentários. Espero que este tutorial ajude você a entender melhor o tráfego do seu site.

## Referências

- Documentação Oficial do Umami: [https://umami.is/docs](https://umami.is/docs)
- Documentação do Vercel Storage: [https://vercel.com/docs/storage](https://vercel.com/docs/storage)
- Guia de Configuração do Banco de Dados Neon: [https://neon.tech/docs](https://neon.tech/docs)
- Documentação do Hugo: [https://gohugo.io/documentation/](https://gohugo.io/documentation/)
