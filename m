From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: A few notes on how I see the whole process working.
Date: Mon, 28 Apr 2008 11:12:10 +0400
Message-ID: <f19298770804280012t4505dc7oc6aba4e78417962b@mail.gmail.com>
References: <f19298770804202112hcd32b7ch8c6ef357b9f7344e@mail.gmail.com>
	 <480C8856.4030805@kernel.org>
	 <f19298770804241315wca6a214x23a863c6fceb6009@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:31549 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbYD1HML (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 28 Apr 2008 03:12:11 -0400
Received: by wa-out-1112.google.com with SMTP id m16so7804816waf.23
        for <linux-sparse@vger.kernel.org>; Mon, 28 Apr 2008 00:12:11 -0700 (PDT)
In-Reply-To: <f19298770804241315wca6a214x23a863c6fceb6009@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

On Fri, Apr 25, 2008 at 12:15 AM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:

[...]

>  >  >                 - (maybe something else I've missed?)
>  >
>  >  Most of the things in a sparse "struct symbol" would probably prove
>  >  useful, I suspect.
>  >
>  May be. I'm still not really familiar with the sparse internals.

I still don't buy the bytecode idea, but it seems that the macros are
not actually lost after being pre-processed, which was my main concern
against even thinking about dumping the sparse internal representation
into the generated sparse object files. Still wandering in the dark. Will
look closed when return.

>
>
>  >  Eventually we will probably want something like the linearized
>  >  bytecode.
>  >
>
>  While I generally agree the we need to do something like
>
>  sparse -> intermediate data -> checker
>
>  the intermediate format is a bit unclear to me. It has to be verbose
>  enough to loose no essential information, and still be practical.
>  If by linearized bytecode you mean something like what we get
>  running sparse -ventry, this is clearly not going to work. As an
>  example, suppose you wish to check that local_irqsave() and
>  local_irqrestore() are balanced. This means, the checker actually
>  wants to look at the original source code, not even at the
>  pre-processed C code.
>
>  So, suggestions on the intermediate format are welcome.
>
