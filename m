From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: Writing compilers, and example.c vs compile-i386.c
Date: Mon, 16 Jun 2008 19:50:54 -0400
Message-ID: <8bd0f97a0806161650w1d88f0d5k33601d66f3d3084@mail.gmail.com>
References: <4856F196.8020403@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:31957 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219AbYFPXu4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 16 Jun 2008 19:50:56 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3913775rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 16 Jun 2008 16:50:55 -0700 (PDT)
In-Reply-To: <4856F196.8020403@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Jun 16, 2008 at 7:04 PM, David Given wrote:
> I'm wanting to write a compiler-like tool that's capable of generating
> machine-code-like-stuff (don't ask, long story), and as such, have been
> looking around for C compiler front ends that will make my life easier.
> sparse looks extremely promising.

this may be worth investigating as well:
http://pcc.ludd.ltu.se/
-mike
