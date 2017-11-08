	/*!
	* Ext JS Library 3.2.0
	* Copyright(c) 2006-2010 Ext JS, Inc.
	* licensing@extjs.com
	* http://www.extjs.com/license
	*/
	
	Ext.onReady(function(){
	var items = [];
	
	Ext.QuickTips.init();
	
	
	/*items.push({
	xtype: 'form',
	id: 'form-widgets',
	title: 'Form Widgets',
	width: 630,
	height: 700,
	frame: true,
	x: 50, y: 50,
	 tools: [
	{id:'toggle'},{id:'close'},{id:'minimize'},{id:'maximize'},{id:'restore'},{id:'gear'},{id:'pin'},
	{id:'unpin'},{id:'right'},{id:'left'},{id:'up'},{id:'down'},{id:'refresh'},{id:'minus'},{id:'plus'},
	{id:'help'},{id:'search'},{id:'save'},{id:'print'}
	],
	bodyStyle: {
	padding: '10px 20px'
	},
	defaults: {
	anchor: '98%',
	msgTarget: 'side',
	allowBlank: false
	},
	items: [{
	xtype: 'label',
	text: 'Plain Label'
	},{
	fieldLabel: 'TextField',
	xtype: 'textfield',
	emptyText: 'Enter a value',
	itemCls: 'x-form-required'
	},{
	fieldLabel: 'ComboBox',
	xtype: 'combo',
	store: ['Foo', 'Bar'],
	itemCls: 'x-form-required',
	resizable: true
	},{
	fieldLabel: 'DateField',
	itemCls: 'x-form-required',
	xtype: 'datefield'
	},{
	fieldLabel: 'TimeField',
	itemCls: 'x-form-required',
	xtype: 'timefield'
	},{
	fieldLabel: 'NumberField',
	emptyText: '(This field is optional)',
	allowBlank: true,
	xtype: 'numberfield'
	},{
	fieldLabel: 'TextArea',
	//msgTarget: 'under',
	itemCls: 'x-form-required',
	xtype: 'textarea',
	cls: 'x-form-valid',
	value: 'This field is hard-coded to have the "valid" style (it will require some code changes to add/remove this style dynamically)'
	},{
	fieldLabel: 'Checkboxes',
	xtype: 'checkboxgroup',
	columns: [100,100],
	items: [{boxLabel: 'Foo', checked: true},{boxLabel: 'Bar'}]
	},{
	fieldLabel: 'Radios',
	xtype: 'radiogroup',
	columns: [100,100],
	items: [{boxLabel: 'Foo', checked: true, name: 'radios'},{boxLabel: 'Bar', name: 'radios'}]
	},{
	hideLabel: true,
	xtype: 'htmleditor',
	value: 'Mouse over toolbar for tooltips.<br /><br />The HTMLEditor IFrame requires a refresh between a stylesheet switch to get accurate colors.',
	height: 110,
	handler: function(){
	Ext.get('styleswitcher').on('click', function(e){
	Ext.getCmp('form-widgets').getForm().reset();
	});
	}
	},{
	title: 'Plain Fieldset',
	xtype: 'fieldset',
	height: 50
	},{
	title: 'Collapsible Fieldset',
	xtype: 'fieldset',
	collapsible: true,
	height: 50
	},{
	title: 'Checkbox Fieldset',
	xtype: 'fieldset',
	checkboxToggle: true,
	height: 50
	}],
	buttons: [{
	text:'Toggle Enabled',
	cls: 'x-icon-btn',
	iconCls: 'x-icon-btn-toggle',
	handler: function(){
	Ext.getCmp('form-widgets').getForm().items.each(function(ctl){
	ctl.setDisabled(!ctl.disabled);
	});
	}
	},{
	text: 'Reset Form',
	cls: 'x-icon-btn',
	iconCls: 'x-icon-btn-reset',
	handler: function(){
	Ext.getCmp('form-widgets').getForm().reset();
	}
	},{
	text:'Validate',
	cls: 'x-icon-btn',
	iconCls: 'x-icon-btn-ok',
	handler: function(){
	Ext.getCmp('form-widgets').getForm().isValid();
	}
	}]
	});*/
	
	
	//=============================================================
	// BorderLayout
	//=============================================================
	items.push({
	xtype: 'panel',
	width: 1000,
	height: 500,
	title: 'Lot#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;HKGAI012342 ',
	x: 50, y:800,
	layout: 'border',
	defaults: {
	collapsible: false,
	split: false
	},
	items: [ 
	{
	
	region: 'west',	
	margins: '5 5 0 5',
	width: 500
	},{
	region: 'center',
	collapsible: false,
	margins: '5 5 0 0'
	
	},{ region: 'east',
	margins: '5 5 0 0',
	width: 250
	},{
	region: 'south',
	margins: '5 5 5 5',
	height: 250	
	}/*{xtype:'tabpanel',
	activeTab:0,
	height:300,
	width:700,
	style:'padding-left:5px; padding-right:5px; padding-bottom:5px; padding-top:5px',
	defaults:{dadystyle:'padding:10px;'},
	items: [{
	title: 'Tab 1',
	html: 'Free-standing tab panel'
	},{
	title: 'Tab 2',
	html:'Nice'
	
	},{
	title: 'Tab 3',
	closable: false,
	html:'Good Lucky'
	}]
	}*/
	
	
	
	]
	});
	
	
	
	//=============================================================
	// Tabs
	//=============================================================
	var tabCfg = {
	xtype: 'tabpanel',
	activeTab: 0,
	width: 310,
	height: 150,
	defaults: {
	bodyStyle: 'padding:10px;'
	},
	items: [{
	title: 'HBL01',
	html: 'Free-standing tab panel'
	},{
	title: 'HBL02',
	html:'Nice'
	
	},{
	title: 'HBL03',
	closable: false,
	html:'Good Lucky'
	},{
	title: '+',
	closable: false
	
	}
	]
	};
	
	items.push(Ext.apply({
	plain: true,
	x: 370, y: 1400
	}, tabCfg));
	
	
	
	
	
	
	//=============================================================
	// Render everything!
	//=============================================================
	new Ext.Viewport({
	layout: 'absolute',
	//cls: 'x-layout-grid',
	autoScroll: true,
	items: items
	});
	
	Ext.getCmp('menu-btn').showMenu();
	
	//=============================================================
	// Stylesheet Switcher
	//=============================================================
	Ext.get('styleswitcher_select').on('change',function(e,select){
	var name = select[select.selectedIndex].value;
	setActiveStyleSheet(name);
	});
	
	var cookie = readCookie("style");
	var title = cookie ? cookie : getPreferredStyleSheet();
	Ext.get('styleswitcher_select').dom.value=title;
	});