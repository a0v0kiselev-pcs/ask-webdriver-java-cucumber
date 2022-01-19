package definitions;

import cucumber.api.java.en.Then;
import org.openqa.selenium.chrome.ChromeOptions;

import java.util.HashMap;
import java.util.Map;

import static support.TestContext.*;

/**
 * Responsive UI testing steps. Chrome only at the moment.
 * <p>
 * See <a href="https://chromedriver.chromium.org/mobile-emulation">https://chromedriver.chromium.org/mobile-emulation</a>
 */
public class ResponsiveUiStepsDefs {
    private static Map<String, Object> getMobileEmulationOptions(final Object o) {
        if (o instanceof ChromeOptions) { // TODO: get rid of deprecated things
            final Map<String, Object> r =
                    (Map<String, Object>) ((ChromeOptions) o).getExperimentalOption("mobileEmulation");
            return r == null ? new HashMap<>() : r;
        }
        throw new UnsupportedOperationException();
    }

    /**
     * Setting up window size is not a way responsive UI can be tested:
     * we simply have no idea of how a particular browser converts screen pixels into actual document pixels.
     * <p>
     * Browser own responsive UI emulation support is absolutely crucial here.
     *
     * @param width
     * @param height
     * @param pixelRatio
     */
    @Then("Use responsive UI {int}X{int}, pixelRatio={float}")
    public void useResponsiveUi(final int width, final int height, final float pixelRatio) {
        final Object options = getDriverOptions();
        if (options instanceof ChromeOptions) {
            final Map<String, Object> deviceMetrics = new HashMap<>();
            deviceMetrics.put("width", width);
            deviceMetrics.put("height", height);
            deviceMetrics.put("pixelRatio", pixelRatio);
            final Map<String, Object> mobileEmulation = getMobileEmulationOptions(options);
            mobileEmulation.put("deviceMetrics", deviceMetrics);
            ((ChromeOptions) options).setExperimentalOption("mobileEmulation", mobileEmulation);
            reapplyDriverOptions();
        } else {
            throw new UnsupportedOperationException("Unsupported browser: " + getDriver().getClass());
        }
    }

    @Then("Use User-Agent: {string}")
    public void useUserAgent(final String userAgent) {
        final Object options = getDriverOptions();
        if (options instanceof ChromeOptions) {
            final Map<String, Object> mobileEmulation = getMobileEmulationOptions(options);
            mobileEmulation.put("userAgent", userAgent);
            ((ChromeOptions) options).setExperimentalOption("mobileEmulation", mobileEmulation);
            reapplyDriverOptions();
        } else {
            throw new UnsupportedOperationException("Unsupported browser: " + getDriver().getClass());
        }
    }
}
