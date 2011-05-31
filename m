From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: more "unreplaced symbol" warnings
Date: Tue, 31 May 2011 19:58:31 +0100
Message-ID: <20110531185831.GN11521@ZenIV.linux.org.uk>
References: <20110529145450.8c042971.rdunlap@xenotime.net>
 <BANLkTi=_0Xe8Fuq9aJ69Zqx3iQYq6E9N5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58206 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab1EaS6g (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 31 May 2011 14:58:36 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=_0Xe8Fuq9aJ69Zqx3iQYq6E9N5w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

Here's what is actually triggering that crap.  Have fun...

#define __u16 unsigned short
static inline __attribute__((__const__)) __u16 f(__u16 val)
{
         return val;
}

static inline void barf(unsigned int len)
{
}

static inline unsigned int bar(__u16 n)
{
        switch (n) {
        case (__builtin_constant_p(1) ? 1 : f(1)):
                return 4;
        default:
                return 0;
        }
}

int foo(__u16 n)
{
        unsigned int x = bar(n);
        barf(bar(n));
        return 0;
}
