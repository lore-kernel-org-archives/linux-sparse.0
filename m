From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/3] fix discarded label statement
Date: Fri, 18 Nov 2016 01:19:55 +0800
Message-ID: <CANeU7QmdMw4QJuygFeCB_xa=-Y9fqG2cD4iLOgG0zneQdS0+Fw@mail.gmail.com>
References: <20161110144520.24965-1-luc.vanoostenryck@gmail.com> <20161110144520.24965-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38367 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935054AbcKQRUC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:20:02 -0500
Received: by mail-it0-f49.google.com with SMTP id j191so63969301ita.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:20:01 -0800 (PST)
In-Reply-To: <20161110144520.24965-4-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 10, 2016 at 10:45 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The patch fix this by simply moving the code handling the statement out
> of the conditional part processing used labels.

Great catch.

Applied.

Chris
