using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RezervniDijeloviController : ControllerBase
    {
        private readonly IRezervniDijeloviService _service;
        //private readonly ILoginService xservice;

        public RezervniDijeloviController(IRezervniDijeloviService service)
        {
            _service = service;

        }

        [HttpGet]
        public List<Model.RezervniDijelovi> Get([FromQuery] RezervniDijeloviSearchRequest? request)
        {
            return _service.Get(request);
        }
        [HttpGet("{id}")]
        public Model.RezervniDijelovi GetById(int id)
        {
            return _service.GetById(id);

        }
        [HttpPut("{id}")]
        public Model.RezervniDijelovi Update(int id, [FromBody] RezervniDijeloviUpsertRequest request)
        {
            return _service.Update(id, request);
        }
        [HttpPatch("{id}")]
        public Model.RezervniDijelovi Patch(int id, [FromBody] RezervniDijeloviUpsertRequest request)
        {
            return _service.Patch(id, request);
        }
        [HttpPost]
        public Model.RezervniDijelovi Insert(RezervniDijeloviUpsertRequest request)
        {
            return _service.Insert(request);
        }
        [HttpGet("Pregled")]
        public List<Model.RezervniDijeloviPregled> GetDijeloviPregled()
        {
            return _service.GetDijeloviPregled();
        }
    }
}
