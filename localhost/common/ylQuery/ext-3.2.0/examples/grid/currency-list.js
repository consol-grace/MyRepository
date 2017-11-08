/*!
 * Ext JS Library 3.2.0
 * Copyright(c) 2006-2010 Ext JS, Inc.
 * licensing@extjs.com
 * http://www.extjs.com/license
 */

Ext.onReady(function(){

    Ext.QuickTips.init();

    var xg = Ext.grid;

    // shared reader
    var reader = new Ext.data.ArrayReader({}, [
       {name: 'Code'},
       {name: 'Description'},
       {name: 'Rate'},
	   {name:'Active'}
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
                {id:'Code',header: "Code", width: 60, dataIndex: 'Code'},        
                {header: "Description", width:134,dataIndex: 'Description'}, 
				{header: "Country",width:80, dataIndex: ''},
                {header: "Rate", width:60,dataIndex: 'Rate'},
				{header: "Sell", width:80,dataIndex: 'Sell'},
				{header: "Buy", width:80,dataIndex: 'Buy'},
				{header: "Active", width:45,dataIndex: 'Active'}
				 

            ]
        }),
        sm: sm,
        columnLines: true,
        width:560,
        height:262,              
        renderTo: "GridView"
		
		
    });

   
});



// Array data for the grids
Ext.grid.dummyData = [
    ['CAD','CAD','6.74', checkbox("text-align:center","Active")],
    ['EUR', 'CAD', '12.5', checkbox("text-align:center", "Active")],
    ['GBP', 'GBP', '14', checkbox("text-align:center", "Active")],
    ['HKD', 'HKD', '1.03', checkbox("text-align:center", "Active")],
    ['RMB', 'RMB', '1', checkbox("text-align:center", "Active")],
    ['USD', 'USD', '7.8', checkbox("text-align:center", "Active")],
	['USD', 'CAD', '7.8', checkbox("text-align:center", "Active")],
	['USD', 'CAD', '7.8', checkbox("text-align:center", "Active")],
	['USD', 'CAD', '7.8', checkbox("text-align:center", "Active")],
	['USD', 'CAD', '7.8', checkbox("text-align:center", "Active")],
	['USD', 'CAD', '7.8', checkbox("text-align:center", "Active")],
	['USD', 'CAD', '7.8', checkbox("text-align:center", "Active")],
	['USD', 'CAD', '7.8', checkbox("text-align:center", "Active")],
	['USD', 'CAD', '7.8', checkbox("text-align:center", "Active")],
	['USD', 'CAD', '7.8', checkbox("text-align:center", "Active")]  
];

// add in some dummy descriptions
for(var i = 0; i < Ext.grid.dummyData.length; i++){
    Ext.grid.dummyData[i].push('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.<br/><br/>Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non, ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt diam nec urna. Curabitur velit.');
}
function checkbox(style, name) { 
return'<div style="'+ style +'"><input type="checkbox" name="'+name+'"/></div>'
}