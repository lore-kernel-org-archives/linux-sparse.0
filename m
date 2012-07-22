From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: False warning from Sparse
Date: Sat, 21 Jul 2012 21:44:21 -0700
Message-ID: <20120722044421.GA3934@leaf>
References: <500B7916.6060804@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <500B7916.6060804@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Sat, Jul 21, 2012 at 10:52:54PM -0500, Larry Finger wrote:
> I am getting the following false warning from sparse:
> 
>   CHECK   drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c
> drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c:1158:13: warning:
> context imbalance in 'rtl92c_dm_refresh_rate_adaptive_mask' -
> different lock contexts for basic block
> 
> The only code in that routine that does any locking is the following:
> 
>              /* Only the PCI card uses sta in the update rate table
>               * callback routine */
>              if (rtlhal->interface == INTF_PCI) {
>                      rcu_read_lock();
>                      sta = ieee80211_find_sta(mac->vif, mac->bssid);
>              }
>              rtlpriv->cfg->ops->update_rate_tbl(hw, sta,
>                                   p_ra->ratr_state);
> 
>              p_ra->pre_ratr_state = p_ra->ratr_state;
>              if (rtlhal->interface == INTF_PCI)
>                      rcu_read_unlock();
> 
> Does the warning get output because the code cannot assume that
> rtlhal->interface is the same in both if statements?

Correct; sparse does not have enough dataflow analysis to connect the
two if bodies, nor can it verify that nothing between the two changes
rtlhal->interface.

> If that is the
> case, are there any compiler directives that would tell sparse of
> the situation?

No, none of Sparse's directives will let you override this.  However,
you could do something like the following:

              /* Only the PCI card uses sta in the update rate table
               * callback routine */
              if (rtlhal->interface == INTF_PCI) {
                      rcu_read_lock();
                      sta = ieee80211_find_sta(mac->vif, mac->bssid);
                      rtlpriv->cfg->ops->update_rate_tbl(hw, sta, p_ra->ratr_state);
                      p_ra->pre_ratr_state = p_ra->ratr_state;
                      rcu_read_unlock();
              } else {
                      rtlpriv->cfg->ops->update_rate_tbl(hw, sta, p_ra->ratr_state);
                      p_ra->pre_ratr_state = p_ra->ratr_state;
              }

You could wrap those two lines in a function if you don't want to
duplicate them.

If that solution or a similar refactoring doesn't appeal to you, then
you don't currently have any way of making that context warning go away,
short of improving Sparse to handle this situation better.

- Josh Triplett
