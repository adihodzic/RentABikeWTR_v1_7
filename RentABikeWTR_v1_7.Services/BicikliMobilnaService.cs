using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class BicikliMobilnaService : IBicikliMobilnaService
    {
        private readonly IMapper _mapper;
        private readonly RentABikeWTR_v1_7Context _context;

        public BicikliMobilnaService(IMapper mapper, RentABikeWTR_v1_7Context context)
        {
            _mapper = mapper;
            _context = context;
        }

        public List<Model.BicikliPregled> Get(BicikliSearchRequest search)
        {


            if (!string.IsNullOrWhiteSpace(search.NazivBicikla))
            {
                var lis = _context.Bicikli // 
                    //.Include(b => b.TipBicikla)
                    //.Include(c=>c.ModelBicikla)
                    
                    .Where(a => a.NazivBicikla.StartsWith(search.NazivBicikla)).AsQueryable().ToList()
                    .Select(b => new
                    {
                        BiciklID=b.BiciklId,
                        NazivBicikla=b.NazivBicikla,
                        Slika=b.Slika,                        
                        NazivTipa = b.TipBicikla.NazivTipa,
                        NazivModela = b.ModelBicikla.NazivModela
                    });
                    
                  
                
                return _mapper.Map<List<Model.BicikliPregled>>(lis);
                //return lis;
            }
            else
            {
                //var lis = _context.Bicikli
                //    .Include(t => t.ModelBicikla)
                //    .Include(r => r.TipBicikla)
                //    .AsQueryable()
                //    .ToList();
                var lis = _context.Bicikli
        .Select(b => new
        {
            BiciklID = b.BiciklId,
            NazivBicikla = b.NazivBicikla,
            Slika = b.Slika,
            NazivTipa = b.TipBicikla.NazivTipa,
            NazivModela = b.ModelBicikla.NazivModela
        });


                return _mapper.Map<List<Model.BicikliPregled>>(lis);
            }
        }
        public List<Model.BicikliPregled> GetBicikli(BicikliSearchRequest? search)
        {
            var query = _context.Bicikli.AsQueryable();

            // Apply filter if NazivBicikla is provided
            if (!string.IsNullOrWhiteSpace(search?.NazivBicikla))
            {
                query = query.Where(a => a.NazivBicikla.StartsWith(search.NazivBicikla));
            }

            // Include related entities
            //query = query
            //    .Include(b => b.TipBicikla)
            //    .Include(b => b.ModelBicikla);

            // Perform the projection
            var lis = query.Select(b => new
            {
                BiciklID = b.BiciklId,
                NazivBicikla = b.NazivBicikla,
                Slika = b.Slika,
                NazivTipa = b.TipBicikla.NazivTipa,
                NazivModela = b.ModelBicikla.NazivModela
            }).ToList();

            // Map the projected data to the desired model
            return _mapper.Map<List<Model.BicikliPregled>>(lis);
        }
        //public List<Model.BicikliPregled> GetBicikli(BicikliSearchRequest? search)
        //{


        //    if (!string.IsNullOrWhiteSpace(search?.NazivBicikla))
        //    {
        //        var lis = _context.Bicikli // 
        //                                   //.Include(b => b.TipBicikla)
        //                                   //.Include(c=>c.ModelBicikla)

        //            .Where(a => a.NazivBicikla.StartsWith(search.NazivBicikla)).AsQueryable()
        //            .Select(b => new
        //            {
        //                BiciklID = b.BiciklId,
        //                NazivBicikla = b.NazivBicikla,
        //                Slika = b.Slika,
        //                NazivTipa = b.TipBicikla.NazivTipa,
        //                NazivModela = b.ModelBicikla.NazivModela
        //            });



        //        return _mapper.Map<List<Model.BicikliPregled>>(lis);
        //        //return lis;
        //    }
        //    else
        //    {
        //        //var lis = _context.Bicikli
        //        //    .Include(t => t.ModelBicikla)
        //        //    .Include(r => r.TipBicikla)
        //        //    .AsQueryable()
        //        //    .ToList();
        //        var lis = _context.Bicikli
        //.Select(b => new
        //{
        //    BiciklID = b.BiciklId,
        //    NazivBicikla = b.NazivBicikla,
        //    Slika = b.Slika,
        //    NazivTipa = b.TipBicikla.NazivTipa,
        //    NazivModela = b.ModelBicikla.NazivModela
        //});


        //        return _mapper.Map<List<Model.BicikliPregled>>(lis);
        //    }
        //}
        public Model.Bicikli GetById(int id)
        {
            var entity = _context.Set<Database.Bicikli>().Find(id);


            return _mapper.Map<Model.Bicikli>(entity);

        }
        static object isLocked = new object();
        static MLContext mlContext = null;
        static ITransformer model = null;


        public List<Model.Bicikli> Recommend(int biciklID)
        {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    // Load the data from the database
                    var tmpData = _context.Set<Database.Ocjene>().ToList();

                    // Prepare the training data
                    var data = tmpData.SelectMany(x =>
                    {
                        var distinctItemId = tmpData.Select(y => y.BiciklID).Distinct();
                        return distinctItemId.Where(y => y != x.BiciklID).Select(y => new BikeRating
                        {
                            BikeID = (uint)x.BiciklID,
                            CoRentingBikeID = (uint)y,
                            Label = x.Ocjena
                        });
                    }).ToList();

                    var traindata = mlContext.Data.LoadFromEnumerable(data);

                    var options = new MatrixFactorizationTrainer.Options
                    {
                        MatrixColumnIndexColumnName = "BikeIDEncoded",
                        MatrixRowIndexColumnName = "CoRentingBikeIDEncoded",
                        LabelColumnName = "Label",
                        LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                        Alpha = 0.01,
                        Lambda = 0.025,
                        NumberOfIterations = 100,
                        C = 0.00001
                    };

                    var pipeline = mlContext.Transforms.Conversion.MapValueToKey(
                            inputColumnName: "BikeID",
                            outputColumnName: "BikeIDEncoded"
                        )
                        .Append(mlContext.Transforms.Conversion.MapValueToKey(
                            inputColumnName: "CoRentingBikeID",
                            outputColumnName: "CoRentingBikeIDEncoded"
                        ))
                        .Append(mlContext.Recommendation().Trainers.MatrixFactorization(options));

                    model = pipeline.Fit(traindata);
                }
            }

            // Fetch all bikes except the one being recommended
            var allItems = _context.Bicikli.Where(x => x.BiciklId != biciklID).ToList();

            // Initialize PredictionEngine outside the loop
            var predictionEngine = mlContext.Model.CreatePredictionEngine<BikeRating, BikeRatingPrediction>(model);
            var predictionResult = new List<Tuple<Database.Bicikli, float>>();

            foreach (var item in allItems)
            {
                var prediction = predictionEngine.Predict(new BikeRating
                {
                    BikeID = (uint)biciklID,
                    CoRentingBikeID = (uint)item.BiciklId
                });

                predictionResult.Add(new Tuple<Database.Bicikli, float>(item, prediction.Score));
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2)
                                              .Select(x => x.Item1)
                                              .Take(2)
                                              .ToList();

            return _mapper.Map<List<Model.Bicikli>>(finalResult);
        }

        public class BikeRatingPrediction
        {
            public float Score { get; set; }
        }

        public class BikeRating
        {
            [KeyType(count: 10)]
            public uint BikeID { get; set; }

            [KeyType(count: 10)]
            public uint CoRentingBikeID { get; set; }

            public float Label { get; set; }
        }

    }
}
