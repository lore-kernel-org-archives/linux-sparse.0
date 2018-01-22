From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: symbol.h question
Date: Mon, 22 Jan 2018 12:15:00 +0300
Message-ID: <20180122091500.qfawmwbqkqig64h2@mwanda>
References: <16508b89-ae1d-eb2d-4df3-ecbf243c2f47@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:35726 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbeAVJPd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jan 2018 04:15:33 -0500
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
> 
> ///later:
> 
> extern int is_ptr_type(struct symbol *);
> 

It takes a symbol pointer and tells you if the symbol represents a
pointer (or array or a function since those are basically pointers too).

regards,
dan carpenter

