public with sharing class DemoController {
    /**
     * An empty constructor for the testing
     */
    public DemoController() {}

    public String myNewMethod() {
        return 'New Method';
    }

    public String yetAnotherNewMethod() {
        return 'Changed Yet Another Method';
    }

    public String anotherNewMethod() {
        return 'Another Method';
    }


    /**
     * Get the version of the SFDX demo apps
     */
    public String getAppVersion() {
        return '1.0.0';
    }
}
