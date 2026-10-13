# Android / Moto G35 5G - Tweaks & Rollback Scripts

Repositório contendo scripts utilitários via ADB e registros de configurações originais para otimização de memória RAM (LMKD), limites de processos em segundo plano (`activity_manager`), gerenciamento de AppOps e bloatwares no **Motorola Moto G35 5G** (Android 14+).

---

## 📁 Estrutura do Repositório

- `reverter.sh`: Script Shell para reverter todas as alterações de LMKD, AppOps e reativar serviços e aplicativos do sistema.
- `backup_config_original.txt`: Registro das configurações de fábrica/originais antes das modificações, servindo como histórico de auditoria e referência.

---

## ⚙️ Pré-requisitos

1. **Android Debug Bridge (ADB)** instalado no sistema e configurado no `$PATH`.
2. **Depuração USB ativada** nas opções de desenvolvedor do smartphone.
3. Dispositivo conectado e reconhecido (`adb devices`).

---

## 🚀 Como Executar

### Executar script de reversão (`reverter.sh`):

No terminal Bash (Linux, macOS ou Git Bash no Windows):

```bash
chmod +x reverter.sh
./reverter.sh
```

Caso o seu binário do ADB esteja em um caminho customizado, você pode definir a variável `ADB_PATH`:

```bash
ADB_PATH="/caminho/para/adb" ./reverter.sh
```

---

## 🛡️ O que o script restaura:

- **Configurações LMKD (Low Memory Killer Daemon):**
  - Remove overrides de `swap_free_low_percentage`, `swap_util_max` e `thrashing_limit`.
- **Activity Manager:**
  - Remove restrições forçadas de `max_cached_processes` e `max_phantom_processes`.
  - Restaura monitoramento de processos fantasmas (`settings_enable_monitor_phantom_procs`).
- **Pacotes do Sistema (Desbloqueio):**
  - Reativa serviços de telemetria/bloatwares desativados (Facebook Services/AppManager, Motorola MotoCare, Google Wellbeing, etc.).
- **AppOps (Permissões de Segundo Plano):**
  - Restaura a permissão padrão (`RUN_ANY_IN_BACKGROUND default`) para aplicativos afetados.

---

## ⚠️ Isenção de Responsabilidade

Estes scripts e anotações foram desenvolvidos para testes de desempenho no Moto G35 5G. Utilize por sua conta e risco. Sempre faça backup de suas configurações antes de aplicar modificações via `adb shell device_config` ou `settings`.
