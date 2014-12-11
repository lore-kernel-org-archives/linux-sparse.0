From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [next:master 4003/11577]
 drivers/usb/gadget/function/f_uac2.c:1595:1: sparse: symbol
 '__UNIQUE_ID_author__COUNTER__' has multiple initializers (originally
 initialized at drivers/usb/gadget/function/f_uac2.c:1594)
Date: Wed, 10 Dec 2014 20:30:25 -0800
Message-ID: <20141211043025.GA3661@wfg-t540p.sh.intel.com>
References: <201412101759.XJDM1LpP%fengguang.wu@intel.com>
 <54882B19.50208@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52717 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbaLKEa0 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Dec 2014 23:30:26 -0500
Content-Disposition: inline
In-Reply-To: <54882B19.50208@samsung.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Cc: kbuild-all@01.org, Felipe Balbi <balbi@ti.com>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Darren Hart <dvhart@infradead.org>

Wondering how to quiet this sparse warning.. CC Christopher and others.

On Wed, Dec 10, 2014 at 12:14:33PM +0100, Andrzej Pietrasiewicz wrote:
> Hello Fengguang,
> 
> W dniu 10.12.2014 o 10:47, kbuild test robot pisze:
> >tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> >head:   5348e33950aad8d5ab06d83cb7ac4e6b4198f773
> >commit: cb0a59f541337e646fcea15628eb46866fedb8a3 [4003/11577] usb: gadget: Kconfig: enable separate compilation of uac1/uac2 functions
> >reproduce:
> >   # apt-get install sparse
> >   git checkout cb0a59f541337e646fcea15628eb46866fedb8a3
> >   make ARCH=x86_64 allmodconfig
> >   make C=1 CF=-D__CHECK_ENDIAN__
> >
> >
> >sparse warnings: (new ones prefixed by >>)
> >
> 
> <snip>
> >>>drivers/usb/gadget/function/f_uac2.c:1595:1: sparse: symbol '__UNIQUE_ID_author__COUNTER__' has multiple initializers (originally initialized at drivers/usb/gadget/function/f_uac2.c:1594)
> >
> >vim +/__UNIQUE_ID_author__COUNTER__ +1595 drivers/usb/gadget/function/f_uac2.c
> >
> 
> <snip>
> 
> >f8f93d24 Andrzej Pietrasiewicz 2014-07-22  1592  DECLARE_USB_FUNCTION_INIT(uac2, afunc_alloc_inst, afunc_alloc);
> >f8f93d24 Andrzej Pietrasiewicz 2014-07-22  1593  MODULE_LICENSE("GPL");
> >f8f93d24 Andrzej Pietrasiewicz 2014-07-22  1594  MODULE_AUTHOR("Yadwinder Singh");
> >f8f93d24 Andrzej Pietrasiewicz 2014-07-22 @1595  MODULE_AUTHOR("Jaswinder Singh");
> >
> 
> I'm not sure what is wrong with multiple invocations of MODULE_AUTHOR in a file?
> 
> git grep -c MODULE_AUTHOR | grep -v ":1" | wc
>     299     299   10219
> 
> The above commands looks for files where MODULE_AUTHOR is used
> more than once. There are ~300 files like that in the kernel source tree.
> 
> It is true that I'm a bit puzzled by the fact that the two authors names'
> are spelled almost identically, but at the beginning of the file in question
> there are their e-mails and they are completely different so I assume the
> two names are of two distinct persons.
> 
> AP
