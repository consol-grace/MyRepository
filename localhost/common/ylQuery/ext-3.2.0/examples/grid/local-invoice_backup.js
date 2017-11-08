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
       {name: 'company'},
       {name: 'price', type: 'float'},
       {name: 'change', type: 'float'},
       {name: 'pctChange', type: 'float'},
       {name: 'lastChange', type: 'date', dateFormat: 'n/j h:ia'},
       {name: 'industry'},
       {name: 'desc'}
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
                {id:'Conpany',header: "#", width: 19, dataIndex: 'company'}, 
                sm,
                sm,  
                {header: "DN/CN No.", width:110,dataIndex: 'DN/CN No.'},    
                {header: "Company", width:250,dataIndex: 'Company'},
                {header: "Currency",width:100, dataIndex: 'Currency'},
                {header: "Amount", width:100,dataIndex: 'Amount'},
                sm,
                sm,
                sm

            ]
        }),
        sm: sm,
        columnLines: true,
        width:700,
        height:175,              
        renderTo: "GridView_1",
		title:'Local Invoice'
		
    });

   
});



// Array data for the grids
Ext.grid.dummyData = [
    ['1',71.72,0.02,0.03,'9/1 12:00am', 'Manufacturing'],
    ['2',29.01,0.42,1.47,'9/1 12:00am', 'Manufacturing'],
    ['3',83.81,0.28,0.34,'9/1 12:00am', 'Manufacturing'],
    ['4',52.55,0.01,0.02,'9/1 12:00am', 'Finance'],
    ['5',64.13,0.31,0.49,'9/1 12:00am', 'Services'],
    ['6',31.61,-0.48,-1.54,'9/1 12:00am', 'Services']
   
];

// add in some dummy descriptions
for(var i = 0; i < Ext.grid.dummyData.length; i++){
    Ext.grid.dummyData[i].push('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.<br/><br/>Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non, ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt diam nec urna. Curabitur velit.');
}