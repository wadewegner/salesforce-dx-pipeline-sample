
@isTest
private class DemoControllerTests {
    @isTest static void testGetAppVersion() {
        DemoController demo = new DemoController(); //23423432
        System.assertEquals(demo.getAppVersion(), '1.0.0');
    }
}
