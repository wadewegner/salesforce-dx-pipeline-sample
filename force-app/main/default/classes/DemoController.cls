public with sharing class DemoController {
    /**
     * An empty constructor for the testing
     */
    public DemoController() {}

    public String myNewMethod() {
        return 'New Method';
    }

    /**
     * Get the version of the SFDX demo app
     */
    public String getAppVersion() {
        return '1.0.0';
    }
}
