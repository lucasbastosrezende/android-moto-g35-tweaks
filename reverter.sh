#!/bin/sh
# Script de reversão das configurações aplicadas via ADB no Motorola Moto G35 5G
# Restaura os valores padrões de LMKD, Activity Manager, AppOps e reativa pacotes.

# Permite definir o caminho do adb via variável ADB_PATH ou usa 'adb' do sistema por padrão
if [ -z "$ADB_PATH" ]; then
  if command -v adb >/dev/null 2>&1; then
    A="adb"
  elif [ -f "/d/DevTools/AndroidSdk/platform-tools/adb.exe" ]; then
    A="/d/DevTools/AndroidSdk/platform-tools/adb.exe"
  else
    A="adb"
  fi
else
  A="$ADB_PATH"
fi

echo "[*] Utilizando ADB: $A"

echo "[*] Restaurando configurações do sistema (LMKD / Activity Manager)..."
$A shell 'device_config delete lmkd_native swap_free_low_percentage
device_config delete lmkd_native swap_util_max
device_config delete lmkd_native thrashing_limit
device_config delete activity_manager max_cached_processes
device_config delete activity_manager max_phantom_processes
device_config set_sync_disabled_for_tests none
settings delete global settings_enable_monitor_phantom_procs'

echo "[*] Reativando serviços e pacotes do sistema desativados..."
for p in com.facebook.services com.facebook.appmanager com.facebook.system com.dti.amx \
         com.google.android.projection.gearhead com.google.android.apps.wellbeing com.motorola.motocare \
         com.google.android.adservices.api com.google.android.as com.motorola.timeweatherwidget; do
  $A shell pm enable $p
done

echo "[*] Restaurando permissões de execução em segundo plano (RUN_ANY_IN_BACKGROUND)..."
for p in com.happymod.apk com.kryptex.miner net.ctpool com.kunpo88.baba2.say com.kunpo88.baba2.tay \
         apkshare.shareapps.filetransfer.shareit.bluetooth free.vpn.unblock.proxy.turbovpn com.urbanvpn.android \
         com.vpn.lat com.google.android.apps.chromecast.app com.facebook.katana com.instagram.barcelona \
         com.mercadopago.wallet com.openai.chatgpt org.telegram.messenger com.finguia; do
  $A shell cmd appops set $p RUN_ANY_IN_BACKGROUND default
done

echo "[✓] Processo de reversão concluído com sucesso!"
