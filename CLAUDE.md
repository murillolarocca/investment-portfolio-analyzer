# Investment Portfolio Analyzer — instruções do projeto

## Dashboard real (dados pessoais)

O dashboard real da carteira é gerado em `examples/dashboard.html`. Ele contém dados financeiros pessoais e **nunca deve ser commitado ao repositório**.

- O arquivo já está no `.gitignore` — nunca remova essa entrada.
- Nunca faça `git add examples/dashboard.html`, mesmo que o git sugira.

### Publicação como Artifact

Sempre que o dashboard real for gerado ou atualizado, publique-o como um Artifact **atualizando a URL existente**:

```
url: "https://claude.ai/code/artifact/be754065-4d75-4188-8b4d-be1786bb6b79"
file_path: "examples/dashboard.html"
favicon: "📊"
```

Não crie um novo Artifact — sempre use o `url` acima para manter o mesmo link no celular do usuário.

Se por alguma razão o Artifact não puder ser atualizado via `url`, use `action: "list"` para encontrar o artifact existente pelo título "Carteira Ion & Avenue" antes de publicar.
