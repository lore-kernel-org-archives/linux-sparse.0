From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/6] teach sparse how to dump macro definitions
Date: Wed, 31 May 2017 23:56:41 -0700
Message-ID: <CANeU7Qkukj_K+PtoSezYkN=t_53oy=a7Amp2n0m5RA+owxKtZQ@mail.gmail.com>
References: <20170404214955.47926-1-luc.vanoostenryck@gmail.com> <20170404214955.47926-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34429 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdFAG4m (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 02:56:42 -0400
Received: by mail-io0-f175.google.com with SMTP id k91so27768636ioi.1
        for <linux-sparse@vger.kernel.org>; Wed, 31 May 2017 23:56:42 -0700 (PDT)
In-Reply-To: <20170404214955.47926-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Apr 4, 2017 at 2:49 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> diff --git a/pre-process.c b/pre-process.c
> index 7c57ba1cd..74414dfeb 100644
> --- a/pre-process.c
> +++ b/pre-process.c
> @@ -44,6 +44,7 @@
>  #include "expression.h"
>  #include "scope.h"
>
> +static struct ident_list *macros;      // only needed for -dD

I think the macros list should be initialized as NULL.

Chris
