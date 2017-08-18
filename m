From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 28/29] sssa: switch to the new SSA construction
Date: Fri, 18 Aug 2017 17:47:57 -0400
Message-ID: <CANeU7Qnag6mAy-opTWoM-pzGaipgVZxMTrEHzjXOgWWqmrT2SA@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com> <20170816153455.97693-29-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34786 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbdHRVr6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 17:47:58 -0400
Received: by mail-yw0-f181.google.com with SMTP id s143so66259043ywg.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 14:47:58 -0700 (PDT)
In-Reply-To: <20170816153455.97693-29-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This patch makes the needed changes in the linearization
> to use the new SA construction method.

You mean SSA construction method :-)

Chris
