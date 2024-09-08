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
                                              .Take(3)
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


    //    public List<Model.Bicikli> Recommend(int biciklID)
    //    {
    //        //OVO MI TREBA NAJVIŠE // Apply filter
    //        //TrainTestData dataSplit = mlContext.Data.TrainTestSplit(data, testFraction: 0.2);
    //        lock (isLocked)
    //        {

    //            ///////////////////////////////////////////////////////////////////////////////////////////////////////////

    //            if (mlContext == null)
    //            {
    //                mlContext = new MLContext();

    //                //var tmpData = Context.Narudzbes.Include("NarudzbaStavkes").ToList();
    //                var tmpData = _context.Set<Database.Ocjene>();
    //                //var ocj = new Ocjene();

    //                var data = new List<BikeRating>();

    //                foreach (var x in tmpData)
    //                {

    //                    var distinctItemId = _context.Ocjene.Select(y => y.BiciklID).Distinct().ToList();
    //                    //.Select(y => y.BiciklID).ToList();  // različiti biciklID iz Ocjena (kao da sam koristio distinct()

    //                    distinctItemId.ForEach(y =>
    //                    {
    //                        // var relatedItems = _context.Ocjene.Where(z => (z.BiciklID != y) && (z.Ocjena == x.Ocjena));  //svi biciklID iz Ocjena i ponavljaju se
    //                        var relatedItems = _context.Ocjene
    //                         .Where(z => z.BiciklID != y)// && z.Ocjena == x.Ocjena && z.KupacID == x.KupacID) // Filter by BiciklID, Ocjena, and kupacID
    //                         .ToList(); // Materialize the query


    //                        foreach (var z in relatedItems)
    //                        {
    //                            data.Add(new BikeRating()
    //                            {
    //                                BikeID = (uint)y,
    //                                CoRentingBikeID = (uint)z.BiciklID,
    //                                Label = z.Ocjena,
    //                                //Ocjena=z.Ocjena
    //                            });


    //                        }
    //                    });

    //                }

    //                var traindata = mlContext.Data.LoadFromEnumerable(data);


    //                //STEP 3: Your data is already encoded so all you need to do is specify options for MatrxiFactorizationTrainer with a few extra hyperparameters
    //                //        LossFunction, Alpa, Lambda and a few others like K and C as shown below and call the trainer.
    //                MatrixFactorizationTrainer.Options options=new MatrixFactorizationTrainer.Options();
    //                //MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
    //                //var options = new MLContext().Recommendation().MatrixFactorization.Recommendation.Options();
    //                //options.MatrixColumnIndexColumnName = nameof(BikeRating.userId);
    //                options.MatrixColumnIndexColumnName = "BikeIDEncoded";
    //                options.MatrixRowIndexColumnName = "CoRentingBikeIDEncoded";
    //                options.LabelColumnName = "Label";
    //                options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
    //                //options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossRegression;
    //                options.Alpha = 0.01;
    //                options.Lambda = 0.025;

    //                // For better results use the following parameters
    //                options.NumberOfIterations = 100;
    //                //options.ApproximationRank = 100;
    //                options.C = 0.00001;
    //                var pipeline = mlContext.Transforms.Conversion.MapValueToKey(
    //                    inputColumnName: "BikeID",
    //                    outputColumnName: "BikeIDEncoded"
    //                    )
    //                    .Append(mlContext.Transforms.Conversion.MapValueToKey(

    //                        inputColumnName: "CoRentingBikeID",
    //                        outputColumnName: "CoRentingBikeIDEncoded"
    //                        )
    //                    .Append(mlContext.Recommendation().Trainers.MatrixFactorization(options)));
    //                    //.Append(mlContext.Recommendation().MatrixFactorization(options)));

    //                //var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

    //                //model = est.Fit(traindata);
    //                model = pipeline.Fit(traindata);
    //            }
    //        }





    //        List<Database.Bicikli> allItems = new List<Database.Bicikli>();

    //        //for (int i = 0; i < 10000; i++)
    //        //{
    //        var tmp = _context.Bicikli.Where(x => x.BiciklId != biciklID);  //provjeriti
    //        allItems.AddRange(tmp);
    //        //}
    //        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //        var predictionResult = new List<Tuple<Database.Bicikli, float>>();

    //        foreach (var item in allItems)
    //        {
    //            var predictionEngine = mlContext.Model.CreatePredictionEngine<BikeRating, BikeRatingPrediction>(model);
    //            var prediction = predictionEngine.Predict(new BikeRating()
    //            {
    //                BikeID = (uint)biciklID,
    //                CoRentingBikeID = (uint)item.BiciklId
    //            });

    //            predictionResult.Add(new Tuple<Database.Bicikli, float>(item, prediction.Score));
    //        }

    //        var finalResult = predictionResult.OrderByDescending(x => x.Item2)
    //            .Select(x => x.Item1).Take(2).ToList();

    //        return _mapper.Map<List<Model.Bicikli>>(finalResult);
    //    }
    //}


    //public class BikeRatingPrediction
    //{
    //    public float Score { get; set; }
    //}

    //public class BikeRating
    //{
    //    [KeyType(count: 10)]
    //    public uint BikeID { get; set; }

    //    [KeyType(count: 10)]
    //    public uint CoRentingBikeID { get; set; }

    //    public float Label { get; set; }



        

    }
}
