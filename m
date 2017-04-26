From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] llvm: add script to display the deserialized LLVM IR
Date: Wed, 26 Apr 2017 04:11:21 +0200
Message-ID: <CAMHZB6HsOF+bO=FMXkX1MbBneAZRqC=07MDUG5hzgDLbVAma8w@mail.gmail.com>
References: <CACXZuxe9ioYu5fuZK=-iDdiL8RQpE37GvpE9s5DHjFYPCrKKfg@mail.gmail.com>
 <20170311115813.23249-1-luc.vanoostenryck@gmail.com> <CANeU7Q=B=+j1YmbmH1=wkoxizVm0Tu8+PQLJQ5j_UMKv2n-V9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34566 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1950189AbdDZCLW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 25 Apr 2017 22:11:22 -0400
Received: by mail-qk0-f179.google.com with SMTP id y63so131559059qkd.1
        for <linux-sparse@vger.kernel.org>; Tue, 25 Apr 2017 19:11:22 -0700 (PDT)
In-Reply-To: <CANeU7Q=B=+j1YmbmH1=wkoxizVm0Tu8+PQLJQ5j_UMKv2n-V9g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Tue, Apr 25, 2017 at 10:43 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Mar 11, 2017 at 7:58 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> The goal is to use this in some of test cases, by comparing
>> the expected output with the actual one.
>>
>
> Looks good. You might want to check llvm-dis and sparse-llvm is
> there. I assume this script will not be invoked if llvm is not there
> so it is not a big deal.
>
> Chris

Yes, it need sparse-llvm anyway.

OTOH, there is no users for this script so it can kept on hold too.

-- Luc
