From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/4] add support for a new flag: -fdump-linearize[=only]
Date: Fri, 7 Apr 2017 20:52:01 +0200
Message-ID: <CAExDi1SzVOyi5LS2HS6cf02Tj5ONzk4JUM94BWgzHkU2vOfC8A@mail.gmail.com>
References: <20170406230029.11384-1-luc.vanoostenryck@gmail.com>
 <20170406230029.11384-2-luc.vanoostenryck@gmail.com> <CACXZuxddGHr6xx7KC93Lw-bVoexwmuFQwuE2qsQ3yO6bGBehXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34710 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755393AbdDGSwD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Apr 2017 14:52:03 -0400
Received: by mail-qt0-f180.google.com with SMTP id c45so26356834qtb.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Apr 2017 11:52:03 -0700 (PDT)
In-Reply-To: <CACXZuxddGHr6xx7KC93Lw-bVoexwmuFQwuE2qsQ3yO6bGBehXg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Apr 7, 2017 at 2:32 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> On 7 April 2017 at 00:00, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> The effect of this flag is to dump the IR just after the
>> linearization, before any simplification, and to stop
>> further processing if '=only' is given as argument.
>>
>> The motivation of this flag is of course for debugging,
>> to be able to inspect the raw result of the linearization,
>> undisturbed by a simplification.
>>
>
> In my view it is better to use the existing -O<n> option to control
> whether or not simplifications are done.

But controlling whether or not simplifications (which one?) are done
is not what this new flag is all about.

-- Luc
