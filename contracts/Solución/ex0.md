## Configuraciones basicas de protostar

Antes de empezar asegurese de tener instalado [Protostar](https://github.com/Nadai2010/Nadai-ERC721-Protostar-Cairo#instalaci%C3%B3n)

---

## Enviar Mensaje de L2 a L1

Use un contrato implementado previamente para acuñar tokens ERC20 en L1 desde L2. Se pasa un mensaje secreto con los mensajes; asegúrese de encontrarlo para acumular sus puntos.

- Llamar a la función [`ex_0_a`](https://github.com/Nadai2010/Nadai-Starknet-Edu-Bridge-L2-L1/blob/master/contracts/Evaluator.cairo#L121) of [*L2 Evaluator*](https://goerli.voyager.online/contract/0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99)
- Debe especificar una dirección L1 y una cantidad de ERC20 para acuñar
- El mensaje secreto se envía de L2 a L1 en esta etapa.
- Llame a [`mint`](https://github.com/Nadai2010/Nadai-Starknet-Edu-Bridge-L2-L1/blob/master/contracts/L1/DummyToken.sol#L37) de [*L1 DummyToken*](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395)
  - Debe demostrar que conoce el valor secreto en este paso
- Llame a [`i_have_tokens`](https://github.com/Nadai2010/Nadai-Starknet-Edu-Bridge-L2-L1/blob/master/contracts/L1/DummyToken.sol#L48) de [*L1 DummyToken*](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395)
  - Esta función verifica que hayas podido acuñar tokens ERC20 y luego enviará un mensaje a L2 para acreditar tus puntos
  - Esto se hace usando [`ex_0_b`](https://github.com/Nadai2010/Nadai-Starknet-Edu-Bridge-L2-L1/blob/master/contracts/Evaluator.cairo#L143) del evaluador L2

---

## Solución

El objetivo de este ejercicio es aprender a enviar Mensajes entre L2 y L1, con valores secretos y aprendiendo su funcionamiento.

Nota: si aún no lo ha hecho, asegúrese de instalar la extensión del navegador Argent X y crear una cuenta en Goerli para seguir el taller.

Primero iremos ha escribir en el contrato a través de la [página del evaluador en Voyager](https://goerli.voyager.online/contract/0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99#writeContract) y usaremos la opción `ex_0_a` en ella debermeos indicar una wallet de usuario de L1 en goerli por ejemplo Metamask, y cantidad a enviar de prueba, en este caso `15`. (En 18 decimales `15000000000000000000`). Recibiremos los valores secretos en el mensaje de la trx realizada, que tendremos que añadir en los siguientes pasos, en nuestro caso ha sdio `1095648115`. Vamos a ello y tener paciencia, ya que el medsaje deberá ser verficado en `L1` y puede tardar aproximadamente `30 min`.


![Graph](/contracts/Imagenes/ex0a.png)

* [Hash](https://goerli.voyager.online/tx/0x72cf1c5baaffa8bc070742e26047aac9cf650bf5c2f1d9077a6b31311ec4d5d)

---

Una vez esté la transacción verificada en L1 iremos a [*L1 DummyToken*](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395) a la función [mint](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395#writeContract#F5) y pondremos el valor secreto obtenido en la transacción, así como la cantidad de `amount`. Todos los demás valores darán errores e incorrectos valores de gas.

![Graph](/contracts/Imagenes/secretex0.png)
![Graph](/contracts/Imagenes/mint.png)

* [Hash](https://goerli.etherscan.io/tx/0x03f085b1416459cbc79ddffa81cdd34147a37f2d7ff27c8ab51d8a1fb743fb85)

---

Así luegos podemos llamar a la función [i_have_tokens](/contracts/L1/DummyToken.sol#L48) de [*L1 DummyToken*](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395#writeContract#F3) en la cual tendremos que añadir el `usuario de  L2` de Starknet utilizado y el `valor secreto` restandole `32`, ya que si nos fijamos en [Evaluator](/contracts/Evaluator.cairo#135) es el valor secreto + 32, en nuestro caso `1095648083`.


Con esto debería de ser suficiente para verficar que hayas podido acuñar tokens ERC20, luego enviará un mensaje a L2 para acreditar tus puntos. Esto se hace con la función de L2 evaluador [`ex_0_b`](https://github.com/Nadai2010/Nadai-Starknet-Edu-Bridge-L2-L1/blob/master/contracts/Evaluator.cairo#L143), una vez actives `i_have_tokens` y añadiendo los valores de tu wallet usada en `L2` y el `número secreto - 32` como vimos arriba, la cual acreditará automaticamente tus (2 ptos).

**Siempre revisar las tx y esperar a que se verfiquen en `L1`**


![Graph](/contracts/Imagenes/have.png)

* [Hash](https://goerli.etherscan.io/tx/0xa012e5235088e3c20456c3e737ff29ffa7b0aef926021276d86c094c1fac98ca)

---

## Verificación de ejercicio

Si todo salió según lo planeado, deberíamos poder verificar que nuestra billetera Argent X `0x03F878C94De81906ba1A016aB0E228D361753536681a776ddA29674FfeBB3CB0` si obtuvo 2 puntos en el contrato inteligente [Point Counter](https://goerli.voyager.online/contract/0x38ec18163a6923a96870f3d2b948a140df89d30120afdf90270b02c609f8a88).

También puede revisar de una forma mas entretenida sus resultados en la siguiente web 

* https://starknet-tutorials.vercel.app

![Graph](/contracts/Imagenes/puntosex.png)

