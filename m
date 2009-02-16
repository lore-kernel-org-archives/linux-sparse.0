From: Dan Carpenter <error27@gmail.com>
Subject: smatch_implied.c
Date: Mon, 16 Feb 2009 13:43:17 +0300 (EAT)
Message-ID: <alpine.DEB.2.00.0902161341500.3451@bikeee>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:38067 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbZBPKo1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 16 Feb 2009 05:44:27 -0500
Received: by an-out-0708.google.com with SMTP id c2so991545anc.1
        for <linux-sparse@vger.kernel.org>; Mon, 16 Feb 2009 02:44:25 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: smatch-discuss@lists.sf.net
Cc: tim@cyberelk.net, linux-sparse@vger.kernel.org

I pushed some new code and it's pretty cool.

This is some kernel code from drivers/char/ppdev.c
    681          compat_negot = 0;
    682          if (!(pp->flags & PP_CLAIMED) && pp->pdev &&
    683              (pp->state.mode != IEEE1284_MODE_COMPAT)) {
    684                  struct ieee1284_info *info;
    685
    686                  /* parport released, but not in compatibility mode */
    687                  parport_claim_or_block (pp->pdev);
    688                  pp->flags |= PP_CLAIMED;
    689                  info = &pp->pdev->port->ieee1284;
    690                  pp->saved_state.mode = info->mode;
    691                  pp->saved_state.phase = info->phase;
    692                  info->mode = pp->state.mode;
    693                  info->phase = pp->state.phase;
    694                  compat_negot = 1;
    695          } else if ((pp->flags & PP_CLAIMED) && pp->pdev &&
    696              (pp->pdev->port->ieee1284.mode != IEEE1284_MODE_COMPAT)) {
    697                  compat_negot = 2;
    698          }
    699          if (compat_negot) {
    700                  parport_negotiate (pp->pdev->port, IEEE1284_MODE_COMPAT);
    701                  printk (KERN_DEBUG CHRDEV
    702                          "%x: negotiated back to compatibility mode because "
    703                          "user-space forgot\n", minor);
    704          }
    705
    706          if (pp->flags & PP_CLAIMED) {
    707                  struct ieee1284_info *info;
    708
    709                  info = &pp->pdev->port->ieee1284;

The new smatch code recognizes that pp->pdev might be null when we 
dereference it on line 709.  It used to do that before as well...  The 
cool part is that it recognizes that dereferencing pp->dev on line 700 is 
not a bug.

The trick is that when code paths get merged, all the states that are 
unique to one side get saved in an "implied pool".  The smatch_extra.c 
code tracks very simple assignments like "compat_negot = 2".

When there is an "if (compat_negot)" condition, we make a list of both the 
implied pools where compat_negot is not zero.  All the states which are 
two in both pools are true on line 700.  So if compat_negot isn't zero, 
pp->dev isn't null.

The sad part is that there are still way way too many false positives for 
smatch to be practical...  I need to rewrite smatch_extra to track many 
more things.  Also the checking scripts are pretty rubbish.

Nevertheless progress is being made...

regards,
dan carpenter
