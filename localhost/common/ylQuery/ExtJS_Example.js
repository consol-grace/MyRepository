/// <reference path="jquery.ui.custom/js/jquery-1.4.1.js" />
/// <reference path="ext-3.2.0/adapter/ext/ext-base.js" />
/// <reference path="ext-3.2.0/ext-all.js" />


Ext.onReady(function() {
    Ext.QuickTips.init();

    // Go ahead and create the TreePanel now so that we can use it below
    var treePanel = new Ext.tree.TreePanel({ id: 'tree-panel'
        , title: 'Sample Layouts'
        , region: 'west'
        , width: 300
        , margins: '0 0 3 3'
        , collapsible: true
        , split: true
        , height: 720
        //, minSize: 480
        , autoScroll: true

        // tree-specific configs:
        , rootVisible: false
        , lines: false
        , singleExpand: true
        , useArrows: true

        , loader: new Ext.tree.TreeLoader({
            dataUrl: 'tree-data.aspx'
        })

        , root: new Ext.tree.AsyncTreeNode()
    });
    // Assign the changeLayout function to be called on tree node click.
    treePanel.on('click', function(n) {
        var sn = this.selModel.selNode || {}; // selNode is null on initial selection
        if (n.leaf && n.id != sn.id) {  // ignore clicks on folders and currently selected node 

            /*
            Ext.getCmp('content-panel').layout.setActiveItem(n.id + '-panel');
            if (!detailEl) {
            var bd = Ext.getCmp('details-panel').body;
            bd.update('').setStyle('background', '#fff');
            detailEl = bd.createChild(); //create default empty div
            }
            detailEl.hide().update(Ext.getDom(n.id + '-details').innerHTML).slideIn('l', { stopFx: true, duration: .2 });
            */

            alert();
        }
    });

    var FwContent = new Ext.Panel({ id: "FwContent"
        , region: "center"
        , margins: "0 3 3 0"
        , title: "当前位置: 系统管理"
        , html: "Welcome ......"
    });

    var FwViewport = new Ext.Viewport({
        layout: 'border',
        items: [{ region: 'north'
                , height: 30
                , html: '<div>标题</div>'
                , margins: '3 3 3 3'
        }
            , treePanel
            , FwContent]
    });
});



/*
Ext.BLANK_IMAGE_URL = 'ext-3.2.0/resources/images/default/s.gif';
Ext.QuickTips.init();
var left;
Ext.onReady(function() {
    var top = new Ext.Panel({
        region: "north",
        title: "LOGO",
        height: 80,
        html: "这放LOGO"
    });
    left = new Ext.tree.TreePanel({
        region: "west",
        title: "功能导航",
        collapsible: true,
        split: true,
        containerScroll: true,
        autoScroll: true,
        width: 200,
        listeners: {
            dblclick: function(n) {
                var url = n.attributes.url;
                var id = n.attributes.id;
                if (url) {
                    if (center.getItem(id)) {
                        //表示标签已打开，则激活   
                        center.setActiveTab(id);
                    } else {
                        var p = new Ext.Panel({
                            title: n.attributes.text,
                            id: id,
                            autoLoad: { url: url, scripts: true },

                            closable: true
                        });
                        center.add(p);
                        center.setActiveTab(p);
                    }

                }
            }
        }
    });

    var root = new Ext.tree.TreeNode({ id: "1", text: "员工管理系统", leaf: "false" });
    var addEmp = new Ext.tree.TreeNode({ d: "2", text: "新增员工", url: "addemp.jsp" });
    var empList = new Ext.tree.TreeNode({ id: "3", text: "员工信息维护", url: "emplist.html" });

    root.appendChild([addEmp, empList]);
    left.setRootNode(root);

    var center = new Ext.TabPanel({
        region: "center",
        defaults: { autoScroll: true },
        items: [{
            title: "首页",
            html: "欢迎使用本系统！",
            id: "index"
}],
            enableTabScroll: true
        });
        center.setActiveTab("index");

        var bottom = new Ext.Panel({
            region: "south",
            html: "版权所有，翻版必究!",
            bodyStyle: "padding:10px;text-align:center;font-size:12px"
        });

        var vp = new Ext.Viewport({
            layout: "border",
            items: [top, left, center, bottom]
        })
        left.expandAll();

    });
*/
