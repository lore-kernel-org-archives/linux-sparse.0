From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] avoid crash with test-linearize -vv
Date: Thu, 23 Mar 2017 20:03:36 -0700
Message-ID: <CANeU7QnSaE6TsnRLXAufpcczd4ouaRKK+vSQm_r8YC9A0Rv-sw@mail.gmail.com>
References: <20170319180118.83953-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35377 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935255AbdCXDDi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Mar 2017 23:03:38 -0400
Received: by mail-io0-f181.google.com with SMTP id z13so9596115iof.2
        for <linux-sparse@vger.kernel.org>; Thu, 23 Mar 2017 20:03:37 -0700 (PDT)
In-Reply-To: <20170319180118.83953-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sun, Mar 19, 2017 at 11:01 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> When verbose is set to 2 or higher, show_instruction()
> also display removed instructions. Some of these instructions
> can have their associated symbol removed and set to NULL
> which will cause a crash with 'test-linearize -vv'.
>
> Fix this by avoiding to dereference symbol's details of
> removed instructions.

I like to apply it. Can you add SOB?

Thanks

Chris
