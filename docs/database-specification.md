# Database Specificatie

Onderstaande tabel geeft een overzicht van de kern-tabellen binnen de Jamin-magazijn applicatie. Kolomnamen en datatypen zijn gebaseerd op de Laravel-migraties en de SQL-scripts in `database/createscripts/`.

| Tabel | Kolom | Type | Omschrijving |
|-------|-------|------|--------------|
| `Allergeen` | `Id` | INT (PK) | Unieke identifier voor het allergeen. |
|  | `Naam` | VARCHAR(50) | Naam van het allergeen. |
|  | `Omschrijving` | VARCHAR(255) | Beschrijving van het allergeen. |
| `Product` | `Id` | INT (PK) | Unieke identifier voor het product. |
|  | `Naam` | VARCHAR(100) | Productnaam. |
|  | `Barcode` | VARCHAR(13) | EAN-barcode van het product. |
| `Leverancier` | `Id` | INT (PK) | Unieke identifier voor de leverancier. |
|  | `Naam` | VARCHAR(100) | Bedrijfsnaam van de leverancier. |
|  | `Contactpersoon` | VARCHAR(100) | Naam van de contactpersoon. |
|  | `Leveranciernummer` | VARCHAR(20) | Extern leveranciersnummer. |
|  | `Mobiel` | VARCHAR(15) | Mobiel telefoonnummer. |
| `Magazijn` | `Id` | INT (PK) | Unieke identifier voor de magazijnvoorraadregel. |
|  | `ProductId` | INT (FK) | Verwijzing naar `Product.Id`. |
|  | `VerpakkingsEenheid` | DECIMAL(8,2) | Gewicht per verpakking (kg). |
|  | `AantalAanwezig` | INT (nullable) | Huidige voorraad; kan `NULL` zijn als onbekend. |
| `ProductPerAllergeen` | `Id` | INT (PK) | Unieke identifier voor de koppeling. |
|  | `ProductId` | INT (FK) | Verwijzing naar `Product.Id`. |
|  | `AllergeenId` | INT (FK) | Verwijzing naar `Allergeen.Id`. |
| `ProductPerLeverancier` | `Id` | INT (PK) | Unieke identifier voor de levering. |
|  | `LeverancierId` | INT (FK) | Verwijzing naar `Leverancier.Id`. |
|  | `ProductId` | INT (FK) | Verwijzing naar `Product.Id`. |
|  | `DatumLevering` | DATE | Datum waarop de levering plaatsvond. |
|  | `Aantal` | INT | Geleverde hoeveelheid. |
|  | `DatumEerstVolgendeLevering` | DATE (nullable) | Verwachte datum van de volgende levering. |

## Relaties

- Eén `Product` kan meerdere koppelingen hebben in `ProductPerAllergeen` en `ProductPerLeverancier`.
- `ProductPerAllergeen` legt een veel-op-veel relatie vast tussen `Product` en `Allergeen`.
- `ProductPerLeverancier` legt de leveringshistorie vast voor een combinatie van `Product` en `Leverancier`.
- `Magazijn` bevat de actuele voorraad per product.

> Tip: pas dit document aan wanneer migraties of stored procedures veranderen, zodat de documentatie synchroon blijft met de werkelijke database.
