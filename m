From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Fix offsets in anonymous unions
Date: Fri, 23 May 2014 11:40:27 -0700
Message-ID: <CANeU7QkiLLT2vC+iRFxhPZpf6tYmuiSUf2LSsPM0acHcy-iZQw@mail.gmail.com>
References: <f6d65cc35d3627885e7a1c89e70a48c3368d4f66.1400764815.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:43680 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbaEWSk2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 May 2014 14:40:28 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so8547197qgd.37
        for <linux-sparse@vger.kernel.org>; Fri, 23 May 2014 11:40:27 -0700 (PDT)
In-Reply-To: <f6d65cc35d3627885e7a1c89e70a48c3368d4f66.1400764815.git.john@keeping.me.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 22, 2014 at 6:22 AM, John Keeping <john@keeping.me.uk> wrote:
> This is because in evaluate.c::convert_ident() the offset of a member of
> the inner union is set to the offset within the union, not the overall
> offset.
>
> Earlier, the correct offset has been calculated for check_designators()
> by find_identifier() so by setting the offset there we end up using the
> correct offset later on.

Thanks for the investigation. That does look like what happened.

>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> I'm pretty sure this is the wrong fix and I suspect it breaks some other
> scenarios like mixing designators and plain initializers, but I've run
> out of time to investigate this further and hopefully the correct patch
> will be obvious to someone who knows the code better...

I will take a look to see if there is better way to pass the offset to
the initializers.

Thanks for the patch.

Chris
