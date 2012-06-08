From: Xi Wang <xi.wang@gmail.com>
Subject: simplify_cast() question
Date: Fri, 08 Jun 2012 07:02:16 -0400
Message-ID: <4FD1DBB8.9010507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37467 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab2FHLCT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 07:02:19 -0400
Received: by yhmm54 with SMTP id m54so1140418yhm.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 04:02:18 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

Consider the code:

unsigned int foo(unsigned long long x)
{
	unsigned int tmp = x & 0x1fffffff;
	return tmp;
}

sparse emits:

	and.64      %r2 <- %arg1, $0x1fffffff
	ret.32      %r2

%r2 seems to be interpreted as both 64 and 32 bits.  Is this the
intended behavior?  This could bring some trouble when we add
->ctype to pseudo..

- xi
