From: Alexey Dobriyan <adobriyan@sw.ru>
Subject: sparse breakage triggered by rcu_read_lock() lockdep annotations
Date: Tue, 16 Oct 2007 14:55:21 +0400
Message-ID: <20071016105521.GB6352@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:21568 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932132AbXJPKz2 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Oct 2007 06:55:28 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

FWIW, commit 851a67b825540a8e00c0be3ee25e4627ba8b133b
aka "lockdep: annotate rcu_read_{,un}lock{,_bh}"
causes sparse to trigger internal assertion in quite a few places over
allyesconfig run.

	sparse: flow.c:805: rewrite_parent_branch: Assertion `changed' failed.

Trimmed down testcase:

	void f(unsigned long ip);
	static void g(void)
	{
	        if (1) {
	              f(({ __label__ x; x: (unsigned long)&&x; }));
	        }
	        f(({ __label__ x; x: (unsigned long)&&x; }));
	}

#0  0x4001c410 in __kernel_vsyscall ()
(gdb) bt
#0  0x4001c410 in __kernel_vsyscall ()
#1  0x40050701 in raise () from /lib/libc.so.6
#2  0x40051e38 in abort () from /lib/libc.so.6
#3  0x40049fcc in __assert_fail () from /lib/libc.so.6
#4  0x08064947 in pack_basic_blocks (ep=0x411a1c6c) at flow.c:812
#5  0x0805ffbf in linearize_symbol (sym=0x4103ec8c) at linearize.c:2154
#6  0x080492a3 in main (argc=Cannot access memory at address 0x274d) at sparse.c:266
