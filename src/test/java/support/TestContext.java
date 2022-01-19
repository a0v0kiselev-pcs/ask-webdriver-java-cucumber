// Created by Viacheslav (Slava) Skryabin 04/01/2011
package support;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.Platform;
import org.openqa.selenium.Point;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeDriverService;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.firefox.FirefoxBinary;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.safari.SafariDriver;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class TestContext {

    private static WebDriver driver = null;
    private static Runnable driverCreation = null;
    private static Runnable driverOnScenarioStart = null;
    private static Object driverOptions = null;

    private static void cleanup() {
        driver = null;
        driverCreation = null;
        driverOnScenarioStart = null;
        driverOptions = null;
    }

    public static WebDriver getDriver() {
        if (driver == null) {
            driverCreation.run();
            if (driverOnScenarioStart != null) {
                driverOnScenarioStart.run();
                driverOnScenarioStart = null;
            }
        }
        return driver;
    }

    /**
     * A way to modify web driver options in step definitions.
     * <p>
     * Call {@link #reapplyDriverOptions()} to reapply.
     *
     * @return current web driver options
     */
    public static Object getDriverOptions() {
        return driverOptions;
    }

    /**
     * To be called on scenario start.
     *
     * @param v Code to be executed on first browser start during scenario execution.
     */
    public static void setDriverOnScenarioStart(final Runnable v) {
        driverOnScenarioStart = v;
    }

    /**
     * Reapplies the web driver options. The browser will exit and start on the next {@link #getDriver()}.
     */
    public static void reapplyDriverOptions() {
        if (driverCreation != null) {
            if (driver != null) {
                driver.quit();
                driver = null;
            }
        }
    }

    public static void initialize() {
        initialize("chrome", "local", false);
    }

    public static void teardown() {
        driver.quit();
        cleanup();
    }

    public static void initialize(final String browser, final String testEnv, final boolean isHeadless) {
        cleanup();
        final Dimension size = new Dimension(1920, 1080);
        final Point position = new Point(0, 0);
        if (testEnv.equals("local")) {
            switch (browser) {
                case "chrome":
                    WebDriverManager.chromedriver().setup();
                    final Map<String, Object> chromePreferences = new HashMap<>();
                    chromePreferences.put("profile.default_content_settings.geolocation", 2);
                    chromePreferences.put("download.prompt_for_download", false);
                    chromePreferences.put("download.directory_upgrade", true);
                    chromePreferences.put("credentials_enable_service", false);
                    chromePreferences.put("password_manager_enabled", false);
                    final ChromeOptions chromeOptions = new ChromeOptions();
                    chromeOptions.addArguments("--start-maximized");
                    chromeOptions.setExperimentalOption("prefs", chromePreferences);
                    System.setProperty(ChromeDriverService.CHROME_DRIVER_SILENT_OUTPUT_PROPERTY, "true");
                    if (isHeadless) {
                        chromeOptions.setHeadless(true);
                        chromeOptions.addArguments("--window-size=" + size.getWidth() + "," + size.getHeight());
                        chromeOptions.addArguments("--disable-gpu");
                    }
                    driverOptions = chromeOptions;
                    driverCreation = () -> driver = new ChromeDriver(chromeOptions);
                    break;
                case "firefox":
                    WebDriverManager.firefoxdriver().setup();
                    final FirefoxOptions firefoxOptions = new FirefoxOptions();
                    if (isHeadless) {
                        final FirefoxBinary firefoxBinary = new FirefoxBinary();
                        firefoxBinary.addCommandLineOptions("--headless");
                        firefoxOptions.setBinary(firefoxBinary);
                    }
                    driver = new FirefoxDriver(firefoxOptions);
                    break;
                case "safari":
                    driver = new SafariDriver();
                    driver.manage().window().setPosition(position);
                    driver.manage().window().setSize(size);
                    break;
                case "edge":
                    WebDriverManager.edgedriver().setup();
                    driver = new EdgeDriver();
                    break;
                case "ie":
                    WebDriverManager.iedriver().setup();
                    driver = new InternetExplorerDriver();
                    break;
                default:
                    throw new RuntimeException("Driver is not implemented for: " + browser);
            }
        } else if (testEnv.equals("grid")) {
            final DesiredCapabilities capabilities = new DesiredCapabilities();
            capabilities.setBrowserName(browser);
            capabilities.setPlatform(Platform.ANY);
            try {
                final URL hubUrl = new URL("http://localhost:4444/wd/hub");
                driver = new RemoteWebDriver(hubUrl, capabilities);
            } catch (final MalformedURLException e) {
                throw new RuntimeException(e.getMessage());
            }
        } else {
            throw new RuntimeException("Unsupported test environment: " + testEnv);
        }
    }
}
