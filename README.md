# base.sol
базовые структуры и интерфейсы

# QuasacoinToken.sol
смартконтракт токена QUA

# MultiSigWallet.sol
Стандартная реализация multisig кошелька
https://github.com/gnosis/MultiSigWallet

# locker.sol
смартконтракт, который будет ownership-контрактом для смартконтракта токена QUA и контролировать:
 - выпуск новых токенов QUA вне периода preICO&ICO
 - завершение выпуска токенов QUA
 - передача ownership над смартконтрактом токена QUA

