From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: more spewage (Re: sparse segfault on ppc64)
Date: Fri, 23 Mar 2007 16:43:07 -0700
Message-ID: <20070323164307.3e2e2803.rdunlap@xenotime.net>
References: <20070322063600.GD15364@redhat.com>
	<20070322073344.GU4095@ftp.linux.org.uk>
	<20070322070354.GA22151@chrisli.org>
	<20070322171118.GL15364@redhat.com>
	<20070322221050.GC22151@chrisli.org>
	<20070323150459.52b02342.rdunlap@xenotime.net>
	<20070323233127.GA10115@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:45957 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751143AbXCWXmK (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2007 19:42:10 -0400
Received: from midway.site ([71.245.96.31]) by xenotime.net for <linux-sparse@vger.kernel.org>; Fri, 23 Mar 2007 16:42:08 -0700
In-Reply-To: <20070323233127.GA10115@uranus.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Christopher Li <sparse@chrisli.org>, Dave Jones <davej@redhat.com>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Sat, 24 Mar 2007 00:31:27 +0100 Sam Ravnborg wrote:

> > 1.  net/sched/cls_api.c, lines 593-611:
> > 
> > 	return 0;
> > rtattr_failure: __attribute__ ((unused))
> > 	return -1;
> > }
> > 
> > ...
> > 
> > 	return 0;
> > rtattr_failure: __attribute__ ((unused))
> > 	return -1;
> > }
> > 
> > These spew:
> > 
> > net/sched/cls_api.c:593:17: error: typename in expression
> > net/sched/cls_api.c:594:2: error: Expected ; at end of statement
> > net/sched/cls_api.c:594:2: error: got return
> > net/sched/cls_api.c:611:17: error: typename in expression
> > net/sched/cls_api.c:612:2: error: Expected ; at end of statement
> > net/sched/cls_api.c:612:2: error: got return
> > net/sched/cls_api.c:593:17: error: undefined identifier '__attribute__'
> > net/sched/cls_api.c:611:17: error: undefined identifier '__attribute__'
> > 
> > 
> > 2.  in 2.6.21-rc4-mm1 only AFAIK, arch/x86_64/kernel/early-quirks.c, #79:
> > 
> > static struct __initdata chipset early_qrk[] = {
> > 	{ PCI_VENDOR_ID_NVIDIA, nvidia_bugs },
> > 	{ PCI_VENDOR_ID_VIA, via_bugs },
> > 	{ PCI_VENDOR_ID_ATI, ati_bugs },
> > 	{}
> > };
> In this case it is only good that sparse complains because the
> __initdata is not placed right before the variable name as it should be.

That one is quite ugly IMO.  I'm surprised that a compiler
parses it.

> You could argue that the error from sparse could be better but
> it is preferable to have consistent style over the kernel.

I lean more towards "is it valid C or not"?

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
