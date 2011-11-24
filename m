From: Christopher Li <sparse@chrisli.org>
Subject: Re: cannot size expression - exported array in kernel
Date: Wed, 23 Nov 2011 23:53:01 -0800
Message-ID: <CANeU7QnD5WEeFdmw0T-U9PaoiY555FzMS4X7ESHrQhaYnKydEQ@mail.gmail.com>
References: <1321870017.3999.31.camel@jlt3.sipsolutions.net>
	<CAOJsxLEgV4v0rVPb1O63T-p+Nj++kkE4dh2L3k_a2XGqptnVeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61071 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1KXHxC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Nov 2011 02:53:02 -0500
Received: by ghrr1 with SMTP id r1so2248762ghr.19
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2011 23:53:01 -0800 (PST)
In-Reply-To: <CAOJsxLEgV4v0rVPb1O63T-p+Nj++kkE4dh2L3k_a2XGqptnVeQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Nov 23, 2011 at 11:29 PM, Pekka Enberg <penberg@kernel.org> wrote:
> I'm not really an expert in the sparse front-end either. Looking at
> your test case, evaluate_sizeof() returns -1 which suggests
> examine_symbol_type() doesn't handle typeof(bridge_tunnel_header)
> properly.

I will add that to a validation test case and take a closer look.

Chris
