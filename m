From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] dissect: introduce sym_is_local() for reporter
Date: Wed, 12 Feb 2020 01:41:35 +0100
Message-ID: <20200212004135.cyzcqtwwcuewa4gj@ltop.local>
References: <20200211160136.GA14027@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43766 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgBLAlh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Feb 2020 19:41:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id r11so60646wrq.10
        for <linux-sparse@vger.kernel.org>; Tue, 11 Feb 2020 16:41:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200211160136.GA14027@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Tue, Feb 11, 2020 at 05:01:36PM +0100, Oleg Nesterov wrote:
> Can be used to filter out the usage of local variables.

...
 
> diff --git a/dissect.h b/dissect.h
> index efe2c0b..178dba5 100644
> --- a/dissect.h
> +++ b/dissect.h
> @@ -27,6 +27,11 @@ struct reporter
>  
>  extern struct symbol *dissect_ctx;
>  
> +static inline bool sym_is_local(struct symbol *sym)
> +{
> +	return sym->kind == 'v' && !(sym->ctype.modifiers & MOD_TOPLEVEL);
> +}
> +

Shouldn't MOD_STATIC be added to the test?
It depends on what exactly you want for 'local'.

-- Luc
