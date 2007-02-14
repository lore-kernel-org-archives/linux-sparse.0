From: Daniel Drake <ddrake@brontes3d.com>
Subject: __attribute__ annotations and struct types
Date: Wed, 14 Feb 2007 15:01:54 -0500
Message-ID: <1171483314.14504.9.camel@systems03.mmm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp136.iad.emailsrvr.com ([207.97.245.136]:47598 "EHLO
	smtp136.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbXBNUWU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Feb 2007 15:22:20 -0500
Received: from [169.14.245.222] (host34.155.212.242.conversent.net [155.212.242.34])
	(Authenticated sender: ddrake@brontes3d.com)
	by relay3.r3.iad.emailsrvr.com (SMTP Server) with ESMTP id 42B0444C066
	for <linux-sparse@vger.kernel.org>; Wed, 14 Feb 2007 15:01:55 -0500 (EST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

gcc-4.1.1 accepts this as valid code:

struct __attribute__((__aligned__(16))) foo {
    int a;
};

sparse doesn't like it:

	test.c:7:8: error: Trying to use reserved word '__attribute__' 
	as identifier

I'm not sure if this is a bug that people are interested in solving, as
the more common form works in both gcc and sparse:

struct foo {
    int a;
} __attribute__((__aligned__(16)));

Thanks,
-- 
Daniel Drake
Brontes Technologies, A 3M Company
