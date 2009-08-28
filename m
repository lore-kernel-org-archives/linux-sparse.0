From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] do not ignore attribute 'noreturn'...
Date: Fri, 28 Aug 2009 14:44:05 -0700
Message-ID: <70318cbf0908281444q735b7b9fm73f0fcbdbaeefa7b@mail.gmail.com>
References: <200908282330.08332.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:63798 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbZH1VoF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Aug 2009 17:44:05 -0400
Received: by pxi4 with SMTP id 4so2253278pxi.21
        for <linux-sparse@vger.kernel.org>; Fri, 28 Aug 2009 14:44:06 -0700 (PDT)
In-Reply-To: <200908282330.08332.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Fri, Aug 28, 2009 at 2:30 PM, Kamil Dudka<kdudka@redhat.com> wrote:
> enclosed is a simple patch adding support for attribute 'noreturn' to the
> parser. The enhancement makes it possible to optimize walk through CFG and
> thus help us to fight with the state explosion. The benefit is demonstrated
> on a simple real-world example.
>
> Generated CFG before patch:
> http://dudka.cz/devel/html/slsparse-before/slplug.c-handle_stmt_assign.svg
>
> Generated CFG after patch:
> http://dudka.cz/devel/html/slsparse-after/slplug.c-handle_stmt_assign.svg
>
> It's one of the key features I am currently missing in SPARSE in contrast
> to gcc used as parser. Thanks in advance for considering it!

Yes, no return is kind of useful. I think we need to do some thing about the
MOD_XXX eventually. It is very easy to run out of bits there.

Thanks for the patch. Applied.

Chris
