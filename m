From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] OP_SWITCH should use 'insn->cond' instead of
 'insn->target'
Date: Mon, 6 Feb 2017 21:33:46 +0100
Message-ID: <20170206203346.bmwhmwrrjnbsyapr@macpro.local>
References: <20161122163233.3765-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35004 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbdBFUeg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Feb 2017 15:34:36 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so24167446wmu.2
        for <linux-sparse@vger.kernel.org>; Mon, 06 Feb 2017 12:34:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161122163233.3765-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@looxix.net>

On Tue, Nov 22, 2016 at 05:32:33PM +0100, Luc Van Oostenryck wrote:
> From: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>
> 
> show_instruction() uses the field 'target' to display OP_SWITCH
> instruction instead of 'cond' like OP_BR does.
> It doesn't change anything since these two fields use the same
> storage inside struct instruction but better to use the right field
> to keep consistent.
> ---
>  linearize.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is my s-o-b that I had forgot to add:
    Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
