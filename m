From: conchur@web.de
Subject: REGRESSION: implied: we have to make the false states match as well
Date: Sun, 20 Mar 2016 15:48:23 +0100
Message-ID: <trinity-31872b6a-6152-4832-aeb5-7ad863fb4a89-1458485302988@3capp-webde-bap48>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:51079 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755708AbcCTOs0 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 Mar 2016 10:48:26 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I've noticed a regression with the commit
0b78084aeb0004db657d6e2d4fa4c17ec9f2e8e5 ("implied: we have to make the
false states match as well"). Now I get multiple false positives when
compiling the kernel with 

make CHECK="smatch -p=kernel --two-passes --file-output"CC="cgcc"

    net/batman-adv/soft-interface.c:894 batadv_softif_slave_add warn: unused return: ret = batadv_hardif_enable_interface()

This would be this function which definitely uses the return

    static int batadv_softif_slave_add(struct net_device *dev,
    				   struct net_device *slave_dev)
    {
    	struct batadv_hard_iface *hard_iface;
    	int ret = -EINVAL;
    
    	hard_iface = batadv_hardif_get_by_netdev(slave_dev);
    	if (!hard_iface || hard_iface->soft_iface)
    		goto out;
    
    	ret = batadv_hardif_enable_interface(hard_iface, dev->name);
    
    out:
    	if (hard_iface)
    		batadv_hardif_put(hard_iface);
    	return ret;
    }

Or:

    net/batman-adv/bat_iv_ogm.c:1481 batadv_iv_ogm_process_per_outif warn: unused return: router_router = batadv_orig_router_get()

which would be this snippet:

    	router = batadv_orig_router_get(orig_node, if_outgoing);
    	if (router) {
    		router_router = batadv_orig_router_get(router->orig_node,
    						       if_outgoing);
    		router_ifinfo = batadv_neigh_ifinfo_get(router, if_outgoing);
    	}
    
    	if ((router_ifinfo && router_ifinfo->bat_iv.tq_avg != 0) &&
    	    (batadv_compare_eth(router->addr, ethhdr->h_source)))
    		is_from_best_next_hop = true;
