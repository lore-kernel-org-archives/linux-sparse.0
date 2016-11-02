From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] dissect: teach do_initializer() to handle the nested
 EXPR_IDENTIFIER's
Date: Wed, 2 Nov 2016 15:19:07 +0100
Message-ID: <20161102141906.GB9163@macpro.local>
References: <20160208151328.GA24783@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36152 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754095AbcKBOTL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 10:19:11 -0400
Received: by mail-wm0-f42.google.com with SMTP id p190so271798389wmp.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 07:19:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160208151328.GA24783@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Mon, Feb 08, 2016 at 04:13:28PM +0100, Oleg Nesterov wrote:
> do_initializer() is very limited/buggy but it was able to parse the kernel
> code until ftrace started to use ".a.b = x" rather than ".a = { .b = x }"
> in initializers.

LGTM and anyway, you know this dissect better than anyone else, no?

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
