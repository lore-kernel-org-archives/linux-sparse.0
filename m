From: Christopher Li <sparse@chrisli.org>
Subject: Re: modifier_string() inconsistency with modifiers
Date: Fri, 20 Aug 2010 16:03:40 -0700
Message-ID: <AANLkTikugbBQ1gYVAdFRxWVmEX-odjq+Y5wA4mnN7Vnj@mail.gmail.com>
References: <1282300429.10440.230.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50054 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0HTXDm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Aug 2010 19:03:42 -0400
Received: by eyg5 with SMTP id 5so2517086eyg.19
        for <linux-sparse@vger.kernel.org>; Fri, 20 Aug 2010 16:03:41 -0700 (PDT)
In-Reply-To: <1282300429.10440.230.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: linux-sparse@vger.kernel.org

On Fri, Aug 20, 2010 at 3:33 AM, Bernd Petrovitsch <bernd@sysprog.at> wrote:
>
> Well, the equivalent for "MOD_WEAK" is "[structof]" - which seems wrong
> to me.
> And the parts for "inline" also doesn't fit AFAICS.
>
> What did I actually miss?

Nothing. We remove some bits from the modifier but forget to update
the modifier_string function.

Care for a patch?

Chris
