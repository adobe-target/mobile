# Target Libraries for Mobile Visual Experience Composer
Welcome to the private beta for Target Mobile VEC. Mobile VEC enables marketing teams to deploy experiments and personalize experiences using a WYSIWYG interface.

Latest packages for download:  
**[Android Library](https://github.com/adobe-target/mobile/raw/master/mobile-vec/AdobeTargetMobileVEC-Android.18.8.zip)**  
**[iOS Library](https://github.com/adobe-target/mobile/raw/master/mobile-vec/AdobeTargetMobileVEC-iOS-18.8.zip)**

## Release Notes - 10th August, 2018
### Major Features
* Click Tracking is now supported for Mobile VEC activities using the same WYSIWYG interface.
* Additional configuration for the mid-tier URL will no longer be required after the general Target release on August 22nd, 2018.

### Android
* In Authoring default content was displayed when back button is pressed and app is opened again
* Fix issues in converting spannable TextView content to/from HTML
* Offers on views other than current view are not reset to default content when activity authoring is complete
* Add support for Preview for Visual Activities on mobile device
* Provide support for clickTracking as a metric
* Handle ungrouped click track notifications
* Enable StrictMode, fix leaks and refactor Target request handling
* Mid-tier URL is not required in the configs - available after August 22nd, 2018.
* Reset authoring state when SDK config changes
* Offers/notifications are not fired on second screen if offers/notifications are applied on landing screen

### iOS
* Text formatting bugs: Font size during Authoring
* Blank text action should not lead to inconsistent experience
* Provide support for clickTracking as a metric
* Swapped Images being delivered randomly from different activities for same elements
* Removed perform click code
* Correct view name on switching views quickly
* Duplicate offers for same selector
* Removed unwanted parameters
* Background color of the text was not working after setting a large font size
* Underline and background color issue fixed
* Collision of offers for activities with different priorities handled