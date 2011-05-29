From: Randy Dunlap <rdunlap@xenotime.net>
Subject: "advancing past deep designator" warnings
Date: Sun, 29 May 2011 14:57:12 -0700
Message-ID: <20110529145712.eefa4d52.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from oproxy2-pub.bluehost.com ([67.222.39.60]:54359 "HELO
	oproxy2-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752799Ab1E2V5O (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 29 May 2011 17:57:14 -0400
Received: from static-50-53-38-135.bvtn.or.frontiernet.net ([50.53.38.135] helo=chimera.site)
	by box742.bluehost.com with esmtpa (Exim 4.69)
	(envelope-from <rdunlap@xenotime.net>)
	id 1QQnyz-0001DE-6K
	for linux-sparse@vger.kernel.org; Sun, 29 May 2011 15:57:13 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

Can you give me an idea about what this warning means and what to do about it?
Thanks.


(x86_64 allmodconfig, linux-2.6.39-git18)


drivers/usb/gadget/f_audio.c:229:9: warning: advancing past deep designator
drivers/usb/gadget/f_acm.c:261:9: warning: advancing past deep designator
drivers/usb/gadget/f_ecm.c:283:9: warning: advancing past deep designator
drivers/usb/gadget/cdc2.c:112:9: warning: advancing past deep designator
drivers/usb/gadget/f_ecm.c:283:9: warning: advancing past deep designator
drivers/usb/gadget/f_subset.c:217:9: warning: advancing past deep designator
drivers/usb/gadget/f_rndis.c:294:9: warning: advancing past deep designator
drivers/usb/gadget/f_eem.c:130:9: warning: advancing past deep designator
drivers/usb/gadget/ether.c:218:9: warning: advancing past deep designator
drivers/usb/gadget/f_hid.c:577:9: warning: advancing past deep designator
drivers/usb/gadget/hid.c:113:9: warning: advancing past deep designator
drivers/usb/gadget/f_acm.c:261:9: warning: advancing past deep designator
drivers/usb/gadget/f_ecm.c:283:9: warning: advancing past deep designator
drivers/usb/gadget/f_subset.c:217:9: warning: advancing past deep designator
drivers/usb/gadget/f_rndis.c:294:9: warning: advancing past deep designator
drivers/usb/gadget/multi.c:139:9: warning: advancing past deep designator
drivers/usb/gadget/f_ncm.c:346:9: warning: advancing past deep designator
drivers/usb/gadget/ncm.c:120:9: warning: advancing past deep designator
drivers/usb/gadget/f_acm.c:261:9: warning: advancing past deep designator
drivers/usb/gadget/f_ecm.c:283:9: warning: advancing past deep designator
drivers/usb/gadget/f_obex.c:76:9: warning: advancing past deep designator
drivers/usb/gadget/f_serial.c:114:9: warning: advancing past deep designator
drivers/usb/gadget/nokia.c:73:9: warning: advancing past deep designator
drivers/usb/gadget/f_acm.c:261:9: warning: advancing past deep designator
drivers/usb/gadget/f_obex.c:76:9: warning: advancing past deep designator
drivers/usb/gadget/f_serial.c:114:9: warning: advancing past deep designator
drivers/usb/gadget/serial.c:74:9: warning: advancing past deep designator
drivers/usb/gadget/f_uvc.c:47:9: warning: advancing past deep designator
drivers/usb/gadget/webcam.c:58:9: warning: advancing past deep designator
drivers/usb/gadget/f_sourcesink.c:138:9: warning: advancing past deep designator
drivers/usb/gadget/f_loopback.c:125:9: warning: advancing past deep designator
drivers/usb/gadget/zero.c:167:9: warning: advancing past deep designator
drivers/net/wan/x25_asy.c:527:17: error: return with no return value
drivers/usb/gadget/f_ecm.c:283:9: warning: advancing past deep designator
drivers/usb/gadget/f_subset.c:217:9: warning: advancing past deep designator
drivers/usb/gadget/f_rndis.c:294:9: warning: advancing past deep designator


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
