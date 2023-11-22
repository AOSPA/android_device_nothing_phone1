package com.nothing;

import android.os.Build;
import android.os.SystemProperties;

import java.util.BitSet;

public class NtFeaturesUtils {

    private static final BitSet sFeatures = new BitSet(38);

    static {
        final String fullProp = SystemProperties.get("ro.build.nothing.feature.base", "0");
        final String productDiffProp = SystemProperties.get("ro.build.nothing.feature.diff.product." + Build.PRODUCT, "0");
        final String deviceDiffProp = SystemProperties.get("ro.build.nothing.feature.diff.device." + Build.DEVICE, "0");

        base(Long.decode(fullProp).longValue());
        change(Long.decode(productDiffProp).longValue());
        change(Long.decode(deviceDiffProp).longValue());
    }

    public static boolean isSupport(int... features) {
        for (int feature : features) {
            if (feature < 0 || feature > 37) {
                return false;
            }
            if (!sFeatures.get(feature)) {
                return false;
            }
        }
        return true;
    }

    private static void base(long full) {
        int index = 0;
        while (full != 0) {
            if (full % 2 != 0) {
                sFeatures.set(index);
            }
            index++;
            full >>>= 1;
        }
    }

    private static void change(long diff) {
        int index = 0;
        while (diff != 0) {
            if (diff % 2 != 0) {
                sFeatures.flip(index);
            }
            index++;
            diff >>>= 1;
        }
    }
}
