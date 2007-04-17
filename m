From: Dave Jones <davej@redhat.com>
Subject: 0.3 ?
Date: Tue, 17 Apr 2007 12:29:47 -0400
Message-ID: <20070417162947.GA15753@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56395 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031163AbXDQQ34 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Apr 2007 12:29:56 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3HGTr0X001138
	for <linux-sparse@vger.kernel.org>; Tue, 17 Apr 2007 12:29:53 -0400
Received: from gelk.kernelslacker.org (vpn-248-2.boston.redhat.com [10.13.248.2])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3HGTmJa022446
	for <linux-sparse@vger.kernel.org>; Tue, 17 Apr 2007 12:29:48 -0400
Received: from gelk.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by gelk.kernelslacker.org (8.13.8/8.13.8) with ESMTP id l3HGTlal025130
	for <linux-sparse@vger.kernel.org>; Tue, 17 Apr 2007 12:29:47 -0400
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.13.8/8.13.8/Submit) id l3HGTlIb025129
	for linux-sparse@vger.kernel.org; Tue, 17 Apr 2007 12:29:47 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Any plans to do another release sometime soon?
I'm hitting a segfault with 0.2, that seems to be
fixed in the current git tree.

The failure looks like this..

Program received signal SIGSEGV, Segmentation fault.
0x000000000040fa5a in expand_expression (expr=<value optimized out>)
    at expand.c:875
875                     if (a && a->ctype->bit_size && bit_offset(a) == bit_offset(b)) {
(gdb) bt
#0  0x000000000040fa5a in expand_expression (expr=<value optimized out>)
    at expand.c:875
#1  0x0000000000410ccb in expand_symbol (sym=<value optimized out>)
    at expand.c:993
#2  0x0000000000404626 in check_symbols (list=0x8a86f0) at sparse.c:265
#3  0x00000000004049c2 in main (argc=<value optimized out>, 
    argv=<value optimized out>) at sparse.c:280
#4  0x000000330d41da44 in __libc_start_main (main=0x404970 <main>, argc=61, 
    ubp_av=0x7fff1ed0ddf8, init=<value optimized out>, 
    fini=<value optimized out>, rtld_fini=<value optimized out>, 
    stack_end=0x7fff1ed0dde8) at libc-start.c:231
#5  0x0000000000404309 in _start ()


Repeatable with 2.6.21-rc7 + this patch..
http://cvs.fedora.redhat.com/viewcvs/*checkout*/rpms/kernel/devel/linux-2.6-kvm-19.patch?rev=1.1

then make drivers/kvm/kvm_main.o C=1

	Dave

-- 
http://www.codemonkey.org.uk
