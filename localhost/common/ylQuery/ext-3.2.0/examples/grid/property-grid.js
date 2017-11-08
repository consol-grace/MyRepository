
Ext.onReady(function(){
    
    var propsGrid= new Ext.grid.PropertyGrid({
        renderTo: 'prop-grid',
        width: 700,
        autoHeight: true,
   
        source: {
            '1': 'Properties Grid',
            2: false,
            3: true,
            4: false,
            5: new Date(Date.parse('10/15/2006')),
            6: false,
            7: 0.01,
            8: 1
        },
        viewConfig : {
            forceFit: true,
            scrollOffset:0 // the grid will never have scrollbars
        }
    });

  
});