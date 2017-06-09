From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/3] kill dead loads
Date: Fri, 9 Jun 2017 00:46:52 -0700
Message-ID: <CANeU7QkMjuc2rvT+ervdFmFOCSSzZHg7Y+h-5TX=zf+XF-pw=g@mail.gmail.com>
References: <20170608073927.55218-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:34278 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdFIHrD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 9 Jun 2017 03:47:03 -0400
Received: by mail-io0-f170.google.com with SMTP id i7so29899505ioe.1
        for <linux-sparse@vger.kernel.org>; Fri, 09 Jun 2017 00:47:03 -0700 (PDT)
In-Reply-To: <20170608073927.55218-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 8, 2017 at 12:39 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is to eliminate dead loads which,
> especially the deadborn ones which, until now, weren't
> removed.
>
> This series is also available in the git repository at:
>   git://github.com/lucvoo/sparse.git kill-dead-loads

This 3 patch looks good to me.

Thanks,

Chris
