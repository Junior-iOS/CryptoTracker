//
//  PreviewProvider+Extensions.swift
//  CryptoTracker
//
//  Created by NJ Development on 29/05/24.
//

import Foundation

class DeveloperPreview {
    static let shared = DeveloperPreview()
    private init() {}

    let homeVM = HomeViewModel()

    let stat1 = Statistic(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34)
    let stat2 = Statistic(title: "Total Volume", value: "$1.23Tr")
    let stat3 = Statistic(title: "Portfolio Value", value: "$50.4k", percentageChange: -12.34)

    let coin = Coin(
       id: "bitcoin",
       symbol: "btc",
       name: "Bitcoin",
       image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
       currentPrice: 61_408,
       marketCap: 1_141_731_099_010,
       marketCapRank: 1,
       fullyDilutedValuation: 1_285_385_611_303,
       totalVolume: 67_190_952_980,
       high24H: 61_712,
       low24H: 56_220,
       priceChange24H: 3_952.64,
       priceChangePercentage24H: 6.87944,
       marketCapChange24H: 72_110_681_879,
       marketCapChangePercentage24H: 6.74171,
       circulatingSupply: 18_653_043,
       totalSupply: 21_000_000,
       maxSupply: 21_000_000,
       ath: 61_712,
       athChangePercentage: -0.97589,
       athDate: "2021-03-13T20:49:26.606Z",
       atl: 67.81,
       atlChangePercentage: 90_020.24075,
       atlDate: "2013-07-06T00:00:00.000Z",
       lastUpdated: "2021-03-13T23:18:10.268Z",
       sparklineIn7D: Coin.SparklineIn7D(price: [
           54_019.26878317463,
           53_718.060935791524,
           53_677.12968669343,
           53_848.3814432924,
           53_561.593235320615,
           53_456.0913723206,
           53_888.97184353125,
           54_796.37233913172,
           54_593.507358383504,
           54_582.558599307624,
           54_635.7248282177,
           54_772.612788430226,
           55_192.54513921453,
           54_878.11598538206,
           54_513.95881205807,
           55_013.68511841942,
           55_145.89456844788,
           54_718.37455337104,
           54_954.0493828267,
           54_910.13413954234,
           54_778.58411728141,
           55_027.87934987173,
           55_473.0657777974,
           54_997.291345118225,
           54_991.81484262107,
           55_395.61328972238,
           55_530.513360661644,
           55_344.4499292381,
           54_889.00473869075,
           54_844.521923521665,
           54_710.03981625522,
           54_135.005312343856,
           54_278.51586384954,
           54_255.871982023025,
           54_346.240757736465,
           54_405.90449526803,
           54_909.51138548527,
           55_169.3372715675,
           54_810.85302834732,
           54_696.044114623706,
           54_332.39670114743,
           54_815.81007775886,
           55_013.53089568202,
           54_856.867125138066,
           55_090.76841223987,
           54_524.41939124773,
           54_864.068334250915,
           54_462.38634298567,
           54_810.6138506792,
           54_763.5416402156,
           54_621.36137575708,
           54_513.628030530825,
           54_356.00127005116,
           53_755.786684715764,
           54_024.540451750094,
           54_385.912857981304,
           54_399.67618552436,
           53_991.52168768531,
           54_683.32533920595,
           54_449.31811384671,
           54_409.102042970466,
           54_370.86991701537,
           53_731.669170540394,
           53_645.37874343392,
           53_841.45014070333,
           53_078.52898275558,
           52_881.63656182149,
           53_010.25164880975,
           52_936.11939761323,
           52_937.55256563505,
           53_413.673939003136,
           53_395.17699522727,
           53_596.70402266675,
           53_456.22811013035,
           53_483.547854166834,
           53_574.40015717944,
           53_681.336964452734,
           54_101.59049997355,
           54_318.29276391888,
           54_511.25370785759,
           54_332.08597577831,
           54_577.323438764404,
           54_477.276388342325,
           54_289.676338302765,
           54_218.42837403623,
           54_802.18754896328,
           55_985.49640087922,
           56_756.316501699876,
           57_210.138362768965,
           56_805.27815017699,
           56_682.3217648727,
           57_043.194415417776,
           56_912.77785094373,
           56_786.15869001341,
           57_003.56072100917,
           57_166.66441986013,
           57_828.511814425874,
           57_727.41272216753,
           58_721.7528896422,
           58_167.84861375856,
           58_180.50145658414,
           58_115.72142404893,
           58_058.65960870684,
           58_105.84576135331,
           57_815.47461888876,
           57_555.387870015315,
           57_506.06807298437,
           57_474.98576430212,
           57_943.629057843165,
           57_864.43148371131,
           57_518.884140001275,
           57_500.77929481661,
           57_368.69249425147,
           57_544.96374659641,
           57_642.48628971112,
           57_610.310340523756,
           57_801.707574342116,
           57_764.18193058321,
           57_403.375409342945,
           57_669.860487076316,
           57_812.96915967891,
           57_504.33531773738,
           57_444.43455289276,
           57_671.75799990867,
           56_629.776997674526,
           57_009.09536225692,
           56_974.39138798086,
           56_874.43203673815,
           56_652.77633376425,
           56_530.179449555064,
           56_387.95830875742,
           56_992.622783818544,
           57_181.09163589668,
           56_908.09493826477,
           56_902.91387334043,
           56_924.327009138164,
           56_636.44312948976,
           56_649.998369848996,
           56_825.95829302063,
           56_860.281702323526,
           56_917.55558938772,
           56_927.31213741791,
           56_754.810633329354,
           56_433.44851800957,
           56_600.74528738432,
           57_453.29169375094,
           58_130.78114831457,
           58_070.47719600076,
           57_930.49833482948,
           57_787.23755822543,
           58_021.66564986657,
           57_899.998011485266,
           58_833.861160841436,
           58_789.11830069634,
           58_491.11446437883,
           58_493.58897378262,
           58_757.30471138256,
           58_554.84171574884,
           57_839.05673758758,
           57_992.34121354044,
           57_699.960140573115,
           57_771.20058181922,
           58_080.643272295056,
           57_831.48061892176,
           57_430.1839517489,
           56_969.140564644826,
           57_154.57504790339,
           57_336.828870254896
       ]),
       priceChangePercentage24HInCurrency: 3_952.64,
       currentHoldings: 1.5)
}
