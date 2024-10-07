# TODO

- [x] Set up a Phoenix app
- [x] Set up a CI pipeline
- [x] Write a proper `README.md`
- [x] Config Ecto repo to use env `DATABASE_URL`
- [x] Set up a Accounts ctx and the User schema
- [x] Set up a Cameras ctx and the schema Camera
- [x] Write a seeding script w/ 1K users w/ 50 cams each
  - At least 1 cam should be active
  - 4 brands: Intelbras, Hikvision, Giga, Vivotek
  - Seeding must be FAST!
- [x] Endpoint `GET /cameras` to list users and their cameras
  - User objs with their name and active cameras
  - Support filters and ordering over cam names
- [ ] Endpoint `POST /notify-users` to notify users thru email
  - [x] Set up Oban
  - [x] Impl an Oban job to notify users (w/ tests)
  - [x] Impl `Accounts.notify_users/1` (w/ tests)
  - [ ] Impl controller/action for `POST /notify-users` (w/ tests)
- [ ] Set up a release CD pipeline

## Notes

### \1. Usuários "desligados" devem ou não devem aparecer na listagem de usuários?

A tarefa 1 contém uma nota problemática:

> _"Alguns usuários podem ter sido desligados (a funcionalidade de desligamento deve ser considerada fora do escopo deste exercício), então só nesse caso é possível que todas as câmeras pertencentes a um usuário estejam inativas. Nestes casos, o endpoint deve retornar a data em que o usuário foi desligado."_

Chamo-a de "problemática" pois o endpoint `/cameras` parece ser um endpoint de repositório que lista itens presentes em um conjunto (no caso, uma tabela de banco de dados). Dado que um usuário fora desligado, e o endpoint deveria listar apenas usuários ativos, como que eu "devo retornar a data em que o usuário foi desligado"?

### \#2. Endpoint `/cameras` listando usuários e ordenando por... nomes das câmeras?

Ainda sobre a tarefa 1, temos:

> _"Este endpoint deve suportar filtragem por parte do nome da câmera e ordenação pelo nome da camera."_

Não me parece fazer muito sentido, visto que a própria descrição da tarefa aponta para uma listagem de usuários com suas câmeras:

> _"Implementar um endpoint para fornecer uma lista de usuários e suas câmeras."_

Ora, como podemos fazer uma ordenação por nome de câmera se os principais objetos em listagem são usuários?

Bom, visto que houve uma certa confusão aqui (erro de definição de escopo, ou mesmo uma má interpretação de texto por minha parte), irei implementar ordenação por nome de usuário ao invés de nome da câmera - apenas para ilustrar melhor minha solução do teste técnico.
