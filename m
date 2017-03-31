From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v6 00/52] LLVM fixes
Date: Fri, 31 Mar 2017 10:56:19 +0200
Message-ID: <CAExDi1QxU+F7UUFya92Wa1632waU2j0uXkq7Fn++hUuTGV-ZLA@mail.gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
 <CANeU7QnNAHbE3fto09=2jsDS2vnNscA9sieG263=ck8LZ6j6Kw@mail.gmail.com> <CANeU7Qke86a7McF9EM96Ezv-Otd1ew8Lh2xvX=z7k8pc-UMfig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33159 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbdCaI4V (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 04:56:21 -0400
Received: by mail-qt0-f171.google.com with SMTP id i34so60000922qtc.0
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 01:56:20 -0700 (PDT)
In-Reply-To: <CANeU7Qke86a7McF9EM96Ezv-Otd1ew8Lh2xvX=z7k8pc-UMfig@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 31, 2017 at 7:32 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Mar 31, 2017 at 1:28 PM, Christopher Li <sparse@chrisli.org> wrote:
>> V4 has 63 patches. V5 has 51 and V6 has 52 patches.
>>
>> I assume I just drop the 63 patches in V4 and use the 52 patches instead?
>>
>
> Ah, I see what you are doing. V6 has 1-15 and 1-52 two series..

Yes, I extracted the non-LLVM specific part in a separate series.

Luc
