From: Christopher Li <sparse@chrisli.org>
Subject: Re: more spewage (Re: sparse segfault on ppc64)
Date: Fri, 23 Mar 2007 15:57:27 -0700
Message-ID: <20070323225727.GA27992@chrisli.org>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org> <20070322171118.GL15364@redhat.com> <20070322221050.GC22151@chrisli.org> <20070323150459.52b02342.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc13.comcast.net ([204.127.200.83]:50993 "EHLO
	sccrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbXCWXf4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2007 19:35:56 -0400
Content-Disposition: inline
In-Reply-To: <20070323150459.52b02342.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Dave Jones <davej@redhat.com>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Fri, Mar 23, 2007 at 03:04:59PM -0700, Randy Dunlap wrote:
> There are also sparse error spewings on attributes((...)) that are
> not in the expected source code location.  Three examples:
> 
> 
> 1.  net/sched/cls_api.c, lines 593-611:
> 
> 	return 0;
> rtattr_failure: __attribute__ ((unused))
> 	return -1;
> }

I will submit a patch to fix that.


> 2.  in 2.6.21-rc4-mm1 only AFAIK, arch/x86_64/kernel/early-quirks.c, #79:
> 
> static struct __initdata chipset early_qrk[] = {
> 	{ PCI_VENDOR_ID_NVIDIA, nvidia_bugs },
> 	{ PCI_VENDOR_ID_VIA, via_bugs },
> 	{ PCI_VENDOR_ID_ATI, ati_bugs },
> 	{}
> };
> 
> spews:
> 
> arch/x86_64/kernel/early-quirks.c:79:15: error: Trying to use reserved word '__attribute__' as identifier
> arch/x86_64/kernel/early-quirks.c:79:15: error: Expected ) in function declarator
> arch/x86_64/kernel/early-quirks.c:79:15: error: got ".init.data"

I think this should be fixed in git tree.

commit 1db467c6263823a4301d181a10ed9cd7700fd11c
Author: Christopher Li <sparse@chrisli.org>
Date:   Wed Feb 14 12:15:49 2007 -0800

    Handle structure attributes between the structure keyword and the name
    
    struct __attribute__((__aligned__(16))) foo {
        int a;
    };
    

Chris
