import 'package:flutter/material.dart';

// =============================================================================
// APP SIZE CONSTANTS
// A centralized file for all UI sizing, spacing, and layout constants.
// Use these instead of hardcoded values to keep the UI consistent and scalable.
// =============================================================================

// =============================================================================
// PADDING CONSTANTS
// Use EdgeInsets with these values for consistent padding across the app.
// =============================================================================
const EdgeInsets kPaddingAllSmall   = EdgeInsets.all(kSpaceSmall);    // 8
const EdgeInsets kPaddingAllMedium  = EdgeInsets.all(kSpaceMedium);   // 16
const EdgeInsets kPaddingAllLarge   = EdgeInsets.all(kSpaceLarge);    // 24

const EdgeInsets kPaddingHSmall     = EdgeInsets.symmetric(horizontal: kSpaceSmall);   // h: 8
const EdgeInsets kPaddingHMedium    = EdgeInsets.symmetric(horizontal: kSpaceMedium);  // h: 16
const EdgeInsets kPaddingHLarge     = EdgeInsets.symmetric(horizontal: kSpaceLarge);   // h: 24

const EdgeInsets kPaddingVSmall     = EdgeInsets.symmetric(vertical: kSpaceSmall);     // v: 8
const EdgeInsets kPaddingVMedium    = EdgeInsets.symmetric(vertical: kSpaceMedium);    // v: 16
const EdgeInsets kPaddingVLarge     = EdgeInsets.symmetric(vertical: kSpaceLarge);     // v: 24

const EdgeInsets kPaddingSymSmall   = EdgeInsets.symmetric(horizontal: kSpaceSmall,  vertical: kSpaceXSmall);  // h: 8,  v: 4
const EdgeInsets kPaddingSymMedium  = EdgeInsets.symmetric(horizontal: kSpaceMedium, vertical: kSpaceSmall);   // h: 16, v: 8
const EdgeInsets kPaddingSymLarge   = EdgeInsets.symmetric(horizontal: kSpaceLarge,  vertical: kSpaceMedium);  // h: 24, v: 16

// =============================================================================
// SPACING VALUES
// Raw double values used for padding, margin, gap, etc.
// =============================================================================
const double kSpaceXSmall  = 4.0;
const double kSpaceSmall   = 8.0;
const double kSpaceMedium  = 16.0;
const double kSpaceLarge   = 24.0;
const double kSpaceXLarge  = 32.0;
const double kSpaceXXLarge = 48.0;

// =============================================================================
// HEIGHT CONSTANTS
// Use for fixed-height containers, cards, images, etc.
// =============================================================================
const double kHeight4  = 4.0;
const double kHeight8  = 8.0;
const double kHeight10 = 10.0;
const double kHeight12 = 12.0;
const double kHeight16 = 16.0;
const double kHeight20 = 20.0;
const double kHeight24 = 24.0;
const double kHeight32 = 32.0;
const double kHeight40 = 40.0;
const double kHeight48 = 48.0;
const double kHeight56 = 56.0;
const double kHeight64 = 64.0;
const double kHeight80 = 80.0;
const double kHeight100 = 100.0;
const double kHeight120 = 120.0;
const double kHeight150 = 150.0;
const double kHeight200 = 200.0;

// =============================================================================
// WIDTH CONSTANTS
// Use for fixed-width containers, buttons, icons, etc.
// =============================================================================
const double kWidth4   = 4.0;
const double kWidth8   = 8.0;
const double kWidth10  = 10.0;
const double kWidth12  = 12.0;
const double kWidth16  = 16.0;
const double kWidth20  = 20.0;
const double kWidth24  = 24.0;
const double kWidth32  = 32.0;
const double kWidth40  = 40.0;
const double kWidth48  = 48.0;
const double kWidth56  = 56.0;
const double kWidth64  = 64.0;
const double kWidth80  = 80.0;
const double kWidth100 = 100.0;
const double kWidth120 = 120.0;
const double kWidth150 = 150.0;
const double kWidth200 = 200.0;

// =============================================================================
// FONT SIZE CONSTANTS
// Use these for consistent text sizing across the app.
// =============================================================================
const double kFontXSmall  = 10.0;  // captions, labels
const double kFontSmall   = 12.0;  // helper text, metadata
const double kFontMedium  = 14.0;  // body text, regular
const double kFontBase    = 16.0;  // default readable size
const double kFontLarge   = 18.0;  // subheadings
const double kFontXLarge  = 20.0;  // section titles
const double kFontXXLarge = 24.0;  // page titles
const double kFontDisplay = 28.0;  // hero / display text
const double kFontHero    = 32.0;  // extra-large display

