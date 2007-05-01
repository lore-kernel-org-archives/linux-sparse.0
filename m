From: Randy Dunlap <rdunlap@xenotime.net>
Subject: barrier macro
Date: Tue, 1 May 2007 15:34:48 -0700
Message-ID: <20070501153448.a65c81c2.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:40003 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754351AbXEAWal (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 18:30:41 -0400
Received: from midway.site ([71.245.96.31]) by xenotime.net for <linux-sparse@vger.kernel.org>; Tue, 1 May 2007 15:30:36 -0700
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

(using sparse 0.3)

./compiler-gcc.h:10:#define barrier() __asm__ __volatile__("": : :"memory")

causes this output:

net/sunrpc/xprtsock.c:640:2: error: Expected ( after asm
net/sunrpc/xprtsock.c:640:2: error: got __volatile__
net/sunrpc/xprtsock.c:640:2: error: typename in expression
net/sunrpc/xprtsock.c:640:2: error: Expected ) in function call
net/sunrpc/xprtsock.c:640:2: error: got :


Maybe sparse could allow modifiers between asm|__asm__ and the
(...) ?

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
