describe("maps", function() {

  beforeEach(function() {
    
  });

  it("should return map positions from reports service", function() {
    jasmine.Ajax.install();

    jasmine.Ajax.stubRequest('/reports').andReturn({
      status: 200,
      statusText: 'HTTP/1.1 200 OK',
      contentType: 'text/json;charset=UTF-8',
      responseText: '[{"id":16,"user_id":40,"recipient_id":null,"category_id":34,"uuid":"38dbce43-2a11-4057-b517-ad77339e2550","description":"Test Report 1","latitude":"-25.363882","longitude":"131.044922","created_at":"2015-07-15T03:46:07.147Z","updated_at":"2015-07-15T03:46:07.147Z","sent_at":null},{"id":17,"user_id":41,"recipient_id":null,"category_id":34,"uuid":"c4e6b3b8-50ba-4406-a881-6ffb62694c26","description":"Test Report 2","latitude":"-26.140","longitude":"153.0333","created_at":"2015-07-15T03:46:07.150Z","updated_at":"2015-07-15T03:46:07.150Z","sent_at":null},{"id":18,"user_id":40,"recipient_id":null,"category_id":36,"uuid":"e932b3fd-bd91-41ae-82f8-5414ab35e6bd","description":"Test Report 3","lat":"-25.363000","long":"153.0200","created_at":"2015-07-15T03:46:07.152Z","updated_at":"2015-07-15T03:46:07.152Z","sent_at":null}]'
    });

    var locations = getMapsDataFromReports()
    expect(locations).not.toEqual([]);
  });

  it("should return html for info window given report without image", function() {
    var markerData = [null,'Category1','Test description'];
    var infoWindowHtml = generateInfoWindowHtml(markerData);
    expect(infoWindowHtml).not.toEqual('');
    expect(infoWindowHtml).toEqual('<div class="info-window"><div class="info-window-text"><h4>Issue</h4><p>Category1</p>' 
    + '<h4>Description</h4><p>Test description</p><h4>Address</h4><p>Test street</p></div>'
    + '<div class="info-window-image"><img src="http://i.imgur.com/CfmbeXi.jpg"></img></div></div>');
  });
});
