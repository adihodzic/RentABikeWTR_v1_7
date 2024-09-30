using MapsterMapper;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Model;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace RentABikeWTR_v1_7.Services
{
    public class XRezervacijeService : IXRezervacijeService
    {
        private readonly RentABikeWTR_v1_7Context _context;
        private readonly IMapper _mapper;

        public XRezervacijeService(IMapper mapper, RentABikeWTR_v1_7Context context)
        {
            _context = context;
            _mapper = mapper;

        }
        public XRezervacijeResult GetXRezervacije(DateTime DatumOd, DateTime DatumDo)
        {

            decimal Ukupnasuma = 0;
            var query = _context.Rezervacije.AsQueryable()
                .Include(a => a.Kupac)
                .Include(b => b.Bicikl)
                .Include(c => c.TuristRuta)
                .Where(x => (x.DatumIzdavanja.Date >= DatumOd.Date)
                && (x.DatumIzdavanja <= DatumDo.Date));

            List<Model.XRezervacije> xrez = new List<Model.XRezervacije>();

            var lista = query.ToList();
            foreach (var item in lista)
            {
                var xitem = new XRezervacije();
                xitem.RezervacijaId = item.RezervacijaId;
                xitem.KupacID = (int)item.KupacID;
                xitem.KorisnickoIme = _context.Korisnici
                    .Where(k => k.KorisnikId == item.KupacID).Select(c => c.KorisnickoIme).FirstOrDefault();

                xitem.CijenaUsluge = item.CijenaUsluge;
                Ukupnasuma += item.CijenaUsluge;
                xitem.Datum = item.DatumIzdavanja.Date;
                xitem.BiciklID = item.BiciklID;
                xitem.NazivBicikla = item.Bicikl.NazivBicikla;
                if (item.TuristRutaID != null)
                {
                    xitem.TuristRutaID = item.TuristRutaID;
                    xitem.Naziv = item.TuristRuta.Naziv;
                }
                else 
                { 
                    xitem.TuristRutaID = 0; 
                    xitem.Naziv = "Nema podataka"; 
                }


                xrez.Add(xitem);

            }
            return new XRezervacijeResult
            {
                UkupnaSuma = Ukupnasuma,
                XRezervacijeLista = xrez

            };
        }


    }
}
