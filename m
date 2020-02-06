From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] dissect: introduce dissect_ctx
Date: Thu, 6 Feb 2020 21:45:18 +0100
Message-ID: <20200206204518.qx5qtyl52al37njy@ltop.local>
References: <20200206170132.GA8908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52190 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFUpU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Feb 2020 15:45:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so337201wmi.1
        for <linux-sparse@vger.kernel.org>; Thu, 06 Feb 2020 12:45:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200206170132.GA8908@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Thu, Feb 06, 2020 at 06:01:32PM +0100, Oleg Nesterov wrote:
> Points to the current function or to the global variable in case of
> compound initializer.
> 
> Kill the ugly test-dissect.c:storage() and change print_usage() to
> report dissect_ctx->ident instead.

Having the ful ident will be good, I think, but the cost is to have
to maintain this context. I suppose it would be too painful to 
propgate this context via an additional argument to all involved
functions?

-- Luc 
