From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/7] builtin: use a table for the builtins
Date: Fri, 12 Jun 2020 18:48:32 +0200
Message-ID: <20200612164832.fkkfvqcbjh7ivea7@ltop.local>
References: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
 <20200610202735.84968-3-luc.vanoostenryck@gmail.com>
 <62b18141-89be-d0e0-a848-8cf096d0f160@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLQsf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 12 Jun 2020 12:48:35 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBB5C03E96F
        for <linux-sparse@vger.kernel.org>; Fri, 12 Jun 2020 09:48:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gl26so10711119ejb.11
        for <linux-sparse@vger.kernel.org>; Fri, 12 Jun 2020 09:48:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <62b18141-89be-d0e0-a848-8cf096d0f160@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Fri, Jun 12, 2020 at 01:56:20AM +0100, Ramsay Jones wrote:
> On 10/06/2020 21:27, Luc Van Oostenryck wrote:
> > 
> > A table is table is preferable but a complication for doing this
> 
> s/table is table is/table is/

Thanks for noticing this typo (and the ones in the other patches).
 
> > +static void declare_one_builtin(const struct builtin_fn *entry)
> > +{
> > +	struct symbol *sym = create_symbol(0, entry->name, SYM_NODE, NS_SYMBOL);
> 
> So, assuming stream 0 here as well ...
> 
> > -static void declare_builtin(const char *name, struct symbol *rtype, int variadic, ...)
> > -{
> > -	int stream = 0;			// FIXME
> 
> ... and, yes, here is the FIXME (so my memory is not as bad
> as I thought!).
> 
> This all looks good.

Well yes ... I don't really like the situation, though.
I probably should do something like adding a #define builtin_stream 0
and use this.
 
Thnaks to bring my attention to this.
-- Luc
