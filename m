From: Bob Copeland <me@bobcopeland.com>
Subject: error: ctype on uninitialized symbol
Date: Mon, 1 Feb 2016 14:44:09 -0500
Message-ID: <20160201194409.GA15047@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36467 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbcBAToM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 1 Feb 2016 14:44:12 -0500
Received: by mail-qg0-f51.google.com with SMTP id e32so128727576qgf.3
        for <linux-sparse@vger.kernel.org>; Mon, 01 Feb 2016 11:44:12 -0800 (PST)
Received: from hash ([2001:470:1d:6db:230:48ff:fe9d:9c89])
        by smtp.gmail.com with ESMTPSA id s5sm11964296qks.31.2016.02.01.11.44.11
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2016 11:44:11 -0800 (PST)
Received: from bob by hash with local (Exim 4.84)
	(envelope-from <me@bobcopeland.com>)
	id 1aQKOP-00044G-WD
	for linux-sparse@vger.kernel.org; Mon, 01 Feb 2016 14:44:09 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi all,

I'm seeing the following error when running sparse with latest HEAD,
against the small test case at the end:

$ sparse sparse-test.c
[garbage]:0:0: error: ctype on uninitialized symbol 0x696ec0

I am getting this with calls to time_after(..., msecs_to_jiffies()) in my
kernel build.

Below, the "1UL + 1L" is a stand-in for MAX_JIFFY_OFFSET, and the value
has to be some operation on two different types to trigger for me (e.g.
1UL + 1UL will run without error).  Taking out the typecheck macro will
also remove the error.

Any thoughts?

$ sparse --version
v0.5.0-44-g40791b9

sparse-test.c:

#define typecheck(type,x) \
({	type __dummy; \
	typeof(x) __dummy2; \
	(void)(&__dummy == &__dummy2); \
	1; \
})

#define time_after(a,b)		\
	(typecheck(unsigned long, a) && \
	 typecheck(unsigned long, b) && \
	 ((long)((b) - (a)) < 0))

static inline unsigned long y(void)
{
	return 1UL+1L;
}

static void x(void)
{
	int c = time_after(1UL, y());
}

-- 
Bob Copeland %% http://bobcopeland.com/
