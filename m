From: Yura Pakhuchiy <pakhuchiy@gmail.com>
Subject: sparse handles int64_t type wrong
Date: Tue, 12 Dec 2006 21:34:30 +0200
Message-ID: <1165952070.17896.7.camel@chaos.malinovka7.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-MIVWVOGChdhDTbNpg2rH"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ns1.iptel.by ([80.94.225.5]:44592 "EHLO iptel.by"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932402AbWLLTe7 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Dec 2006 14:34:59 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org


--=-MIVWVOGChdhDTbNpg2rH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

sparse 0.2 produces following errors on attached code:
a.c:15:7: warning: incorrect type in argument 1 (different type sizes)
a.c:15:7:    expected int [long] [usertype] *baz
a.c:15:7:    got int *<noident>
a.c:13:10: warning: shift too big (32) for type int 

However I believe it should not. Please fix!

-- 
Thanks,
        Yura

--=-MIVWVOGChdhDTbNpg2rH
Content-Disposition: attachment; filename=a.c
Content-Type: text/x-csrc; name=a.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <sys/types.h>

typedef int64_t s64;

void foo(s64 *baz)
{
}

int main(int argc, char *argv[])
{
	s64 bar;

	if (bar >> 32)
		;
	foo(&bar);
	return 0;
}

--=-MIVWVOGChdhDTbNpg2rH--
