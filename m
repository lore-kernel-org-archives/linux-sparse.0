From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: False warning from Sparse
Date: Sat, 21 Jul 2012 22:52:54 -0500
Message-ID: <500B7916.6060804@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Hi,

I am getting the following false warning from sparse:

   CHECK   drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c
drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c:1158:13: warning: context 
imbalance in 'rtl92c_dm_refresh_rate_adaptive_mask' - different lock contexts 
for basic block

The only code in that routine that does any locking is the following:

              /* Only the PCI card uses sta in the update rate table
               * callback routine */
              if (rtlhal->interface == INTF_PCI) {
                      rcu_read_lock();
                      sta = ieee80211_find_sta(mac->vif, mac->bssid);
              }
              rtlpriv->cfg->ops->update_rate_tbl(hw, sta,
                                   p_ra->ratr_state);

              p_ra->pre_ratr_state = p_ra->ratr_state;
              if (rtlhal->interface == INTF_PCI)
                      rcu_read_unlock();

Does the warning get output because the code cannot assume that 
rtlhal->interface is the same in both if statements? If that is the case, are 
there any compiler directives that would tell sparse of the situation?

Thanks,

Larry
