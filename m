From: Randy Dunlap <rdunlap@infradead.org>
Subject: symbol.h question
Date: Sun, 21 Jan 2018 21:41:25 -0800
Message-ID: <16508b89-ae1d-eb2d-4df3-ecbf243c2f47@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38059 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeAVFl1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jan 2018 00:41:27 -0500
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.site)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1edUrG-0006ks-EH
        for linux-sparse@vger.kernel.org; Mon, 22 Jan 2018 05:41:26 +0000
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

What is the purpose/meaning of these inline + extern in symbol.h?

static inline int is_ptr_type(struct symbol *type)
{
	if (type->type == SYM_NODE)
		type = type->ctype.base_type;
	return type->type == SYM_PTR || type->type == SYM_ARRAY || type->type == SYM_FN;
}

///later:

extern int is_ptr_type(struct symbol *);

thanks,
-- 
~Randy
