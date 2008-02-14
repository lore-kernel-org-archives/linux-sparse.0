From: Pavel Roskin <proski@gnu.org>
Subject: label 'continue' already bound, unreplaced symbol 'return'
Date: Wed, 13 Feb 2008 19:16:55 -0500
Message-ID: <1202948215.8941.37.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:11778 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762466AbYBNAQ5 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Feb 2008 19:16:57 -0500
Received: from [192.168.1.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 63C0C619058
	for <linux-sparse@vger.kernel.org>; Wed, 13 Feb 2008 19:16:56 -0500 (EST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

Here are some interesting testcases from the same hal.c from ndiswrapper
that was triggering the crash.

static inline int foo(void)
{
    do {
    } while (0);
    return 0;
}
int bar(void);
int bar(void)
{
    return foo();
}
typeof(bar) quux;


hal.c:12:13: warning: symbol 'quux' was not declared. Should it be
static?
hal.c:3:5: warning: label 'continue' already bound
hal.c:3:5: warning: label 'break' already bound


static inline int foo(void)
{
    return 0;
}
typeof(foo) quux;

hal.c:3:5: warning: unreplaced symbol 'return'
hal.c:1:19: warning: unreplaced symbol 'return'
hal.c:5:13: warning: symbol 'quux' was not declared. Should it be
static?


static inline void foo(void)
{
    do {} while (0);
}
typeof(foo) quux;

hal.c:3:5: warning: unreplaced symbol 'break'
hal.c:3:5: warning: unreplaced symbol 'continue'
hal.c:1:20: warning: unreplaced symbol 'return'
hal.c:5:13: warning: symbol 'quux' was not declared. Should it be
static?

"extern" before "typeof" fixes all warnings.

-- 
Regards,
Pavel Roskin
