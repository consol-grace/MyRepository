[{ text: '系统管理'
   ,expanded: true
   ,children: [{ text:'系统配置' 
        ,expanded: true 
        ,children:[{ text: '配置维护'
            ,id: 'fwMenu_systemConfiguration'
            ,url: 'http://localhost:83/Framework/Configuration/list.aspx'
            ,leaf: true
        }]
        },{ text:'菜单管理'
            ,children:[{ text: '菜单维护'
                ,id: 'fwMenu_menuManager'
                ,url: 'http://localhost:83/Framework/Menu/list.aspx'
                ,leaf: true
            }]
        },{ text:'用户管理'
            ,children:[{ text: '用户维护'
                ,id: 'fwMenu_userManager'
                ,url: 'http://localhost:83/Framework/User/list.aspx'
                ,leaf: true
            }]
        },{ text: '群组管理'
            ,children:[{ text: '群组维护'
                ,id: 'fwMenu_groupManager'
                ,url: 'http://localhost:83/Framework/Group/Glist.aspx'
                ,leaf: true
            }]
        },{ text: '权限管理'
            ,children:[{ text:'权限维护'
                ,id: 'fwMenu_authorityManager'
                ,url: 'http://localhost:83/Framework/Permission/list.aspx'
                ,leaf: true
            }]
        },{ text:'公司管理'
            ,children:[{ text:'公司维护'
                ,id: 'fwMenu_companyManager'
                ,url: 'http://localhost:83/Framework/Company/list.aspx'
                ,leaf: true
        }]
    }]
}, { text: '基本资料'
   ,children: [{ text:'供应商' 
        ,expanded: true 
        ,children:[{ text: '供应商维护'
            ,id: 'fwMenu_supplierManager'
            ,url: 'http://localhost:83/Framework/Configuration/list.aspx'
            ,leaf: true
        }]        
    }]
}]