// =============================================================================
// ICON SIZE CONSTANTS
// Use for Icon widget's size parameter.
// =============================================================================
const double kIconXSmall = 14.0;
const double kIconSmall  = 18.0;
const double kIconMedium = 24.0;  // default Flutter icon size
const double kIconLarge  = 32.0;
const double kIconXLarge = 40.0;
const double kIconHuge   = 56.0;

// =============================================================================
// BORDER RADIUS CONSTANTS
// Use BorderRadius.circular(kRadius*) for rounded corners.
// =============================================================================
const double kRadiusXSmall = 4.0;
const double kRadiusSmall  = 8.0;
const double kRadiusMedium = 12.0;
const double kRadiusLarge  = 16.0;
const double kRadiusXLarge = 24.0;
const double kRadiusFull   = 100.0; // pill / circle shape

// Pre-built BorderRadius objects for convenience
const BorderRadius kBorderRadiusXSmall = BorderRadius.all(Radius.circular(kRadiusXSmall));
const BorderRadius kBorderRadiusSmall  = BorderRadius.all(Radius.circular(kRadiusSmall));
const BorderRadius kBorderRadiusMedium = BorderRadius.all(Radius.circular(kRadiusMedium));
const BorderRadius kBorderRadiusLarge  = BorderRadius.all(Radius.circular(kRadiusLarge));
const BorderRadius kBorderRadiusXLarge = BorderRadius.all(Radius.circular(kRadiusXLarge));
const BorderRadius kBorderRadiusFull   = BorderRadius.all(Radius.circular(kRadiusFull));

// =============================================================================
// SIZEBOX SPACING WIDGETS
// Drop these directly into Column / Row as gap widgets — no boilerplate needed.
// =============================================================================

// Vertical gaps (height)
const SizedBox kGapH4   = SizedBox(height: kHeight4);
const SizedBox kGapH8   = SizedBox(height: kHeight8);
const SizedBox kGapH10  = SizedBox(height: kHeight10);
const SizedBox kGapH12  = SizedBox(height: kHeight12);
const SizedBox kGapH16  = SizedBox(height: kHeight16);
const SizedBox kGapH20  = SizedBox(height: kHeight20);
const SizedBox kGapH24  = SizedBox(height: kHeight24);
const SizedBox kGapH32  = SizedBox(height: kHeight32);
const SizedBox kGapH40  = SizedBox(height: kHeight40);
const SizedBox kGapH48  = SizedBox(height: kHeight48);

// Vertical aliases (shorter names)
const SizedBox height4  = SizedBox(height: kHeight4);
const SizedBox height8  = SizedBox(height: kHeight8);
const SizedBox height10 = SizedBox(height: kHeight10);
const SizedBox height12 = SizedBox(height: kHeight12);
const SizedBox height16 = SizedBox(height: kHeight16);
const SizedBox height20 = SizedBox(height: kHeight20);
const SizedBox height24 = SizedBox(height: kHeight24);
const SizedBox height32 = SizedBox(height: kHeight32);
const SizedBox height40 = SizedBox(height: kHeight40);
const SizedBox height48 = SizedBox(height: kHeight48);

// Horizontal gaps (width)
const SizedBox kGapW4   = SizedBox(width: kWidth4);
const SizedBox kGapW8   = SizedBox(width: kWidth8);
const SizedBox kGapW10  = SizedBox(width: kWidth10);
const SizedBox kGapW12  = SizedBox(width: kWidth12);
const SizedBox kGapW16  = SizedBox(width: kWidth16);
const SizedBox kGapW20  = SizedBox(width: kWidth20);
const SizedBox kGapW24  = SizedBox(width: kWidth24);
const SizedBox kGapW32  = SizedBox(width: kWidth32);
const SizedBox kGapW40  = SizedBox(width: kWidth40);

// Horizontal aliases
const SizedBox width4   = SizedBox(width: kWidth4);
const SizedBox width8   = SizedBox(width: kWidth8);
const SizedBox width10  = SizedBox(width: kWidth10);
const SizedBox width12  = SizedBox(width: kWidth12);
const SizedBox width16  = SizedBox(width: kWidth16);
const SizedBox width20  = SizedBox(width: kWidth20);
const SizedBox width24  = SizedBox(width: kWidth24);
const SizedBox width32  = SizedBox(width: kWidth32);
const SizedBox width40  = SizedBox(width: kWidth40);
