From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect type when ealing with union type
Date: Sun, 19 Mar 2017 15:54:13 +0000
Message-ID: <CACXZuxfwJbuFuXuJNDRwPjvECT1zorhkebDur8w0+Wj6=Tp71g@mail.gmail.com>
References: <CACXZuxcb=27brA9N=w-tnZ9V0StKnDYZ4y27cS6eoenA7S0ctw@mail.gmail.com>
 <20170319153609.yykbjbbb6v4lw4xb@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:36805 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdCSPzS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:55:18 -0400
Received: by mail-it0-f50.google.com with SMTP id w124so66347861itb.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:54:14 -0700 (PDT)
In-Reply-To: <20170319153609.yykbjbbb6v4lw4xb@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 19 March 2017 at 15:36, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Mar 13, 2017 at 10:54:01PM +0000, Dibyendu Majumdar wrote:
>> I am investigating a type error in LLVM. Here is the snippet of code:
>
> This seems to be fixed in the llvm-fixes-v3 serie I submitted yesterday.
> But I never saw exactly what was the specific problem here.
>

You will need to run code that uses union types extensively. For
example please try to compile:

https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/minilua/minilua.c

Regards
Dibyendu
