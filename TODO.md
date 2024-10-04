# TODO

- [x] Set up a Phoenix app
- [x] Set up a CI pipeline
- [x] Write a proper `README.md`
- [x] Config Ecto repo to use env `DATABASE_URL`
- [x] Set up a Accounts ctx and the User schema
- [ ] Set up a Cameras ctx and schemas Cam, Model, Brand
- [ ] Write a seeding script w/ 1K users w/ 50 cams each
  - At least 1 cam should be active
  - 4 brands: Intelbras, Hikvision, Giga, Vivotek
  - Seeding must be FAST!
- [ ] Endpoint `GET /cameras` to list users and their cameras
  - User objs with their name and active cameras
  - Support filters and ordering over cam names
- [ ] Endpoint `POST /notify-users` to notify users thru email
- [ ] Set up a release CD pipeline

## Notes

A tarefa 1 contém uma nota problemática:

> _"Alguns usuários podem ter sido desligados (a funcionalidade de desligamento deve ser considerada fora do escopo deste exercício), então só nesse caso é possível que todas as câmeras pertencentes a um usuário estejam inativas. Nestes casos, o endpoint deve retornar a data em que o usuário foi desligado."_

Chamo-a de "problemática" pois o endpoint `/cameras` parece ser um endpoint de repositório que lista itens presentes em um conjunto (no caso, uma tabela de banco de dados). Dado que um usuário fora desligado, e o endpoint deveria listar apenas usuários ativos, como que eu "devo retornar a data em que o usuário foi desligado"?
