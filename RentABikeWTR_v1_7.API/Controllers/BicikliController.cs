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
    public class BicikliController : ControllerBase
    {
        private readonly IBicikliService _service;
        //private readonly ILoginService xservice;

        public BicikliController(IBicikliService service)
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
        public List<Model.Bicikli> Get([FromQuery] BicikliSearchRequest? request)
        {
            return _service.Get(request);
        }
        [HttpGet("{id}")]
        public Model.Bicikli GetById(int id)
        {
            return _service.GetById(id);

        }
        [HttpPut("{id}")]
        public Model.Bicikli Update(int id, [FromBody] BicikliUpsertRequest request)
        {
            return _service.Update(id, request);
        }
        [HttpPatch("{id}")]
        public Model.Bicikli Patch(int id, [FromBody] BicikliUpsertRequest request)
        {
            return _service.Patch(id, request);
        }
        [HttpPost]
        public Model.Bicikli Insert(BicikliUpsertRequest request)
        {
            return _service.Insert(request);
        }
    }

}
