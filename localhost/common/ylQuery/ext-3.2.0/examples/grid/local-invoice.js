/*!
 * Ext JS Library 3.2.0
 * Copyright(c) 2006-2010 Ext JS, Inc.
 * licensing@extjs.com
 * http://www.extjs.com/license
 */

Ext.onReady(function() {

    Ext.QuickTips.init();

    var xg = Ext.grid;

    // shared reader
    var reader = new Ext.data.ArrayReader({}, [
       { name: '#' },
       { name: 'DN' },
	   { name: 'CN' },
       { name: 'Print'},
	   { name: 'Void' },
       { name: 'AC' }
    ]);


    var sm = new xg.CheckboxSelectionModel();
    var grid2 = new xg.GridPanel({
        store: new Ext.data.Store({
            reader: reader,
            data: xg.dummyData
        }),
        cm: new xg.ColumnModel({
            defaults: {
                width: 120,
                sortable: true
            },
            columns: [
                {header: "#", width: 25, dataIndex: '#'}, 
                {header: 'DN', width:40,dataIndex: ''},
                {header: 'CN', width:40,dataIndex: ''},  
                {header: 'DN/CN No.', width:110,dataIndex: 'DN/CN No.'},    
                {header: 'Company', width:250,dataIndex: 'Company'},
                {header: 'Currency',width:100, dataIndex: 'Currency'},
                {header: 'Amount', width:100,dataIndex: 'Amount'},
				{header: 'Print', width:40,dataIndex: ''},
				{header: 'Void', width:40,dataIndex: ''},
				{header: 'AC', width:40,dataIndex: ''}
 ]
        }),
        sm: sm,
        columnLines: true,
        width: 720,
        height: 175,
        renderTo: "GridView_1",
		title:'Local Invoice'

    });


});



// Array data for the grids
Ext.grid.dummyData = [
    ['1', checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['2', checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['3', checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['4', checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['5', checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['6', checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['7', checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['8', checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
	['9', checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['10',checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['11',checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['12',checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['13',checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['14',checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")],
    ['15',checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active"),checkbox("text-align:center", "Active")]
   
];

// add in some dummy descriptions
for(var i = 0; i < Ext.grid.dummyData.length; i++){
    Ext.grid.dummyData[i].push('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.<br/><br/>Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non, ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt diam nec urna. Curabitur velit.');
}


function checkbox(style, name) {
    return '<div style="'+ style +'" ><input type="checkbox" name="'+ name +'"/></div>';
}
			