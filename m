From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: symbol.h question
Date: Mon, 22 Jan 2018 06:56:25 +0100
Message-ID: <20180122055624.wgzfr2noac2nxnfg@ltop.local>
References: <16508b89-ae1d-eb2d-4df3-ecbf243c2f47@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35161 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbeAVF41 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jan 2018 00:56:27 -0500
Received: by mail-wm0-f42.google.com with SMTP id r78so14455512wme.0
        for <linux-sparse@vger.kernel.org>; Sun, 21 Jan 2018 21:56:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <16508b89-ae1d-eb2d-4df3-ecbf243c2f47@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jan 21, 2018 at 09:41:25PM -0800, Randy Dunlap wrote:
> Hi,
> 
> What is the purpose/meaning of these inline + extern in symbol.h?
> 
> static inline int is_ptr_type(struct symbol *type)
> {
> 	if (type->type == SYM_NODE)
> 		type = type->ctype.base_type;
> 	return type->type == SYM_PTR || type->type == SYM_ARRAY || type->type == SYM_FN;
> }

It's now a misnomer. It's purpose now is to check if the type
is a pointer or can degenerate to a pointer.
A better name should be used.
 
> ///later:
> 
> extern int is_ptr_type(struct symbol *);

This must be removed (cfr. https://github.com/lucvoo/sparse/commit/46047a0706e5 )

Regards,
-- Luc 
