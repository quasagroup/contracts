# QuasacoinToken.sol
смартконтракт токена QUA

  # Crowdsale.sol
смартконтракт preICO и ICO:
после создания нужно передать этому смартконтракту ownership смартконтракта токена QUA

# MultiSigWallet.sol
Стандартная реализация multisig кошелька
https://github.com/gnosis/MultiSigWallet

# locker.sol
смартконтракт, который будет ownership-контрактом для смартконтракта токена QUA и контролировать действия:
 - выпуск новых токенов QUA вне периода preICO&ICO
 - завершение выпуска токенов QUA
 - передача ownership над смартконтрактом токена QUA
 
 использование: создаётся смартконтракт, в который передаются адреса личных External Account собственников и адрес смартконтракта токена QUA. Далее, при наступлении необходимости действий из списка выше, любой из двух вызывает propose< somefunc > c параметрами, второй вызывает confirm< somefunc > c теми же параметрами. Если параметры совпадают и соблюдена последовательность propose->confirm, тогда во время исполнения confirm в смартконтракте токена QUA осуществляется вызов метода < somefunc > .

