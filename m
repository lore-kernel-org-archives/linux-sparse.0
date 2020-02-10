From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/2] dissect: set sym->kind for reporter
Date: Tue, 11 Feb 2020 00:32:12 +0100
Message-ID: <20200210233212.xfsktwxhewxgtvr3@ltop.local>
References: <20200210162018.GA29634@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54635 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgBJXcT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Feb 2020 18:32:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id g1so1187674wmh.4
        for <linux-sparse@vger.kernel.org>; Mon, 10 Feb 2020 15:32:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200210162018.GA29634@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Mon, Feb 10, 2020 at 05:20:18PM +0100, Oleg Nesterov wrote:
> Change dissect to report ctags-like kind passed in sym->kind.
> Currently only v,f,s and m kinds are possible.
> 
> SYM_UNION doesn't differ from SYM_STRUCT and has ->kind = 's'.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Thanks.
Both patches applied and pushed.

-- Luc
