From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [RFC][PATCH 0/3] implement pseudo->ctype
Date: Fri, 22 Jun 2012 10:08:26 +0800
Message-ID: <BDDFC596-BA52-41EA-8C7D-D35E620F8E6B@gmail.com>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com> <CANeU7Q=OHoLdD0O4o8tdcEoAjB83y+8G8mcZGuT2TduQooWkYA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:44722 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760973Ab2FVCIq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 21 Jun 2012 22:08:46 -0400
Received: by yhnn12 with SMTP id n12so1414408yhn.10
        for <linux-sparse@vger.kernel.org>; Thu, 21 Jun 2012 19:08:46 -0700 (PDT)
In-Reply-To: <CANeU7Q=OHoLdD0O4o8tdcEoAjB83y+8G8mcZGuT2TduQooWkYA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Jun 21, 2012, at 6:00 PM, Christopher Li wrote:
> 
> I like this series a lot. Do you have an update version of the patch?

I will resend a revised version of these patches.

With ->ctype in pseudo, we might have to disable several simplifications
in simplify.c and cse.c for type consistency.  One such example is:

	unsigned int foo(unsigned long long x)
	{
		unsigned int tmp = x & 0x1fffffff;
		return tmp;
	}

sparse emits:

	and.64      %r2 <- %arg1, $0x1fffffff
	ret.32      %r2

%r2 seems to be interpreted as both 64 and 32 bits, which will also
trouble backends.

To fix the inconsistency, we may need to disable some simplification:

https://github.com/xiw/sparse/commit/7072002

Then we have:

	and.64      %r2 <- %arg1, $0x1fffffff
	cast.32     %r3 <- (64) %r2
	ret.32      %r3

Does this make sense?  Or should we just provide an option to turn
off all sparse simplifications, since backends usually have their own
optimization passes?

- xi
