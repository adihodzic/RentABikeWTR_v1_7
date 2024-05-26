using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class KorisniciController : ControllerBase
    {
        private readonly IKorisniciService _service;
        //private readonly ILoginService xservice;

        public KorisniciController(IKorisniciService service)
        {
            _service = service;
            //this.xservice = xservice;
        }
        //[HttpGet]// mozda je ovo rjesenje za dinamyc s praznim zagradama
        //public List<Model.Korisnici> Get()
        //{
        //    return _service.Get();
        //}
        [HttpGet]
        public List<Model.Korisnici> Get([FromQuery] KorisniciSearchRequest? request)
        {
            return _service.Get(request);
        }
        [HttpGet("Profil")]
        public Model.Korisnici GetProfilKorisnika(string username)
        {
            return _service.GetProfilKorisnika(username);
        }
        [HttpGet("PregledKupaca")]
        public List<Model.Korisnici> GetKupci([FromQuery] KorisniciSearchRequest request)
        {
            return _service.GetKupci(request);
        }
        [HttpGet("{id}")]
        public Model.Korisnici GetById(int id)
        {
            return _service.GetById(id);

        }
        [HttpPost]
        public Model.Korisnici Insert(KorisniciUpsertRequest request)
        {
            return _service.Insert(request);
        }
        [AllowAnonymous]
        [HttpPost("Registracija")]
        public Model.Korisnici InsertKupca(KorisniciUpsertRequest request)
        {
            return _service.Insert(request);
        }
        [HttpPut("{id}")]
        public Model.Korisnici Update(int id, [FromBody] KorisniciUpsertRequest request)
        {
            return _service.Update(id, request);
        }
        [HttpPut("ProfilUpdate/{id}")]
        public Model.Korisnici UpdateProfilKorisnika(int id, [FromBody] KorisniciMobilnaProfilRequest request)
        {
            return _service.UpdateProfilKorisnika(id, request);
        }
        //[HttpPost(nameof(AuthentikacijaKorisnika))]  // ovo je rješenje greške na swagger-u mora biti httpPost drugačiji od inserta
        //                                             // Tačnije, morao sam dodati (nameof(AuthentikacijaKupca))
        //[AllowAnonymous]
        //public async Task<Model.Korisnici> AuthentikacijaKorisnika(string usern, string pass)
        //{
        //    return await _service.AuthentikacijaKorisnika(usern, pass);
        //}

    }
}
