# StepsTrackerPrototype
StepsTrackerPrototype for NyarTech

<img src="https://i.ibb.co/TkCj0bH/logo-white.png" alt="Proposed logo" width="100" height="100"/>

Skander HAMDI from Algeria, Flutter Developer

This my coding task submission, and the following list presents what's done:

## Functional
  
- [x] Users could be authenticated anonymously, no need to take a phone number or email. Upon first installation the app should ask for their name and **(Bonus!) image.** **Done**
- [x] The application should track the user footsteps and update them in real-time, meaning while the app is in the foreground, and the user walks around, they should be able to see the steps counter increasing. **Done**
- [x] For each number of footsteps taken, a function must run to exchange it to “Health Points”, e.g., 100 footsteps = 1 Health Point. **Done**
- [x] There should be a history that lists all the exchanges that happened by date and time. **Done**
- [x] Show a visual feedback (e.g., Snack bar) when users gain extra points. **Done** 
- [x] There should be a catalog of rewards so users can pick a reward they like and redeem it. Each reward is linked to one partner (e.g., 150 SAR off on Digital Watches from Jarir). **Done**
- [x] Rewards are paid with health points, feedback should be given upon all cases: if the redemption can happen, show a confirmation dialog, if it cannot due to a low number of points, show an error message stating clearly what’s wrong. **Done**
- [x] **(Bonus!)** There is a leaderboard page where the user can see their ranking (how many steps they have made since installing the app) compared to all other users, to encourage them to walk more. **Done**
- [x] **(Bonus!)** If the application is in background, or turned off, the exchange will happen while they are walking, and a notification would be sent from the app telling them that they gained extra points. **Done** (For **Android**, i found a way to do that just using Flutter but it stops after some time, then i have used a Foreground service with **native code** which launch another stepcounter which was able to keep the first stream alive. For **iOS**, we just use flutter and the public pedometer, the process is paused after some time from moving to background and we cannot guarantee that it will always work. Background tasks and local notification for both **Android** and **iOS** are working in most test cases.
- [x] **(Bonus!)** The app is multilingual, supports both Arabic and English. **Done**

## Non-Functional

- [x] Usable and user-friendly interface. **I think**
- [ ] Follow Material design rules. **Kind of, I can provide the prototype i proposed as XD file** 
- [x] Use a proper architecture for the code, UI code must not include any DB queries or
business logic. **Done**
- [x] Use clear models for data. **Done**
- [x] Document every function and provide meaningful variable names and follow Effective Dart to write your code. **Only the important ones**
- [x] **(Bonus!)** Dark mode. **Done** 
- [ ] (Bonus!) Privacy and security (e.g., Firestore database rules)
- [ ] (Bonus!) The project is null-safe. **Not all of them, i started the project with Flutter 1.24 and after 3 days i moved to Flutter 2**

## Software requirements
- [x] The application could support only one platform, e.g., Android or iOS. (Bouns!) support for both Android and iOS. **The app is working on Android and iOS** 


## Notes
- The application has been tested on **Emulator** and **Redmi Note 10** as real device.
- The application has been tested on **Simulator (iPhone 8 & iPhone 12 Pro Max iOS 14.4)** and **iPhone X iOS 14.4** as real device.
- **google-services.json** & **GoogleServicesInfo.plist** are included in the project.

```
flutter doctor
```
### output:

```
[✓] Flutter (Channel master, 2.3.0-17.0.pre.327, on macOS 11.4 20F71 darwin-x64, locale en-DZ)
[!] Android toolchain - develop for Android devices (Android SDK version 29.0.3)
    ✗ cmdline-tools component is missing
      Run `path/to/sdkmanager --install "cmdline-tools;latest"`
      See https://developer.android.com/studio/command-line for more details.
    ✗ Android license status unknown.
      Run `flutter doctor --android-licenses` to accept the SDK licenses.
      See https://flutter.dev/docs/get-started/install/macos#android-setup for more details.
[✓] Xcode - develop for iOS and macOS
[✓] Chrome - develop for the web
[✓] Android Studio (version 3.5)
[✓] IntelliJ IDEA Community Edition (version 2021.1)
[✓] VS Code (version 1.51.1)
[✓] Connected device (2 available)
```

### Screenshots:

##### Android:

<div style="display:inline;">
  
<img src="https://scontent.fqsf1-2.fna.fbcdn.net/v/t1.15752-9/131441447_315721666704033_4350465455241550749_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeFYSfO2yIfeCwkVDlO01YUpTFJJZaT2rnlMUkllpPaueYdKxjNTTrfEEfipPTOKA1jAWkQFgdR-Meq-wlCdp9nh&_nc_ohc=Hbdd4l2Qk-sAX8e0XvC&_nc_ht=scontent.fqsf1-2.fna&oh=40a606f0734214105a456558cb18b418&oe=60CA84A7" alt="Proposed logo" width="200" height="auto"/>

<img src="https://scontent.fqsf1-1.fna.fbcdn.net/v/t1.15752-9/198735970_176273757791580_6854048349079638678_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeG8LySoEOGINHnVYGSH44yqHGTrCVovxwkcZOsJWi_HCUXTSm43OLsWb92XkAqs0JkDQq7FutpHJ8vylnuR795p&_nc_ohc=eCG8EsAEIOoAX_1aef2&_nc_ht=scontent.fqsf1-1.fna&oh=d86ae815b4fdf4e3edf919dec06d0018&oe=60CA7E71" alt="Proposed logo" width="200" height="auto"/>
  
<img src="https://scontent.fqsf1-2.fna.fbcdn.net/v/t1.15752-9/199138179_326731015624561_273246232001302618_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeFVIku_BMCw41zKvIkmBtE5L5p_GA4WvhMvmn8YDha-E8ZpygakJZXKVsrZdW2eKu7djvAty-r_N5NGI6Uzq0Yx&_nc_ohc=uPc5c6vWG_YAX-1fBUx&_nc_ht=scontent.fqsf1-2.fna&oh=8b75d97ac570ef08386c7a913890c633&oe=60CAB35B" alt="Proposed logo" width="200" height="auto"/>

<img src="https://scontent.fqsf1-2.fna.fbcdn.net/v/t1.15752-9/197183247_338350251009762_8190542836161941829_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeEHDETALY1d6wgTDNwQbLlL_mUUHudA1v_-ZRQe50DW__WSCNtna6QFk-LPsV83RNBpSVDvSgsm1dxIdbrMJBVx&_nc_ohc=EIbl_uE7MVEAX_o9XZp&_nc_ht=scontent.fqsf1-2.fna&oh=8fb358464c3c5031cc10179f9380a7fb&oe=60C93120" alt="Proposed logo" width="200" height="auto"/>

<img src="https://scontent.fqsf1-1.fna.fbcdn.net/v/t1.15752-9/200152754_268674715050879_301706862441701205_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeFvBqm8j2-64JjKpLicAY0Ds91YyJCueK6z3VjIkK54rtMY_CkAQEvDkcSbz6UDfO-paWjpujHHz8utV_P5QpoP&_nc_ohc=HhK0f7ZEOYAAX9DxZ0B&_nc_ht=scontent.fqsf1-1.fna&oh=d736848a0032d090b7510251fac72e62&oe=60CAEA7D" alt="Proposed logo" width="200" height="auto"/>
  
  
<img src="https://scontent.fqsf1-2.fna.fbcdn.net/v/t1.15752-9/199837522_340788460736377_5803482589800391442_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeGeYwwA2zxXh9zPEwSJBeEtL6NODLTWECEvo04MtNYQISb9FPRCeQgkLRHDYGOV1g0qjsciWNc_aC-oRECKBcak&_nc_ohc=qJaOyxxhEOIAX-SEG_J&_nc_ht=scontent.fqsf1-2.fna&oh=2a31ae2e7662b400e40d97a4ff257993&oe=60C9FE4F" alt="Proposed logo" width="200" height="auto"/>
  
<img src="https://scontent.fqsf1-2.fna.fbcdn.net/v/t1.15752-9/197281180_1149084992224371_5182914628937974395_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeE175KuHnAeJFl_zSkEaIK6L0mfbI8LhKgvSZ9sjwuEqA3hCjIVCIU0NNTSuM8vKQhujaIWhDUA-ZisVTfEnuNU&_nc_ohc=OfN2Y4GTpm4AX_bL3EN&tn=BpJPJC4DUrz6hD8l&_nc_ht=scontent.fqsf1-2.fna&oh=9b4a54efdcf7df6e72d525850b4558e6&oe=60C94535" alt="Proposed logo" width="200" height="auto"/>
  
<img src="https://scontent.fqsf1-2.fna.fbcdn.net/v/t1.15752-9/197682981_539056487109803_7725376806138123650_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeGf7EB1LTuFHTJpbQw6iX6-sZqHoIS56k2xmoeghLnqTXDIW_uWKrfqwNtZoEfhMgz1ybej0k3DFFic7GqO-31M&_nc_ohc=DmIerGR7lvgAX_R0b3h&tn=BpJPJC4DUrz6hD8l&_nc_ht=scontent.fqsf1-2.fna&oh=52a0ac0ca859e364a3318b03ba2979c9&oe=60CAB6C1" alt="Proposed logo" width="200" height="auto"/>

  
</div>
  
  
  
  
##### iOS:


<div style="display:inline;">
  
<img src="https://scontent.fqsf1-2.fna.fbcdn.net/v/t1.15752-9/198962415_127764892779126_2464387835287280312_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeGHu_HfcXdKUeK3dRbreQum99E5H5bmOCn30TkfluY4KRA1l4FHb5eCPYB36FU_aq2aZqa1_2DqECqw_Rcq-f-l&_nc_ohc=Wd2kyBfTaN0AX_a_UkS&_nc_ht=scontent.fqsf1-2.fna&oh=14c2780be73b68839ff659b8690b93e3&oe=60C9336D" alt="Proposed logo" width="200" height="auto"/>

<img src="https://scontent.fqsf1-1.fna.fbcdn.net/v/t1.15752-9/131534375_544230210076664_3111012749168193183_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeEBlGwu3Cxn1s2TUwH6Fzv1aoB5ECXblLZqgHkQJduUtiT2jPdJ2YBZrSEyYxcN2Lzu4UwHOJcSqV0U5Y-u37MQ&_nc_ohc=eMyIIibmAI8AX-K4dIP&tn=BpJPJC4DUrz6hD8l&_nc_ht=scontent.fqsf1-1.fna&oh=5de241bb03ed0c179859f47142f748e8&oe=60CA4B04" alt="Proposed logo" width="200" height="auto"/>
  
<img src="https://scontent.fqsf1-1.fna.fbcdn.net/v/t1.15752-9/200896645_518900919522859_2616141938859422692_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeFVw0tbhmJRy_j9zsQX0R9GurMCrVEbg_y6swKtURuD_GLgkHBkW49UBkjDBBwoeGktbxdOx4SrFMwG-ZZpcAjp&_nc_ohc=9ark9g96ZPAAX9e2vuv&_nc_ht=scontent.fqsf1-1.fna&oh=6c07052dff623d0d3177e200e76a9527&oe=60CA9BE9" alt="Proposed logo" width="200" height="auto"/>

<img src="https://scontent.fqsf1-2.fna.fbcdn.net/v/t1.15752-9/198848093_371283914328851_7055100332624269840_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeHeK4RBEzlDEHykIWiB2aVTBJTlasfcIe8ElOVqx9wh73n4yLiVgaH15o63s0zlC-KnRca_i5EcyGNCch8atNA2&_nc_ohc=qgInPapEVwAAX_i2j1w&_nc_oc=AQn1WI5U07wL__G3hiXgDkpzeWyKHlwaTcjL0FutdyB_-NfP-NVAJVz_W_yi1cEstes&_nc_ht=scontent.fqsf1-2.fna&oh=46bfe4d0196b267eabc5a381846d3b6e&oe=60C92479" alt="Proposed logo" width="200" height="auto"/>

<img src="https://scontent.fqsf1-2.fna.fbcdn.net/v/t1.15752-9/199463347_171184598299190_1809250717663546157_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeF4RchPydzMHrOeF3nwpSvGgMe2uKgE--aAx7a4qAT75ufnG6RkG7FSMdeEOjMW0o2pnSa7T8ZwkCX3SVGWLbl9&_nc_ohc=WTv2XQ9kMgUAX9Obo4d&_nc_ht=scontent.fqsf1-2.fna&oh=66c6519b4c6bf1f892e4104193b5f669&oe=60C99530" alt="Proposed logo" width="200" height="auto"/>
  
  
<img src="https://scontent.fqsf1-1.fna.fbcdn.net/v/t1.15752-9/199819233_193813362625391_7251187162753460653_n.jpg?_nc_cat=103&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeHUmuUHrn_77XMTI1TC6smQf_OQp40u8VZ_85CnjS7xVtz2pQ_oXPD9uec3Jjg4t8VA04HnhwyfgtJTVbtaey5l&_nc_ohc=uUQUz8qVsx4AX-K_-hg&_nc_ht=scontent.fqsf1-1.fna&oh=bb0db43b60fe4636245402d4c4986476&oe=60CA663E" alt="Proposed logo" width="200" height="auto"/>
  
<img src="https://scontent.fqsf1-2.fna.fbcdn.net/v/t1.15752-9/200271957_385582109537777_7709735008606902838_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeG0eOi9zF90yW8ZKCrXSFvVzeyboteESX_N7Jui14RJf4UHEQN8Ao_22pzftSBU5eRrYErRB_KhSQB8UEk4Fq3s&_nc_ohc=iTjG4eNKeIgAX8BN95-&_nc_ht=scontent.fqsf1-2.fna&oh=6deb7bf817f549b57de34d53a8e00416&oe=60CAB738" alt="Proposed logo" width="200" height="auto"/>
  
<img src="https://scontent.fqsf1-2.fna.fbcdn.net/v/t1.15752-9/199306418_913289619243052_8529396939748526432_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=ae9488&_nc_eui2=AeGA0woCPqlxq8J1hjs2l7M5eKIp4Rnoj5R4oinhGeiPlOqSFtLqBJoZxdJiiH_AzIwp6EQWvLlV46SGU5gc4GY0&_nc_ohc=bFwf3SsDyRQAX_S8pZ-&_nc_oc=AQnPXXDrjxNapF7TPVvb5RXMqX8TsuZklS0jbOnvYLgy_pjnpr10Zk4lu-gqbgJbrIY&_nc_ht=scontent.fqsf1-2.fna&oh=13ae6e0878878ea9c56a73e31ed2a695&oe=60C9C83B" alt="Proposed logo" width="200" height="auto"/>

  
</div>
