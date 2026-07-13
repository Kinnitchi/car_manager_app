# 🚗 Gestor Veicular

Aplicativo Flutter para gestão completa de veículos: manutenções, abastecimentos, consumo médio, relatórios de gastos e lembretes de documentação — tudo offline, com dados armazenados localmente no dispositivo.

## ✨ Funcionalidades

### Veículos
- Cadastro de múltiplos veículos (marca, modelo, ano, cor, placa, quilometragem e foto)
- Validação de placa nos padrões antigo (`ABC1234`) e Mercosul (`ABC1D23`), com placa única por veículo
- Seletor de veículo ativo — todas as telas operam sobre o veículo selecionado

### Manutenções
- Histórico de manutenções por tipo (troca de óleo, filtro, alinhamento, balanceamento, pneus, velas, correia dentada, injeção, freios, bateria, revisão geral e outros)
- **Previsão da próxima manutenção** com base no último registro de cada tipo + intervalo sugerido em km
- Alerta por notificação quando uma manutenção prevista está atrasada
- Sincronização automática da quilometragem do veículo ao registrar uma manutenção

### Abastecimentos
- Registro por tipo de combustível (gasolina, etanol, diesel, GNV, flex)
- Preço por litro calculado automaticamente a partir de litros × valor total
- **Consumo médio (km/l) tecnicamente correto**: considera apenas intervalos entre abastecimentos de tanque cheio, somando os litros dos abastecimentos parciais intermediários
- Campos numéricos com máscara pt-BR em tempo real (padrão de apps bancários)

### Relatórios
- Visão mensal de gastos (combustível + manutenção)
- Tendência de consumo ao longo do tempo
- Gráficos de distribuição de despesas e evolução mensal (fl_chart)

### Lembretes
- Lembretes de documentação, seguro, licenciamento e outros
- Notificações locais agendadas por data (timezone América/São Paulo)

### UI/UX
- Tema claro e escuro (segue o sistema), design system próprio (cores, dimensões, sombras)
- Layout responsivo com largura máxima centralizada em telas grandes
- Efeitos shimmer para estados de carregamento e animações com flutter_animate

## 🏗️ Arquitetura

O projeto segue **Clean Architecture** com separação em três camadas:

```
lib/
├── core/                  # Infraestrutura compartilhada
│   ├── constants/         # Enums de domínio (tipos de manutenção, combustível, lembrete)
│   ├── errors/            # Failures tipados
│   ├── router/            # go_router com guarda de rotas e shell de navegação
│   ├── theme/             # Design system (cores, tema, dimensões, sombras)
│   └── utils/             # Result<T>, formatters pt-BR, validators, máscara numérica
├── data/                  # Camada de dados
│   ├── datasources/       # Inicialização do Isar
│   ├── models/            # Modelos Isar (@collection) + código gerado
│   └── repositories/      # Implementações dos repositórios
├── domain/                # Regras de negócio (sem dependência de Flutter/Isar)
│   ├── entities/          # Entidades puras
│   ├── repositories/      # Contratos (interfaces)
│   └── usecases/          # Casos de uso (previsão de manutenção, consumo médio, relatórios…)
├── presentation/          # Camada de apresentação
│   ├── providers/         # Providers Riverpod (repositórios, usecases, streams)
│   ├── screens/           # Telas (dashboard, veículos, manutenção, abastecimento, relatórios, ajustes)
│   └── widgets/           # Widgets reutilizáveis (cards, gráficos, shell de navegação)
└── services/              # Serviços de plataforma (notificações, imagens)
```

### Decisões técnicas

- **Erros como valores**: `Result<T>` (sealed class própria) substitui exceptions/`Either` do dartz — os repositórios nunca lançam, sempre retornam `Success` ou `Error` com `Failure` tipado.
- **Dados reativos**: os repositórios expõem `watch*()` (streams do Isar com `fireImmediately`), consumidos via `StreamProvider` — qualquer escrita no banco reflete em todas as telas automaticamente.
- **Veículo selecionado sincronizado**: o `selectedVehicleProvider` escuta o stream de veículos e atualiza (ou limpa) a instância selecionada quando o registro muda no banco.
- **Navegação defensiva**: o router valida os argumentos (`extra`) das rotas de formulário e redireciona para a lista correspondente se estiverem ausentes (ex.: após o Android recriar o processo em segundo plano).

## 🛠️ Stack

| Categoria | Pacote |
|---|---|
| Estado | `flutter_riverpod` |
| Navegação | `go_router` |
| Banco local | `isar_community` (fork mantido do Isar 3) |
| Gráficos | `fl_chart` |
| Notificações | `flutter_local_notifications` + `timezone` |
| Imagens | `image_picker` |
| Formatação | `intl` (pt_BR) |
| UI | `google_fonts`, `shimmer`, `flutter_animate` |

## 🚀 Como rodar

### Pré-requisitos
- Flutter SDK (Dart ^3.12.2)
- Android Studio / Xcode conforme a plataforma alvo

### Passos

```bash
# 1. Instale as dependências
flutter pub get

# 2. (Apenas se alterar os modelos Isar) regenere o código
dart run build_runner build --delete-conflicting-outputs

# 3. Rode o app
flutter run
```

### Verificações

```bash
flutter analyze   # análise estática
flutter test      # testes
```

## 📱 Fluxo do app

1. **Seletor de veículos** (tela inicial): cadastre ou escolha um veículo.
2. **Dashboard**: resumo do veículo, próxima manutenção prevista, consumo médio, gasto do mês e tendência de gastos dos últimos 6 meses.
3. **Abas** (Manutenção / Abastecimento / Relatórios / Ajustes): históricos, formulários e gráficos, sempre no contexto do veículo selecionado.
4. **Ajustes**: lembretes com notificação agendada (documentação, seguro, licenciamento).

## 📄 Licença

Projeto pessoal — sem licença definida.
