using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RentABikeWTR_v1_7.Services.Migrations
{
    /// <inheritdoc />
    public partial class ServisiranjeDijelovinovatabela : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_RezervniDijelovi_Servisiranja",
                table: "RezervniDijelovi");

            migrationBuilder.DropIndex(
                name: "IX_RezervniDijelovi_ServisiranjeID",
                table: "RezervniDijelovi");

            migrationBuilder.DropColumn(
                name: "ServisiranjeID",
                table: "RezervniDijelovi");

            migrationBuilder.RenameColumn(
                name: "SerijskiBroj",
                table: "RezervniDijelovi",
                newName: "SifraArtikla");

            migrationBuilder.AlterColumn<int>(
                name: "NaStanju",
                table: "RezervniDijelovi",
                type: "int",
                nullable: false,
                oldClrType: typeof(bool),
                oldType: "bit");

            migrationBuilder.CreateTable(
                name: "ServisiranjaDijelovi",
                columns: table => new
                {
                    ServisiranjaDijeloviId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RezervniDijeloviID = table.Column<int>(type: "int", nullable: true),
                    ServisiranjeID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ServisiranjaDijelovi", x => x.ServisiranjaDijeloviId);
                    table.ForeignKey(
                        name: "FK_ServisiranjaDijelovi_RezervniDijelovi",
                        column: x => x.RezervniDijeloviID,
                        principalTable: "RezervniDijelovi",
                        principalColumn: "RezervniDijeloviId");
                    table.ForeignKey(
                        name: "FK_ServisiranjaDijelovi_Servisiranja",
                        column: x => x.ServisiranjeID,
                        principalTable: "Servisiranja",
                        principalColumn: "ServisiranjeId");
                });

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 1,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 7, 14, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 7, 14, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 2,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 7, 14, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 7, 14, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 1,
                column: "VrijemePoziva",
                value: new DateTime(2024, 7, 14, 13, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 2,
                column: "VrijemePoziva",
                value: new DateTime(2024, 7, 14, 12, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 1,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 7, 14, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 7, 14, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 2,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 7, 14, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 7, 14, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 3,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 7, 14, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 7, 14, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 4,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 7, 14, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 7, 14, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 1,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 2,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 3,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 4,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 5,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 6,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 7,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 8,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 9,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 10,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 11,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 12,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 13,
                column: "NaStanju",
                value: 1);

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 14,
                column: "NaStanju",
                value: 1);

            migrationBuilder.CreateIndex(
                name: "IX_ServisiranjaDijelovi_RezervniDijeloviID",
                table: "ServisiranjaDijelovi",
                column: "RezervniDijeloviID");

            migrationBuilder.CreateIndex(
                name: "IX_ServisiranjaDijelovi_ServisiranjeID",
                table: "ServisiranjaDijelovi",
                column: "ServisiranjeID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ServisiranjaDijelovi");

            migrationBuilder.RenameColumn(
                name: "SifraArtikla",
                table: "RezervniDijelovi",
                newName: "SerijskiBroj");

            migrationBuilder.AlterColumn<bool>(
                name: "NaStanju",
                table: "RezervniDijelovi",
                type: "bit",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<int>(
                name: "ServisiranjeID",
                table: "RezervniDijelovi",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 1,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 5, 9, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 5, 9, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 2,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 5, 9, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 5, 9, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 1,
                column: "VrijemePoziva",
                value: new DateTime(2024, 5, 9, 13, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 2,
                column: "VrijemePoziva",
                value: new DateTime(2024, 5, 9, 12, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 1,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 5, 9, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 9, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 2,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 5, 9, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 9, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 3,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 5, 9, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 9, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 4,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 5, 9, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 9, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 1,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 2,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 3,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 4,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 5,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 6,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 7,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 8,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 9,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 10,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 11,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 12,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 13,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.UpdateData(
                table: "RezervniDijelovi",
                keyColumn: "RezervniDijeloviId",
                keyValue: 14,
                columns: new[] { "NaStanju", "ServisiranjeID" },
                values: new object[] { true, null });

            migrationBuilder.CreateIndex(
                name: "IX_RezervniDijelovi_ServisiranjeID",
                table: "RezervniDijelovi",
                column: "ServisiranjeID");

            migrationBuilder.AddForeignKey(
                name: "FK_RezervniDijelovi_Servisiranja",
                table: "RezervniDijelovi",
                column: "ServisiranjeID",
                principalTable: "Servisiranja",
                principalColumn: "ServisiranjeId");
        }
    }
}
