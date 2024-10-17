import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ur_habits/utils/helper/ads/ad_helper.dart';

class AdManager {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  bool _isInterstitialAdReady = false;

  ///　バナー広告の読み込み
  void loadBannerAd(AdSize size) {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          log('バナー広告がロードされました');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          log('バナー広告の読み込みが次の理由で失敗しました: $error');
        },
        onAdOpened: (Ad ad) => log('バナー広告が開かれました'),
        onAdClosed: (Ad ad) => log('バナー広告が閉じられました'),
        onAdImpression: (Ad ad) => log('次のバナー広告が表示されました: $ad'),
      ),
    );

    _bannerAd!.load();
  }

  ///　インターステシャル広告の読み込み
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
          log('インターステシャル広告が読み込まれました。');

          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              ad.dispose();
              log('インターステシャル広告の表示に失敗しました: $error');
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('インターステシャル広告の読み込みに失敗しました: $error');
        },
      ),
    );
  }

  ///　インターステシャル広告の表示
  void showInterstitialAd() {
    if (_isInterstitialAdReady && _interstitialAd != null) {
      _interstitialAd!.show();
    } else {
      log('インターステシャル広告はまだ準備ができていません。');
    }
  }

  ///　バナー広告のWidgetを返す
  Widget getBannerAdWidget() {
    if (_bannerAd != null) {
      return AdWidget(ad: _bannerAd!);
    } else {
      return const SizedBox.shrink();
    }
  }

  double? get bannerAdWidth {
    return _bannerAd?.size.width.toDouble();
  }

  double? get bannerAdHeight {
    return _bannerAd?.size.height.toDouble();
  }

  ///　リソースの解放
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }
}
