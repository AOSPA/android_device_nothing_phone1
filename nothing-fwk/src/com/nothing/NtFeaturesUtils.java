package com.nothing;

import android.os.Build;
import android.os.SystemProperties;

import java.math.BigInteger;
import java.util.BitSet;

public class NtFeaturesUtils {

    private static final BitSet sFeatures = new BitSet(79);

    static {
        final String fullProp = SystemProperties.get("ro.build.nothing.feature.base", "0");
        final String productDiffProp = SystemProperties.get("ro.build.nothing.feature.diff.product." + Build.PRODUCT, "0");
        final String deviceDiffProp = SystemProperties.get("ro.build.nothing.feature.diff.device." + Build.DEVICE, "0");

        base(new BigInteger(replace(fullProp), 16));
        change(new BigInteger(replace(productDiffProp), 16));
        change(new BigInteger(replace(deviceDiffProp), 16));
    }

    public static boolean isSupport(int... features) {
        for (int feature : features) {
            if (feature < 0 || feature > 78) {
                return false;
            }
            if (!sFeatures.get(feature)) {
                return false;
            }
        }
        return true;
    }

    private static void base(BigInteger bi) {
        int index = 0;
        while (!bi.equals(BigInteger.ZERO)) {
            if (bi.testBit(0)) {
                sFeatures.set(index);
            }
            index++;
            bi = bi.shiftRight(1);
        }
    }

    private static void change(BigInteger bi) {
        int index = 0;
        while (!bi.equals(BigInteger.ZERO)) {
            if (bi.testBit(0)) {
                sFeatures.flip(index);
            }
            index++;
            bi = bi.shiftRight(1);
        }
    }

    private static String replace(String str) {
        if (str == null) {
            return "";
        }
        return str.replace("0x", "").replace("L", "");
    }
}
