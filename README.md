# preserv-VE
[Preservación digital](https://en.wikipedia.org/wiki/Digital_preservation) de las principales fuentes de la **base de datos AddressForAll-Venezuela**, mantenida por el [Instituto AddressForAll](http://addressforall.org/).

A Venezuela se le asignó: en el contexto ISO 3166‑2 el geocódigo **VE** y el número **862**; en Wikidata el identificador [Q717](http://wikidata.org/entity/Q717); en OpenStreetMap el identificador de [*relación* 272644](http://osm.org/relation/272644).


# Organización territorial
El territorio nacional y sus subdivisiones representam **jurisdiciones**:

* El país está dividido en **23 estados, Distrito Capital (Caracas) y Dependencias Federales (islas)**.

* Los estados y el Distrito Federal se subdividen en **335 municipios** con alcalde y concejo elegidos. <br/>Geocódigos numéricos Ubigeo.

* Los municipios son dividido en **1146 parroquias**. Las parroquias no tienen autonomía, sirven para elegir un concejal.

Los catastros urbanos se encuentran en los municipios.

La jurisdicción que asigna nombres a las calles y el sistema de numeración urbana es el municipio.

### Notas
* Las Dependencias Federales no tienen ni el estatus de Estado Federal ni tienen municipios. Son administradas directamente por el Ejecutivo Nacional.

* Una ciudad puede incluir partes de varias parroquias e incluso partes de otros municipios (por ejemplo, la ciudad de Barquisimeto).

* El Distrito Capital está formado por el municipio de Libertador con sede en la ciudad de Caracas.

* El nombre del municipio a menudo difiere del nombre de la ciudad en la que tiene su sede (capital municipal). Hay muchos casos de repetición de nombres de municipios en varios estados. Hay 11 municipios con el nombre de Sucre.

## Organización de este repositorio

En este *git*, **solo se guardan los metadatos**, es decir, descriptores de entidad, como nombres y códigos geográficos &mdash; mapas y otros datos brutos, almacenados externamente porque son muy grandes.  Posteriormente, los "datos en bruto", no estandarizados, se convierten en "datos filtrados" y se conservan en lo [*git* preservCutGeo‑VE2021](http://git.digital-guard.org/preservCutGeo-VE2021).

Los metadatos se organizaron de la siguiente manera, en la carpeta [`/data`](./data):

* [`/data`](./data): datos originales de **entrada**, es decir, metadatos proporcionados para el sistema.
   * `jurisdictionLevel*.csv`:  jurisdicciones (en todos los niveles) y sus geocódigos. La primera subdivisión es [jurisdictionLevel4.csv](./data/jurisdictionLevel4.csv).
   * [`donor.csv`](./data/donor.csv): donantes de paquetes de datos. Metadatos de las instituciones que brindan datos oficiales. (pendente)
   * [`donatedPack.csv`](./data/donatedPack.csv): descriptores de los archivos donados. (pendente)
   * *paquetes* (carpetas `_packXX`): *hash*  y otros descriptores de archivos almacenados externamente, así como `makefile` y otros descriptores de proceso para descomprimir estos archivos y llevarlos a la base de datos (PostregSQL)... 

* [`/data/out`](./data/out): resultados generados por el sistema (**salida**), es decir, metadatos creados a partir de los algoritmos y estadísticas aplicados a los datos de `_pack`.

## Licencia
[Licencia CC0](https://creativecommons.org/publicdomain/zero/1.0/deed.es).
