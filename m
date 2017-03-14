From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm results from trying to compile a largish program
Date: Tue, 14 Mar 2017 15:56:24 +0000
Message-ID: <CACXZuxfzhU7tzsbRz_Yp+r3PCqvxMr9MRgCV3JKyjrzMLxJ5hA@mail.gmail.com>
References: <CACXZuxdT9fXHnysUFUoMqe+dEuDSKHsQS3Tn8KFEfAP2cnAnJA@mail.gmail.com>
 <CACXZuxf02DM+spQckV0CyycaY7dqUbuM9wuKNktaRMndvtfpBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:35011 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbdCNP40 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 11:56:26 -0400
Received: by mail-io0-f170.google.com with SMTP id z13so2265831iof.2
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 08:56:25 -0700 (PDT)
In-Reply-To: <CACXZuxf02DM+spQckV0CyycaY7dqUbuM9wuKNktaRMndvtfpBQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 14 March 2017 at 13:17, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> I tried to compile a Lua implementation using sparse-llvm. This
>> particular implementation is called 'minilua' as it is a cut down
>> version of Lua 5.1.5 created by Mike Pall for the LuaJIT project.
>>
> I have fixed a bunch of issues in my repository - and the updated
> error list now is much reduced! Please see the link above for the
> remaining errors and the generated code.
>

The code now compiles without errors but crashes when run!

Regards
