From: Christopher Li <sparse@chrisli.org>
Subject: Re: more spewage (Re: sparse segfault on ppc64)
Date: Fri, 23 Mar 2007 16:01:18 -0700
Message-ID: <20070323230118.GB27992@chrisli.org>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org> <20070322171118.GL15364@redhat.com> <20070322221050.GC22151@chrisli.org> <20070323150459.52b02342.rdunlap@xenotime.net> <20070323233127.GA10115@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:41399 "EHLO
	rwcrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbXCWXj7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2007 19:39:59 -0400
Content-Disposition: inline
In-Reply-To: <20070323233127.GA10115@uranus.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Sat, Mar 24, 2007 at 12:31:27AM +0100, Sam Ravnborg wrote:
> > 
> > static struct __initdata chipset early_qrk[] = {
> > 	{ PCI_VENDOR_ID_NVIDIA, nvidia_bugs },
> > 	{ PCI_VENDOR_ID_VIA, via_bugs },
> > 	{ PCI_VENDOR_ID_ATI, ati_bugs },
> > 	{}
> > };
> In this case it is only good that sparse complains because the
> __initdata is not placed right before the variable name as it should be.
>

It has different meanings. If it place before the struct.
The attribute only apply to early_qrk.

If it is place between the struct and name. Declaration using
struct chipset later will get the attribute.

Chris
 
