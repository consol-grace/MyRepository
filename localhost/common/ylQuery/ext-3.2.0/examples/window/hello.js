/*!
 * Ext JS Library 3.2.0
 * Copyright(c) 2006-2010 Ext JS, Inc.
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
Ext.onReady(function(){
    var win;
    var button = Ext.get('show-btn');

    button.on('click', function(){
        // create the window on the first click and reuse on subsequent clicks
        if(!win){
            win = new Ext.Window({
                applyTo:'hello-win',
                layout:'fit',
                width:1000,
                height:500,
                closeAction:'hide',
                plain: true,
				

                items: new Ext.TabPanel({
                    applyTo: 'hello-tabs',
                    autoTabs:true,
                    activeTab:0,
                    deferredRender:false,
                    border:false
                }),
				
				
                buttons: [{
                    text:'OK',
                    disabled:false
                },{
                    text:'Cancel',
                    disabled:false
                }/*,{
                    text: 'Close',
                    handler: function(){
                        win.hide();
                    }
                }*/]});}
        win.show(this);});});