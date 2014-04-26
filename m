From: Sam Ravnborg <sam@ravnborg.org>
Subject: How to fix: asm output is not an lvalue
Date: Sat, 26 Apr 2014 23:57:05 +0200
Message-ID: <20140426215705.GA20867@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:57784 "EHLO
	asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbaDZWEY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 26 Apr 2014 18:04:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by asavdk3.altibox.net (Postfix) with ESMTP id 6EA4B20027
	for <linux-sparse@vger.kernel.org>; Sat, 26 Apr 2014 23:57:07 +0200 (CEST)
Received: from asavdk3.altibox.net ([127.0.0.1])
	by localhost (asavdk3.lysetele.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id U8WhYVwpkmj1 for <linux-sparse@vger.kernel.org>;
	Sat, 26 Apr 2014 23:57:07 +0200 (CEST)
Received: from ravnborg.org (unknown [188.228.89.252])
	(using TLSv1.2 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by asavdk3.altibox.net (Postfix) with ESMTPS id 16E2520022
	for <linux-sparse@vger.kernel.org>; Sat, 26 Apr 2014 23:57:06 +0200 (CEST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi all.

Following code snippet generate these warnings:
t.c:9:9: warning: asm output is not an lvalue
t.c:10:10: warning: asm output is not an lvalue
t.c:9:9: warning: generating address of non-lvalue (11)
t.c:10:10: warning: generating address of non-lvalue (11)

The code snippet is part of the math emu in the kernel.
For sparc32 I get a lot of the "asm output is not an lvalue"
warnings.

For sparc32 I do not get the "generating address of non-lvalue".

Can you help me gettitng rid of these warnings?

Thanks in advance,

	Sam



$ cat t.c
static void todo(void)
{
        typedef unsigned int USItype __attribute__((mode(SI)));
        USItype l1;

        USItype DR_f0, DA_f1, DB_f1, DA_f0, DB_f0;

 __asm__ ("subcc %r4,%5,%1\n\t" "subx %r2,%3,%0\n" :
 "=r" ((USItype)(l1)),
 "=&r" ((USItype)(DR_f0)) :
 "rJ" ((USItype)(DA_f1)),
 "rI" ((USItype)(DB_f1)),
 "rJ" ((USItype)(DA_f0)),
 "rI" ((USItype)(DB_f0)) :
 "cc");
}






