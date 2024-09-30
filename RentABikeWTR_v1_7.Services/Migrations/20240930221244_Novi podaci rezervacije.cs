using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace RentABikeWTR_v1_7.Services.Migrations
{
    /// <inheritdoc />
    public partial class Novipodacirezervacije : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 1,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 10, 1, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 10, 1, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 2,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 10, 1, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 10, 1, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 1,
                column: "VrijemePoziva",
                value: new DateTime(2024, 10, 1, 13, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 2,
                column: "VrijemePoziva",
                value: new DateTime(2024, 10, 1, 12, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 1,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 10, 1, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 10, 1, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 2,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 10, 1, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 10, 1, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 3,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 10, 1, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 10, 1, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 4,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 10, 1, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 10, 1, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.InsertData(
                table: "Rezervacije",
                columns: new[] { "RezervacijaId", "BiciklID", "CijenaUsluge", "DatumIzdavanja", "KorisnikID", "KupacID", "Napomena", "StatusPlacanja", "TuristRutaID", "TuristickiVodicID", "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[,]
                {
                    { 5, 1, 10m, new DateTime(2024, 9, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 8, null, false, null, null, new DateTime(2024, 10, 1, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 10, 1, 18, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 6, 1, 30m, new DateTime(2024, 9, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), null, 8, null, false, 1, 4, new DateTime(2024, 10, 1, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 10, 1, 18, 0, 0, 0, DateTimeKind.Unspecified) }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 6);

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 1,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 9, 29, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 2,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 9, 29, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 1,
                column: "VrijemePoziva",
                value: new DateTime(2024, 9, 29, 13, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 2,
                column: "VrijemePoziva",
                value: new DateTime(2024, 9, 29, 12, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 1,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 9, 29, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 2,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 9, 29, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 3,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 9, 29, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 4,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 9, 29, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 18, 0, 0, 0, DateTimeKind.Unspecified) });
        }
    }
}
