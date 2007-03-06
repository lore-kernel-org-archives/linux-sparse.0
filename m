From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: sparse segfault in kernel -mm tree
Date: Tue, 6 Mar 2007 15:12:52 -0800
Message-ID: <20070306151252.239c58f8.rdunlap@xenotime.net>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
	<20070306023351.GB31138@chrisli.org>
	<20070305210416.7b5c0a2a.rdunlap@xenotime.net>
	<20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
	<20070305224025.fe867c28.rdunlap@xenotime.net>
	<1173205177.32333.34.camel@dv>
	<20070306125846.0e3a684a.rdunlap@xenotime.net>
	<70318cbf0703061428u138a64b2x117eebdb915be50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:48387 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030704AbXCFXOs (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Mar 2007 18:14:48 -0500
Received: from midway.site ([71.245.96.156]) by xenotime.net for <linux-sparse@vger.kernel.org>; Tue, 6 Mar 2007 15:14:42 -0800
In-Reply-To: <70318cbf0703061428u138a64b2x117eebdb915be50@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Tue, 6 Mar 2007 14:28:24 -0800 Christopher Li wrote:

> Here is my version base on your email.
> 
> I need to change the gcc include path though. But it does not crash on me.
> 
> I did not get crash on allmodconfig either.
> 
> Chris

Hi,
OK, uh, what did we expect from this?
I changed /redhat/ to /suse/ and lib to lib64.  Here's what I got:
(split into multiple lines for my email client)


/home/rddunlap/scripts/cli_bad.sh: line 1: 17720 Segmentation fault      sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -D__x86_64__ -m64 -nostdinc -isystem /usr/lib64/gcc/x86_64-suse-linux/4.1.0/include -Wp,-MD,drivers/net/vioc/.vioc_provision.o.d -nostdinc 
-isystem /usr/lib64/gcc/x86_64-suse-linux/4.1.0/include -D__KERNEL__ -Iinclude -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Os -mtune=generic -m64 -mno-red-zone -mcmodel=kernel -pipe -fno-reorder-blocks -Wno-sign-compare -fno-asynchronous-unwind-tables -funit-at-a-time -mno-sse -mno-mmx -mno-sse2 
-mno-3dnow -maccumulate-outgoing-args -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(vioc_provision)" -D"KBUILD_MODNAME=KBUILD_STR(vioc)" drivers/net/vioc/vioc_provision.c


It looks like the problem (as I experience it) is in
drivers/net/vioc/vioc_provision.c, in this struct:
(it just takes a boatload of header files to get to this)

	static struct vnic_prov_def vnic_set_0 = {
	.rxd_ring[0].buf_size = RXDQ_SMALL_ALLOC_BUFSIZE,
	.rxd_ring[0].entries = RXDQ_SMALL_ENTRIES,
	.rxd_ring[0].id = 0,
	.rxd_ring[0].state = 1,
	.rxd_ring[1].buf_size = RXDQ_STD_ALLOC_BUFSIZE,
	.rxd_ring[1].entries = RXDQ_STD_ENTRIES,
	.rxd_ring[1].id = 1,
	.rxd_ring[1].state = 1,
	.rxd_ring[2].buf_size = RXDQ_JUMBO_ALLOC_BUFSIZE,
	.rxd_ring[2].entries = RXDQ_JUMBO_ENTRIES,
	.rxd_ring[2].id = 2,
	.rxd_ring[2].state = 1,
	.tx_entries = TXQ_ENTRIES,.rxc_entries = RXC_ENTRIES,.rxc_id =
	    0,.rxc_intr_id = 0
};


but I'll keep reducing the size of the .i file to try to be
sure about this.



> On 3/6/07, Randy Dunlap <rdunlap@xenotime.net> wrote:
> > On Tue, 06 Mar 2007 13:19:37 -0500 Pavel Roskin wrote:
> > OK, that produced a large .i file and running:
> >   sparse vioc_provision.i
> > does reproduce the segfault, so now I am cutting down the size of
> > the .i file, then I'll send it in.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
