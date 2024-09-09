using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;
using Stripe;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]

    public class TuristickiVodiciController : ControllerBase
    {
        private readonly ITuristickiVodiciService _service;
        //private readonly ILoginService xservice;

        public TuristickiVodiciController(ITuristickiVodiciService service)
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
        public List<Model.TuristickiVodici> Get([FromQuery] TuristickiVodiciSearchRequest? request)
        {
            return _service.Get(request);
        }
        //}
        [HttpGet("PretragaVodici")]
        public List<Model.TuristickiVodici> GetVodici([FromQuery] TuristickiVodiciSearchRequest? request)
        {
            return _service.GetVodici(request);
        }
        [HttpGet("{id}")]
        public Model.TuristickiVodici GetById(int id)
        {
            return _service.GetById(id);

        }
        [HttpPut("{id}")]
        public Model.TuristickiVodici Update(int id, [FromBody] TuristickiVodiciUpsertRequest request)
        {
            return _service.Update(id, request);
        }
        [HttpPatch("{id}")]
        public Model.TuristickiVodici Patch(int id, [FromBody] TuristickiVodiciUpsertRequest request)
        {
            return _service.Patch(id, request);
        }
        [HttpPost]
        public Model.TuristickiVodici Insert(TuristickiVodiciUpsertRequest request)
        {
            return _service.Insert(request);
        }
    }

}
