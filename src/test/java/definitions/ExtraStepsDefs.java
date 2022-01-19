package definitions;

import cucumber.api.java.en.Then;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

import static org.assertj.core.api.Assertions.assertThat;
import static support.TestContext.getDriver;

public class ExtraStepsDefs {
    @Then("I accept form action over HTTP")
    public void iAcceptFormActionOverHttp() {
        final WebDriver webDriver = getDriver();
        if (webDriver instanceof ChromeDriver) {
            final WebElement body = webDriver.findElement(By.xpath("//body[@class='insecure-form']"));
            body.findElement(By.id("proceed-button")).click();
        } else if (webDriver instanceof FirefoxDriver) {
            final Alert alert = getDriver().switchTo().alert();
            if (!alert.getText().startsWith("The information you have entered on this page will be sent over an insecure connection and could be read by a third party."))
                throw new AssertionError("Not an insecure connection alert");
            alert.accept();
        } else {
            throw new UnsupportedOperationException("Unsupported browser: " + webDriver.getClass() +
                    "\nTODO: Implement");
        }
    }

    @Then("element with xpath {string} should not be visible")
    public void elementWithXpathShouldNotBeVisible(final String xpath) {
        try {
            assertThat(getDriver().findElement(By.xpath(xpath)).isDisplayed()).isFalse();
        } catch (final NoSuchElementException ignored) {
        }
    }
}
