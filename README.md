# FIAP Test Flutter 🚀

Projeto base em Flutter estruturado segundo os princípios de **Clean Architecture**, preparado e configurado com suítes de **Testes Unitários**, **Testes de Widgets** e **Testes End-to-End (E2E) com Maestro**.

---

## 🏛️ Arquitetura do Projeto

O código-fonte está organizado em camadas desacopladas dentro de `lib/`:

- **Core (`lib/core/`)**: Exceções de domínio e utilitários globais (`ServerException`).
- **Domain (`lib/domain/`)**: Regras de negócio independentes de framework, entidades (`User`) e contratos de repositório (`UserRepository`).
- **Data (`lib/data/`)**: Implementações de acesso a dados, serialização (`UserModel`), fonte de dados remota (`UserRemoteDataSourceImpl` com `http.Client`) e repositório (`UserRepositoryImpl`).
- **Presentation (`lib/presentation/`)**: Componentes de interface visual (`LoginPage`, `DashboardPage`, `LoginForm`).

---

## 🧪 Testes Automatizados (Unitários e de Widgets)

O projeto utiliza `flutter_test` em conjunto com [mocktail](https://pub.dev/packages/mocktail) para mock de dependências sem necessidade de code-generation.

### Executar todos os testes unitários e de widgets:
```bash
flutter test
```

### Executar com relatório de cobertura (coverage):
```bash
flutter test --coverage
```

### Análise estática de código (lints):
```bash
flutter analyze
```

---

## 📱 Testes End-to-End (E2E) com Maestro

[Maestro](https://maestro.mobile.dev/) é um framework moderno e declarativo para automação de testes E2E em dispositivos móveis (Android e iOS).

Os fluxos do Maestro estão localizados no diretório `.maestro/`:
- `.maestro/login_success_flow.yaml`: Testa o fluxo de login com sucesso (`pos@fiap.com.br` / `123456`), validação de acesso ao Dashboard e posterior logout.
- `.maestro/login_failure_flow.yaml`: Testa a validação de formato de e-mail (sem `@`) e a exibição de erro para credenciais inválidas.

---

### 1. Pré-requisitos para rodar o Maestro localmente

1. **Maestro CLI instalado**:
   - No macOS ou Linux:
     ```bash
     curl -Ls "https://get.maestro.mobile.dev" | bash
     ```
   - Verifique se a instalação foi bem-sucedida:
     ```bash
     maestro --version
     ```

2. **Emulador ou Dispositivo Físico**:
   - **Android**: Emulador Android iniciado via Android Studio ou CLI (`emulator -avd <nome_do_avd>`) com `adb` configurado no PATH.
   - **iOS**: Simulador iOS aberto via comando `open -a Simulator`.

---

### 2. Passo a Passo para Executar os Testes E2E Localmente

#### Passo 1: Iniciar o emulador ou simulador
Certifique-se de que o emulador Android ou simulador iOS está aberto e visível:
```bash
# Para verificar dispositivos conectados:
adb devices          # Para Android
xcrun simctl list    # Para iOS
```

#### Passo 2: Compilar e instalar o app
No diretório raiz do projeto:

**Para Android:**
```bash
# Gera o APK em modo debug
flutter build apk --debug

# Instala o APK no emulador ativo
adb install build/app/outputs/flutter-apk/app-debug.apk
```

**Para iOS:**
```bash
# Executa o app no simulador para fazer o deploy inicial
flutter run -d iPhone
```

#### Passo 3: Executar os fluxos com o Maestro

Para executar o fluxo de **login com sucesso e logout**:
```bash
maestro test .maestro/login_success_flow.yaml
```

Para executar o fluxo de **validação de erros**:
```bash
maestro test .maestro/login_failure_flow.yaml
```

Para executar **todos os fluxos E2E da suíte**:
```bash
maestro test .maestro/
```

---

### 3. Maestro Studio (Inspeção Interativa)

O Maestro inclui uma ferramenta visual para inspecionar a hierarquia de componentes e elementos da tela em tempo real no navegador:

```bash
maestro studio
```
Essa interface abrirá automaticamente no seu navegador padrão e permite inspecionar seletores visuais, textos e IDs da tela do app.

---

## ⚙️ Pipeline de CI/CD (GitHub Actions)

A esteira automatizada está configurada em [`.github/workflows/e2e-maestro.yml`](.github/workflows/e2e-maestro.yml).

Ela é acionada a cada `push` ou `pull request` nas branches `main` e `master`:
1. **Configuração de Ambiente**: Instala Java 17, Flutter Stable e dependências do projeto.
2. **Qualidade & Validação**: Executa os testes unitários e de widgets (`flutter test`).
3. **Build Android**: Gera o APK debug (`flutter build apk --debug`).
4. **Instalação do Maestro**: Faz o download e configuração do binário do Maestro CLI no runner.
5. **Emulador Android**: Inicia um emulador Android com aceleração de hardware (HVF no macOS Runner), instala o APK e executa os fluxos E2E.
6. **Artefatos**: Em caso de falha, salva capturas de tela e relatórios do Maestro como artefatos da pipeline.
