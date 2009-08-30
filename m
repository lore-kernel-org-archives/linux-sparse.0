From: Stephen Hemminger <shemminger@vyatta.com>
Subject: sparse segv with simple test
Date: Sun, 30 Aug 2009 15:32:02 -0700
Message-ID: <20090830153202.4dc5c58c@s6510>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.vyatta.com ([76.74.103.46]:43156 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754189AbZH3WcG (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Aug 2009 18:32:06 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

I was checking up on some enum issues and tried running the following:
	sparse -Wenum-mismatch enum.c
It dies here:
gdb) run -Wenum-mismatch e.c
Starting program: /home/shemminger/src/sparse/sparse -Wenum-mismatch enum.c

Program received signal SIGSEGV, Segmentation fault.
0x0805c81d in linearize_store_gen (ep=0xb7e7600c, value=0xb7e4e00c, 
    ad=0xbfd43134) at linearize.h:293
293		return (p && p->type != PSEUDO_VOID && p->type != PSEUDO_VAL);
(gdb) where
#0  0x0805c81d in linearize_store_gen (ep=0xb7e7600c, value=0xb7e4e00c, 
    ad=0xbfd43134) at linearize.h:293
#1  0x080609da in linearize_symbol (sym=0xb7e244cc) at linearize.c:1526
#2  0x080494bd in main (argc=-1209907772, argv=0xb7e245c4) at sparse.c:266
------
#include <stdio.h>

enum x { A, B, C };

static enum x foo(int n) {
	return (n > 0) ? A : B;
}

int main(int ac, char **av) {
	int x = foo(ac);
	enum x y = 99;

	printf("%d %d\n", x, y);
	return 0;
}
