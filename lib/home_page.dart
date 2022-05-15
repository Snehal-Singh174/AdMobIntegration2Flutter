import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

const String testDevice = 'MobileId';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
    testDevices: testDevice != null?<String>[testDevice] : null,
    childDirected:  true,
    keywords:  <String>['Game','Mario'],
  );

  BannerAd _bannerAd;

  RewardedVideoAd videoAd = RewardedVideoAd.instance;

  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd(){
    return new InterstitialAd(adUnitId: InterstitialAd.testAdUnitId,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event){
          print("Interstitial event : $event");
        }
    );
  }

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print("Banner event : $event");
        });
  }

  @override
  void initState(){
    FirebaseAdMob.instance.initialize(
        appId: FirebaseAdMob.testAppId
    );
    _bannerAd =createBannerAd()..load()..show(
      anchorType: AnchorType.top,
    );

    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("REWARDED VIDEO AD $event");
      if (event == RewardedVideoAdEvent.rewarded) {
      }
    };

    videoAd.load(
        adUnitId: RewardedVideoAd.testAdUnitId,
        targetingInfo: targetInfo);

    super.initState();
  }

  @override
  void dispose()
  {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.asset('assets/ads.png', height: 400,),
              Container(
                height: 100,
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blue.withOpacity(0.2)),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/banner.png',
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "You can see Banner Ads \non top☝",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  videoAd.show();
                },
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blue.withOpacity(0.2)),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/videoAds.png',
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "See Video Ads 🎥",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  _interstitialAd = createInterstitialAd()..load()..show(
                    anchorType: AnchorType.top,
                  );
                },
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blue.withOpacity(0.2)),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/interstitialAd.png',
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "See Interstitial Ads",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
