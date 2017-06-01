From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/6] teach sparse how to dump macro definitions
Date: Thu, 1 Jun 2017 16:08:02 +0200
Message-ID: <CAExDi1Q=_0YJFU=-oYH1Wp4ZqjRW7WODt6foUHxen1_2EXamWA@mail.gmail.com>
References: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
 <20170404214955.47926-3-luc.vanoostenryck@gmail.com> <CANeU7Qkukj_K+PtoSezYkN=t_53oy=a7Amp2n0m5RA+owxKtZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33762 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdFAOIE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 10:08:04 -0400
Received: by mail-qk0-f193.google.com with SMTP id c206so5831099qkb.0
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 07:08:03 -0700 (PDT)
In-Reply-To: <CANeU7Qkukj_K+PtoSezYkN=t_53oy=a7Amp2n0m5RA+owxKtZQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 1, 2017 at 8:56 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Apr 4, 2017 at 2:49 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> diff --git a/pre-process.c b/pre-process.c
>> index 7c57ba1cd..74414dfeb 100644
>> --- a/pre-process.c
>> +++ b/pre-process.c
>> @@ -44,6 +44,7 @@
>>  #include "expression.h"
>>  #include "scope.h"
>>
>> +static struct ident_list *macros;      // only needed for -dD
>
> I think the macros list should be initialized as NULL.

It certainly doesn't need to be explicitly initialized to NULL since
all top-level variables that are not explicitly initialized are initialized
to zero by the environment before main() is called.

-- Luc
