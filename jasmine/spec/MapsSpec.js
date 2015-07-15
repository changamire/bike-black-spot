describe("maps", function() {

  beforeEach(function() {
    jasmine.Ajax.install();

    jasmine.Ajax.stubRequest('/reports').andReturn({
      status: 200,
      statusText: 'HTTP/1.1 200 OK',
      contentType: 'text/json;charset=UTF-8',
      responseText: '[{"id":16,"user_id":40,"recipient_id":null,"category_id":34,"uuid":"38dbce43-2a11-4057-b517-ad77339e2550","description":"Test Report 1","lat":"-25.363882","long":"131.044922","created_at":"2015-07-15T03:46:07.147Z","updated_at":"2015-07-15T03:46:07.147Z","sent_at":null},{"id":17,"user_id":41,"recipient_id":null,"category_id":34,"uuid":"c4e6b3b8-50ba-4406-a881-6ffb62694c26","description":"Test Report 2","lat":"-26.140","long":"153.0333","created_at":"2015-07-15T03:46:07.150Z","updated_at":"2015-07-15T03:46:07.150Z","sent_at":null},{"id":18,"user_id":40,"recipient_id":null,"category_id":36,"uuid":"e932b3fd-bd91-41ae-82f8-5414ab35e6bd","description":"Test Report 3","lat":"-25.363000","long":"153.0200","created_at":"2015-07-15T03:46:07.152Z","updated_at":"2015-07-15T03:46:07.152Z","sent_at":null}]'
    });
  });

  it("should return map positions from reports service", function() {
    var locations = getMapsLatLongFromReports()
    expect(locations).not.toEqual([]);
  });
});
