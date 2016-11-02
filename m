From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] dissect: teach do_expression() to handle EXPR_OFFSETOF
Date: Wed, 2 Nov 2016 15:21:19 +0100
Message-ID: <20161102142119.GC9163@macpro.local>
References: <20160208132657.GA19007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36072 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753849AbcKBOVX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 10:21:23 -0400
Received: by mail-wm0-f45.google.com with SMTP id p190so271927479wmp.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 07:21:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160208132657.GA19007@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Mon, Feb 08, 2016 at 02:26:57PM +0100, Oleg Nesterov wrote:
> Starting from a194f3e0 "implement __builtin_offsetof()" sparse handles
> offsetof() internally but dissect.c wasn't updated.
> 

LGTM

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
