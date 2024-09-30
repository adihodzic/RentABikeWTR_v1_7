using System;
using System.Collections.Generic;
//using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace RentABikeWTR_v1_7.Services.Database
{
    public partial class RentABikeWTR_v1_7Context : DbContext
    {
        public RentABikeWTR_v1_7Context()
        {

        }
        public RentABikeWTR_v1_7Context(DbContextOptions<RentABikeWTR_v1_7Context> options) : base(options)
        {
        }
        public virtual DbSet<Bicikli> Bicikli { get; set; }
        public virtual DbSet<Drzave> Drzave { get; set; }
        public virtual DbSet<DezurnaVozila> DezurnaVozila { get; set; }
        public virtual DbSet<Korisnici> Korisnici { get; set; }
        //public virtual DbSet<KorisniciUloge> KorisniciUloge { get; set; }
        public virtual DbSet<KategorijeDijelova> KategorijeDijelova { get; set; }
        public virtual DbSet<Kupci> Kupci { get; set; }
        public virtual DbSet<ModeliBicikla> ModeliBicikla { get; set; }
        public virtual DbSet<NajaveOdmora> NajaveOdmora { get; set; }
        public virtual DbSet<LokacijeOdmora> LokacijeOdmora { get; set; }
        public virtual DbSet<Ocjene> Ocjene { get; set; }
        public virtual DbSet<Poslovnice> Poslovnice { get; set; }
        public virtual DbSet<PoziviDezurnomVozilu> PoziviDezurnomVozilu { get; set; }
        public virtual DbSet<ProizvodjaciBicikla> ProizvodjaciBicikla { get; set; }
        public virtual DbSet<Rezervacije> Rezervacije { get; set; }
        public virtual DbSet<ServisiranjaDijelovi> ServisiranjaDijelovi { get; set; }
        public virtual DbSet<RezervniDijelovi> RezervniDijelovi { get; set; }
        public virtual DbSet<Servisiranja> Servisiranja { get; set; }
        public virtual DbSet<Statusi> Statusi { get; set; }
        public virtual DbSet<TipoviBicikla> TipoviBicikla { get; set; }
        public virtual DbSet<TuristickiVodici> TuristickiVodici { get; set; }
        public virtual DbSet<TuristRute> TuristRute { get; set; }
        public virtual DbSet<Uloge> Uloge { get; set; }
        public virtual DbSet<VelicineBicikla> VelicineBicikla { get; set; }
        //public virtual DbSet<Genderi> Genderi { get; set; }
        public virtual DbSet<GodineKupci> GodineKupci { get; set; }
        public virtual DbSet<Poruke> Poruke { get; set; }




        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Bicikli>(entity =>
            {
                entity.HasKey(e => e.BiciklId);

                entity.Property(e => e.NabavnaCijena).HasColumnType("decimal(10,2)");
                entity.Property(e => e.CijenaBicikla).HasColumnType("decimal(10,2)");
                entity.Property(e => e.GodinaProizvodnje).HasColumnType("datetime");



                entity.HasOne(d => d.ModelBicikla)
                    .WithMany(p => p.Bicikli)
                    .HasForeignKey(x => x.ModelBiciklaID)
                    .HasConstraintName("FK_Bicikli_ModeliBicikla");



                entity.HasOne(d => d.VelicinaBicikla)
                    .WithMany(p => p.Bicikli)
                    .HasForeignKey(d => d.VelicinaBiciklaID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Bicikli_VelicineBicikla");

                entity.HasOne(d => d.Status)
                    .WithMany(p => p.Bicikli)
                    .HasForeignKey(d => d.StatusID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Bicikli_Statusi");

                entity.HasOne(d => d.Poslovnica)
                    .WithMany(p => p.Bicikli)
                    .HasForeignKey(d => d.PoslovnicaID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Bicikli_Poslovnice");

                entity.HasOne(d => d.TipBicikla)
                   .WithMany(p => p.Bicikli)
                   .HasForeignKey(d => d.TipBiciklaID)
                   .OnDelete(DeleteBehavior.ClientSetNull)
                   .HasConstraintName("FK_Bicikli_TipoviBicikla");

                entity.HasOne(d => d.ProizvodjacBicikla)
                    .WithMany(p => p.Bicikli)
                    .HasForeignKey(d => d.ProizvodjacBiciklaID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Bicikli_ProizvodjaciBicikla");

                entity.HasOne(d => d.Drzava)
                .WithMany(p => p.Bicikli)
                .HasForeignKey(d => d.DrzavaID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Bicikli_Drzave");




            });
            //modelBuilder.Entity<Genderi>(entity =>
            //{
            //    entity.HasKey(e => e.GenderId);
            //    entity.Property(e => e.NazivSpola)
            //        .IsRequired();
            //});

            modelBuilder.Entity<GodineKupci>(entity =>
            {
                entity.HasKey(e => e.GodineKupacId);
                entity.Property(e => e.GodinePoGrupama)
                    .IsRequired();
            });


            modelBuilder.Entity<DezurnaVozila>(entity =>
            {
                entity.HasKey(e => e.DezurnoVoziloId);

                entity.Property(e => e.TipVozila)
                    .IsRequired()
                    .HasMaxLength(50);


            });


            modelBuilder.Entity<Drzave>(entity =>
            {
                entity.HasKey(e => e.DrzavaID);

                entity.Property(e => e.DrzavaID).HasColumnName("DrzavaID");

                entity.Property(e => e.NazivDrzave)
                    .IsRequired()
                    .HasMaxLength(50);
            });



            modelBuilder.Entity<KategorijeDijelova>(entity =>
            {
                entity.HasKey(e => e.KategorijaDijelovaId);



            });
            modelBuilder.Entity<Korisnici>(entity =>
            {
                entity.HasKey(e => e.KorisnikId);

                entity.HasIndex(e => e.Email) // HasIndex i IsUnique daju jedinstven podatak...za eMail 
                                              //.HasName("Korisnici_Email")// dakle, ne moze se ponavljati
                    .IsUnique();

                entity.HasIndex(e => e.KorisnickoIme)
                    //.HasName("Korisnici_KorisnickoIme")---- provjeriti
                    .IsUnique();

                //entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

                entity.Property(e => e.Email).HasMaxLength(100);

                entity.Property(e => e.Ime)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.KorisnickoIme)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.LozinkaHash)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.LozinkaSalt).HasMaxLength(50);

                entity.Property(e => e.Prezime)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Telefon).HasMaxLength(20);

                entity.HasOne(d => d.Uloga)
                  .WithMany(p => p.Korisnici)
                  .HasForeignKey(d => d.UlogaID)
                  .OnDelete(DeleteBehavior.ClientSetNull)
                  .HasConstraintName("FK_Korisnici_Uloge");

                entity.HasOne(d => d.Drzava)
                   .WithMany(p => p.Korisnici)
                   .HasForeignKey(d => d.DrzavaID)
                   .OnDelete(DeleteBehavior.ClientSetNull)
                   .HasConstraintName("FK_Korisnici_Drzave");

                


                
            });


            modelBuilder.Entity<Kupci>(entity =>
            {
                entity.HasKey(e => e.KupacId);

                entity.HasOne(a => a.Korisnik)
               .WithOne(c => c.Kupac)
               .IsRequired(false)
               .HasForeignKey<Kupci>(d => d.KupacId)
               .HasConstraintName("FK_Kupci_Korisnici");

                //entity.HasOne(d => d.Gender)
                //  .WithMany(p => p.Kupci)
                //  .IsRequired(false) //ovo je veoma bitno
                //  .HasForeignKey(d => d.GenderID)
                //  .OnDelete(DeleteBehavior.ClientSetNull)
                //  .HasConstraintName("FK_Kupci_Genderi");

                entity.HasOne(d => d.GodineKupac)
                  .WithMany(p => p.Kupci)
                  .IsRequired(false) //ovo je veoma bitno
                  .HasForeignKey(d => d.GodineKupacID)
                  .OnDelete(DeleteBehavior.ClientSetNull)
                  .HasConstraintName("FK_Kupci_GodineKupci");
            });


            modelBuilder.Entity<LokacijeOdmora>(entity =>
            {
                entity.HasKey(e => e.LokacijaOdmoraId);

                //entity.Property(e => e.LokacijaId).HasColumnName("LokacijaID");

                entity.Property(e => e.Naziv)
                    .IsRequired()
                    .HasMaxLength(50);

                //entity.Property(e => e.GradId).HasColumnName("GradID");


            });



            modelBuilder.Entity<NajaveOdmora>(entity =>
            {
                entity.HasKey(e => e.NajavaOdmoraId);

                //entity.Property(e => e.NotifikacijaId).HasColumnName("NotifikacijaID");

                entity.Property(e => e.DatumOdmora).HasColumnType("datetime").IsRequired();
                entity.Property(e => e.PocetakOdmora).HasColumnType("datetime").IsRequired();
                entity.Property(e => e.ZavrsetakOdmora).HasColumnType("datetime").IsRequired();



                //entity.Property(e => e.NovostId).HasColumnName("NovostID");

                entity.HasOne(d => d.LokacijaOdmora)
                   .WithMany(p => p.NajavaOdmora)
                   .HasForeignKey(d => d.LokacijaOdmoraID)
                   .HasConstraintName("FK_NajavaOdmora_LokacijaOdmora")
                   .IsRequired(false);

                //entity.Property(e => e.KupacId).HasColumnName("KupacID");

                entity.HasOne(d => d.TuristickiVodic)
                    .WithMany(p => p.NajavaOdmora)
                    .HasForeignKey(d => d.TuristickiVodicID)
                    //.OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_NajavaOdmora_TuristickiVodici")
                .IsRequired(false);
            });


            modelBuilder.Entity<Ocjene>(entity =>
            {
                entity.HasKey(e => e.OcjenaId);


                entity.Property(e => e.DatumOcjene).HasColumnType("datetime");



                entity.HasOne(d => d.Kupac)
                    .WithMany(p => p.Ocjene)
                    .IsRequired(false)
                    .HasForeignKey(d => d.KupacID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Ocjene_Kupci");

                entity.HasOne(d => d.Bicikl)
                    .WithMany(p => p.Ocjene)
                    .IsRequired(false)
                    .HasForeignKey(d => d.BiciklID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Ocjene_Bicikli");
            });

            modelBuilder.Entity<Poslovnice>(entity =>
            {
                entity.HasKey(e => e.PoslovnicaId);


                entity.Property(e => e.NazivPoslovnice)
                    .IsRequired()
                    .HasMaxLength(50);

                //entity.Property(e => e.Opis).HasMaxLength(200);
            });

            modelBuilder.Entity<PoziviDezurnomVozilu>(entity =>
            {
                entity.HasKey(e => e.PozivDezurnomVoziluId);

                //entity.Property(e => e.OsiguranjeId).HasColumnName("OsiguranjeID");

                entity.Property(e => e.DatumPoziva).HasColumnType("datetime");



                entity.Property(e => e.ViseDetalja).HasMaxLength(200);

                entity.HasOne(d => d.Poslovnica)
                .WithMany(p => p.PoziviDezurnomVozilu)
                .HasForeignKey(d => d.PoslovnicaID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PoziviDezurnomVozilu_Poslovnice")
                .IsRequired(false);

                entity.HasOne(d => d.TuristickiVodic)
                    .WithMany(p => p.PoziviDezurnomVozilu)
                    .HasForeignKey(d => d.TuristickiVodicID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PoziviDezurnomVozilu_TuristickiVodici")
                .IsRequired(false);

                entity.HasOne(d => d.DezurnoVozilo)
                .WithMany(p => p.PoziviDezurnomVozilu)
                .HasForeignKey(d => d.DezurnoVoziloID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PoziviDezurnomVozilu_DezurnaVozila")
                .IsRequired(false);
            });

            modelBuilder.Entity<ProizvodjaciBicikla>(entity =>
            {
                entity.HasKey(e => e.ProizvodjacBiciklaId);

            });



                      

            modelBuilder.Entity<Rezervacije>(entity =>
            {
                entity.HasKey(e => e.RezervacijaId);

                entity.Property(e => e.DatumIzdavanja).HasColumnType("datetime");

                entity.Property(e => e.VrijemeVracanja).HasColumnType("datetime");

                entity.Property(e => e.VrijemePreuzimanja).HasColumnType("datetime");
                entity.Property(e => e.CijenaUsluge).HasColumnType("decimal(10,2)");
                

                entity.Property(e => e.Napomena).HasMaxLength(200);




                entity.HasOne(d => d.Kupac)
                    .WithMany(p => p.Rezervacije)
                    .HasForeignKey(d => d.KupacID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Rezervacije_Kupci");

                entity.HasOne(d => d.Korisnik)
                    .WithMany(p => p.Rezervacije)
                    .HasForeignKey(d => d.KorisnikID)
                    .HasConstraintName("FK_Rezervacije_Korisnici")
                    .IsRequired(false);// ovo sam dodao posto je nullable FK

                entity.HasOne(d => d.Bicikl)
                    .WithMany(p => p.Rezervacije)
                    .HasForeignKey(d => d.BiciklID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Rezervacije_Bicikli");

                entity.HasOne(d => d.TuristickiVodic)
                    .WithMany(p => p.Rezervacije)
                    .HasForeignKey(d => d.TuristickiVodicID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Rezervacije_TuristickiVodici")
                    .IsRequired(false);

                entity.HasOne(d => d.TuristRuta)
                    .WithMany(p => p.Rezervacije)
                    .HasForeignKey(d => d.TuristRutaID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Rezervacije_TuristRute")
                    .IsRequired(false);
            });
            modelBuilder.Entity<ServisiranjaDijelovi>(entity =>
            {
                entity.HasKey(e => e.ServisiranjaDijeloviId);



                

                // entity.(c => c.User);
                entity.HasOne(d => d.RezervniDio)
                    .WithMany(p => p.ServisiranjaDijelovi)
                    .HasForeignKey(d => d.RezervniDijeloviID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ServisiranjaDijelovi_RezervniDijelovi")
                    .IsRequired(false);
                

                entity.HasOne(d => d.Servisiranje)
                   .WithMany(p => p.ServisiranjaDijelovi)
                   .HasForeignKey(d => d.ServisiranjeID)
                   .OnDelete(DeleteBehavior.ClientSetNull)
                   .HasConstraintName("FK_ServisiranjaDijelovi_Servisiranja")
                   .IsRequired(false);





            });

            modelBuilder.Entity<RezervniDijelovi>(entity =>
            {
                entity.HasKey(e => e.RezervniDijeloviId);



                entity.Property(e => e.NazivRezervnogDijela)
                    //.IsRequired()
                    .HasMaxLength(50);

                // entity.(c => c.User);
                entity.HasOne(d => d.KategorijaDijelova)
                    .WithMany(p => p.RezervniDijelovi)
                    .HasForeignKey(d => d.KategorijaDijelovaID)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_RezervniDijelovi_KategorijeDijelova");

               





            });

            modelBuilder.Entity<Servisiranja>(entity =>
            {
                entity.HasKey(e => e.ServisiranjeId);

                

                entity.Property(e => e.OpisKvara)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.HasOne(d => d.Bicikl)
                .WithMany(p => p.Servisiranje)
                .HasForeignKey(d => d.BiciklID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Servisi_Bicikli");

               

            });

            modelBuilder.Entity<Statusi>(entity =>
            {
                entity.HasKey(e => e.StatusId);

                

            });
            modelBuilder.Entity<TipoviBicikla>(entity =>
            {
                entity.HasKey(e => e.TipBiciklaId);


            });

            modelBuilder.Entity<TuristickiVodici>(entity =>
            {
                entity.HasKey(e => e.TuristickiVodicId);
                entity.Property(e => e.CijenaVodica).HasColumnType("decimal(10,2)");
                

                // one to one or zero 
                entity.HasOne(a => a.Korisnik)
               .WithOne(c => c.TuristickiVodic)
               .IsRequired(false)
               .HasForeignKey<TuristickiVodici>(d => d.TuristickiVodicId);

            });
            modelBuilder.Entity<TuristRute>(entity =>
            {
                entity.HasKey(e => e.TuristRutaId);
                entity.Property(e => e.CijenaRute).HasColumnType("decimal(10,2)");

                

            });

            modelBuilder.Entity<Uloge>(entity =>
            {
                entity.HasKey(e => e.UlogaId);

                entity.Property(e => e.UlogaId).HasColumnName("UlogaID");

                entity.Property(e => e.NazivUloge)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.OpisUloge).HasMaxLength(200);
            });

            modelBuilder.Entity<VelicineBicikla>(entity =>
            {
                entity.HasKey(e => e.VelicinaBiciklaId);
                entity.Property(e => e.NazivVelicine)
                    .IsRequired();
            });


           

            modelBuilder.Entity<KategorijeDijelova>(entity =>
            {
                entity.HasKey(e => e.KategorijaDijelovaId);
            });
            modelBuilder.Entity<ModeliBicikla>(entity =>
            {
                entity.HasKey(e => e.ModelBiciklaId);

                

                entity.Property(e => e.NazivModela)
                    .IsRequired()
                    .HasMaxLength(50);


            });

            modelBuilder.Entity<Poruke>(entity =>
            {
                entity.HasKey(e => e.PorukaId);
                entity.Property(e => e.Tekst)
                    .IsRequired();
            });


            OnModelCreatingPartial(modelBuilder);
            
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);


    }

}

