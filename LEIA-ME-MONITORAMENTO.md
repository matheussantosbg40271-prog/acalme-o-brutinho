# Acalme o Brutinho! — versão com monitoramento

Este pacote contém o jogo, rastreamento anônimo de visitas/telas/partidas, API Python na Vercel, painel privado e SQL do banco.

## O que registra
- Visualização da página e origem resumida (somente a origem do site, não o endereço completo).
- Telas abertas dentro do jogo.
- Minijogo iniciado e duração aproximada quando o jogador sai do minijogo/tela ou fecha a página.
- Resumo por dia, minijogo e tela no painel privado.

Não coleta nick do jogo, e-mail, nome real, IP pelo código de analytics ou conteúdo do perfil. O ID de visitante é aleatório e fica no navegador. Visitantes únicos no painel são somados por dia, não deduplicados no mês. Se a pessoa fechar o navegador sem que o evento seja enviado, a duração pode não ser registrada.

## Importante
Os arquivos estão preparados, mas **não é possível registrar eventos até você configurar seu projeto Supabase e as variáveis da Vercel**. Não publique a service role key no HTML, no GitHub ou em mensagem.

## Configuração (tudo tem opção gratuita; sujeito aos limites atuais dos serviços)
1. Crie um projeto Supabase em https://supabase.com/.
2. No SQL Editor do Supabase, execute o conteúdo de `schema.sql`.
3. Em Project Settings / API (ou Connect), copie a URL do projeto e a chave `service_role`/secret. Guarde-a só no servidor.
4. Envie esta pasta como projeto para a Vercel: https://vercel.com/new. O `Acalme_o_Brutinho.html` está na raiz; renomeie para `index.html` antes de publicar (ou mantenha uma cópia com esse nome).
5. Em Project Settings → Environment Variables, adicione:
   - `SUPABASE_URL` = URL do seu projeto Supabase
   - `SUPABASE_SERVICE_ROLE_KEY` = chave secreta do servidor (NUNCA no navegador)
   - `ANALYTICS_ADMIN_TOKEN` = uma senha longa e aleatória para proteger o painel
6. Faça redeploy depois de salvar as variáveis.
7. Abra `/admin/` no endereço Vercel do jogo e informe `ANALYTICS_ADMIN_TOKEN` para consultar as métricas.
8. Teste abrindo o jogo, navegando entre telas e iniciando/saindo de um minijogo. Os dados aparecem após alguns segundos.

## Migrar a partir da Netlify
- A publicação na Vercel terá inicialmente um endereço novo `*.vercel.app`. Não apague o site da Netlify até testar tudo.
- Para manter um domínio próprio, adicione-o à Vercel quando estiver pronto. O endereço antigo `acalmeobrutinho.netlify.app` não pode ser transferido como se fosse seu domínio próprio.
- O jogo continua salvando o progresso do jogador no localStorage do navegador. Este monitoramento não migra nem sincroniza o progresso salvo.

## Observações
- A API aceita apenas uma lista curta de eventos e limita o tamanho do payload.
- O painel lê os últimos 5.000 eventos dos últimos 30 dias. Para tráfego alto, use consultas agregadas no banco.
- O monitoramento é agregado e não deve ser usado para identificar pessoas. Inclua um aviso de privacidade no jogo antes de divulgar amplamente.
