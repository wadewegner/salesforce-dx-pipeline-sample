
@isTest
private class DemoControllerTests {
    @isTest static void testGetAppVersion() {
        DemoController demo = new DemoController();
        System.assertEquals(demo.getAppVersion(), '1.0.0');
    }
}
