## Configuraciones basicas de protostar

Si quiere usar [Protostar](https://github.com/Nadai2010/Nadai-ERC721-Protostar-Cairo#instalaci%C3%B3n), siga esta repo para configurarla, sino evite este punto.

## Enviar Mensaje de L2 a L1

Use un contrato implementado previamente para acuñar tokens ERC20 en L1 desde L2. Se pasa un mensaje secreto con los mensajes; asegúrese de encontrarlo para acumular sus puntos.

- Llamar a la función [`ex_0_a`](contracts/Evaluator.cairo#L121) of [*L2 Evaluator*](https://goerli.voyager.online/contract/0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99)
- Debe especificar una dirección L1 y una cantidad de ERC20 para acuñar
- El mensaje secreto se envía de L2 a L1 en esta etapa.
- Llame a [`mint`](contracts/L1/DummyToken.sol#L37) de [*L1 DummyToken*](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395)
  - Debe demostrar que conoce el valor secreto en este paso
- Llame a [`i_have_tokens`](contracts/L1/DummyToken.sol#L48) de [*L1 DummyToken*](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395)
  - Esta función verifica que hayas podido acuñar tokens ERC20 y luego enviará un mensaje a L2 para acreditar tus puntos
  - Esto se hace usando [`ex_0_b`](contracts/Evaluator.cairo#L143) del evaluador L2


## Solución

El objetivo de este ejercicio es aprender a enviar Mensajes entre L2 y L1, con valores secretos y aprendiendo su funcionamiento.

Nota: si aún no lo ha hecho, asegúrese de instalar la extensión del navegador Argent X y crear una cuenta en Goerli para seguir el taller.

Primero iremos ha escribir en el contrato a través de la [página del evaluador en Voyager](https://goerli.voyager.online/contract/0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99#writeContract) y nos asignaremos un rango, usando la opción `ex_0_a` en ella debermeos indicar una wallet de usuario de L1 en goerli por ejemplo Metamask, y cantidad a enviar de prueba. Recibiremos los valores secretos en el mensaje de la trx realizada, que tendremos que añadir en los siguientes pasos. Vamos a ello.


![Graph](/contracts/Imagenes/ex0a.png)

* [Hash]()


Una vez esté la transacción verificada en L1 iremos a [*L1 DummyToken*](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395) a la función `mint` y pondremos el valor obtenido de la transacción, así como la cantidad de `amount`. Todos los demás valores darán incorrectos valores de gas.

![Graph](/contracts/Imagenes/sms.png)
![Graph](/contracts/Imagenes/mint.png)

* [Hash]()

Ahora podemos llamara a la función `i_have_tokens` de [*L1 DummyToken*](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395) en cual tendremos que añadir el `usario de L2` de Starknet utilizado y el `valor secreto`

![Graph](/contracts/Imagenes/have.png)

* [Hash]()

Con esto deberia de ser suficiente para verficar que hayas podido acuñar tokens ERC20, luego enviará un mensaje a L2 para acreditar tus puntos.

  - Esto se hace usando [`ex_0_b`](contracts/Evaluator.cairo#L143) del evaluador L2

## Verificación de ejercio

Ahora estamos listos para enviar nuestro contrato inteligente ERC721 [Deploy ERC20ex02](https://goerli.voyager.online/contract/0x022bb88e1219fddbca1cc9ac3927798e7af0268bbb439733d9a72a47557b7cd1) al [Evaluador](https://goerli.voyager.online/contract/0x14ece8a1dcdcc5a56f01a987046f2bd8ddfb56bc358da050864ae6da5f71394) usando la función de `submit_erc20_solution`. Enviamos así nuestro contrato inteligente ERC20 al Evaluador.

![Graph](/contracts/Imagenes/submiterc20ex02.png)

* [Hash](https://goerli.voyager.online/tx/0x54c10d6e85ace788daa130b5e452fdad2f3d5de09f95e0c30bb4109b727893d)


Si todo salió según lo planeado, deberíamos poder verificar que nuestra billetera Argent X `0x05B23d29C5b33a1cf0c4e50F798f9E22c7254913368996436682852EfCF69f86` si obtuvo 6 puntos en el contrato inteligente [Point Counter](https://goerli.voyager.online/contract/0x228c0e6db14052a66901df14a9e8493c0711fa571860d9c62b6952997aae58b).

![Graph](/contracts/Imagenes/balanceofex01.png)

También puede revisar de una forma mas entretenida sus resultados en la siguiente web 

* https://starknet-tutorials.vercel.app

![Graph](/contracts/Imagenes/puntosex01.png)

